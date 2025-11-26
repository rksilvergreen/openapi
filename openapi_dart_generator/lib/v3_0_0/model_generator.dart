import 'dart:io';

import 'package:code_builder/code_builder.dart' show Class, Enum, Spec, TypeReference, Reference, ClassModifier, DartEmitter;
import 'package:recase/recase.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/openapi_document.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/schema/schema_object.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/enums.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/referenceable.dart';

import '../../processor/schema_discoverer.dart';
import '../../processor/schema_classifier.dart';
import '../../processor/composition_analyzer.dart';
import 'dart_name_generator.dart';
import 'dart_type_mapper.dart';
import 'object_class_generator.dart';
import 'enum_generator.dart';
import 'file_writer.dart';
import 'union_generator.dart';
import 'pattern_orchestrator.dart';
import 'variant_class_generator.dart';

/// Main orchestrator for model code generation from OpenAPI documents.
class ModelGenerator {
  final String outputDirectory;
  final String? baseDirectory;

  ModelGenerator(this.outputDirectory, {this.baseDirectory});

  /// Generate Dart model classes from an OpenAPI document.
  Future<void> generate(OpenApiDocument document) async {
    print('Discovering schemas...');
    final discoverer = SchemaDiscoverer(baseDirectory: baseDirectory);
    List<SchemaMetadata> schemas;
    try {
      schemas = discoverer.discover(document);
    } catch (e, stackTrace) {
      throw Exception(
        'Error discovering schemas: $e\n'
        'Stack trace: $stackTrace\n'
        'Base directory: ${baseDirectory ?? "not set"}',
      );
    }
    print('Found ${schemas.length} schema(s)');

    print('Classifying schemas...');
    // Build schema registry first for classifier
    // Use schema name from location (e.g., "Animal" from components/schemas/Animal)
    final earlySchemaRegistry = <String, SchemaObject>{};
    for (final schema in schemas) {
      // Try to get name from title first, then from location path
      String? schemaName = schema.schema.title;
      if (schemaName == null && schema.location.path.isNotEmpty) {
        // Extract schema name from location path (e.g., "#/components/schemas/Animal" → "Animal")
        final pathParts = schema.location.path.split('/');
        if (pathParts.isNotEmpty) {
          schemaName = pathParts.last;
        }
      }
      if (schemaName != null) {
        earlySchemaRegistry[schemaName] = schema.schema;
      }
    }

    final classifier = SchemaClassifier(schemaRegistry: earlySchemaRegistry);
    final nameGenerator = DartNameGenerator();
    final modelsToGenerate = <SchemaMetadata>[];

    for (var i = 0; i < schemas.length; i++) {
      final schema = schemas[i];
      try {
        schema.classification = classifier.classify(schema.schema);
        if (_shouldGenerateModel(schema)) {
          nameGenerator.generateNames(schema);
          modelsToGenerate.add(schema);
        }
      } catch (e, stackTrace) {
        final location = _formatSchemaLocation(schema);
        final yamlPath = _buildYamlPath(schema);
        throw Exception(
          'Error processing schema at index $i:\n'
          '  YAML Location: $yamlPath\n'
          '  Schema Location: $location\n'
          '  Reference: ${schema.referenceString ?? "none"}\n'
          '  File: ${_getSchemaFile(schema)}\n'
          '  Error: $e\n'
          '  Stack trace: $stackTrace',
        );
      }
    }

    print('Generating ${modelsToGenerate.length} model(s)...');

    // Create output directory
    final modelsDir = Directory('$outputDirectory/models');
    if (!modelsDir.existsSync()) {
      modelsDir.createSync(recursive: true);
    }

    final genDir = Directory('$outputDirectory/models/_gen');
    if (!genDir.existsSync()) {
      genDir.createSync(recursive: true);
    }

    // Build schema class names map for type mapper
    final schemaClassNames = <String, String>{};
    for (final schema in modelsToGenerate) {
      if (schema.schema.title != null) {
        schemaClassNames[schema.schema.title!] = schema.className!;
      }
    }

    // Group inline enums and unions with their parent schemas
    final inlineEnumsByParent = <String, List<SchemaMetadata>>{};
    final inlineUnionsByParent = <String, List<SchemaMetadata>>{};
    final standaloneSchemas = <SchemaMetadata>[];

    for (final schema in modelsToGenerate) {
      final isInline =
          schema.location.type == SchemaLocationType.nestedProperty && schema.location.propertyChain.isNotEmpty;
      final isEnum = schema.classification == ModelType.enum_;
      final isUnion =
          schema.classification == ModelType.discriminatorInterface ||
          schema.classification == ModelType.oneOfInterface ||
          schema.classification == ModelType.primitiveUnion;

      if (isInline && (isEnum || isUnion)) {
        // This is an inline enum or union - find its parent
        final parentPath = schema.location.path;
        final parentPropertyChain = schema.location.propertyChain
            .take(schema.location.propertyChain.length - 1)
            .toList();

        // Find the parent schema
        SchemaMetadata? parentSchema;
        for (final candidate in modelsToGenerate) {
          if (candidate.location.path == parentPath && candidate.location.type != SchemaLocationType.nestedProperty) {
            // This is likely the parent (component schema)
            parentSchema = candidate;
            break;
          } else if (candidate.location.type == SchemaLocationType.nestedProperty &&
              candidate.location.path == parentPath &&
              _propertyChainsMatch(candidate.location.propertyChain, parentPropertyChain)) {
            // This is a nested parent
            parentSchema = candidate;
            break;
          }
        }

        if (parentSchema != null) {
          final parentKey = '${parentSchema.fileName}_${parentSchema.className}';
          if (isEnum) {
            inlineEnumsByParent.putIfAbsent(parentKey, () => []).add(schema);
          } else if (isUnion) {
            inlineUnionsByParent.putIfAbsent(parentKey, () => []).add(schema);
          }
        } else {
          // Couldn't find parent, generate as standalone
          standaloneSchemas.add(schema);
        }
      } else {
        standaloneSchemas.add(schema);
      }
    }

    // Build inline enum and union names maps for type mapper
    final inlineEnumNames = <String, String>{};
    for (final entry in inlineEnumsByParent.entries) {
      for (final inlineEnum in entry.value) {
        // Create a property path key: parentClassName.propertyName
        final parentKey = entry.key;
        final parentParts = parentKey.split('_');
        final parentClassName = parentParts.length > 1
            ? parentParts.sublist(0, parentParts.length - 1).map((p) => ReCase(p).pascalCase).join('')
            : ReCase(parentParts[0]).pascalCase;
        final propertyName = inlineEnum.location.propertyChain.isNotEmpty
            ? inlineEnum.location.propertyChain.last
            : 'unknown';
        final propertyPath = '$parentClassName.${ReCase(propertyName).camelCase}';
        inlineEnumNames[propertyPath] = inlineEnum.className!;
      }
    }

    final inlineUnionNames = <String, String>{};
    for (final entry in inlineUnionsByParent.entries) {
      for (final inlineUnion in entry.value) {
        // Create a property path key: parentClassName.propertyName
        final parentKey = entry.key;
        final parentParts = parentKey.split('_');
        final parentClassName = parentParts.length > 1
            ? parentParts.sublist(0, parentParts.length - 1).map((p) => ReCase(p).pascalCase).join('')
            : ReCase(parentParts[0]).pascalCase;
        final propertyName = inlineUnion.location.propertyChain.isNotEmpty
            ? inlineUnion.location.propertyChain.last
            : 'unknown';
        final propertyPath = '$parentClassName.${ReCase(propertyName).camelCase}';
        inlineUnionNames[propertyPath] = inlineUnion.className!;
      }
    }

    final typeMapper = DartTypeMapper(
      schemaClassNames,
      inlineEnumNames: inlineEnumNames,
      inlineUnionNames: inlineUnionNames,
    );
    final objectGenerator = ObjectClassGenerator(
      typeMapper,
      inlineEnumNames: inlineEnumNames,
      inlineUnionNames: inlineUnionNames,
    );
    final enumGenerator = EnumGenerator();
    final unionGenerator = UnionGenerator(typeMapper);
    final fileWriter = FileWriter();

    // Build schema registry for pattern orchestrator
    final schemaRegistry = <String, SchemaObject>{};
    final schemaMetadataMap = <String, SchemaMetadata>{};
    for (final schema in modelsToGenerate) {
      if (schema.className != null) {
        schemaRegistry[schema.className!] = schema.schema;
        schemaMetadataMap[schema.className!] = schema;
      }
    }

    final compositionAnalyzer = CompositionAnalyzer(schemaRegistry: schemaRegistry);
    
    // Discover descendants (schemas that extend other concrete schemas via allOf)
    // This map will be updated during pattern generation for complex allOf combinations
    final descendants = <String, List<String>>{}; // parent class -> list of children classes
    final descendantsRequiredPropsGlobal = <String, List<String>>{}; // class -> required properties
    final patternOrchestrator = PatternOrchestrator(
      schemaMetadataMap: schemaMetadataMap,
      schemaRegistry: schemaRegistry,
      descendants: descendants,
      descendantsRequiredProps: descendantsRequiredPropsGlobal,
    );

    // Discover which schemas should implement which interfaces
    // This is needed for oneOf/anyOf patterns where referenced schemas need to implement the parent interface
    final interfaceImplementations = <String, List<String>>{}; // schema -> list of interfaces to implement

    for (final schema in modelsToGenerate) {
      if (schema.className == null) continue;

      // Check if this is a oneOf/anyOf interface
      if (schema.classification == ModelType.oneOfInterface ||
          schema.classification == ModelType.discriminatorInterface ||
          schema.classification == ModelType.primitiveUnion) {
        // Find all schemas referenced in this union
        final variants = schema.schema.anyOf ?? schema.schema.oneOf ?? [];
        for (final variantRef in variants) {
          if (variantRef.isReference()) {
            final refString = variantRef.asReference();
            if (refString != null) {
              final variantClassName = refString.split('/').last;
              interfaceImplementations.putIfAbsent(variantClassName, () => []).add(schema.className!);
            }
          }
        }
      }

      // Check discriminator children
      if (schema.classification == ModelType.discriminatorInterface) {
        final children = compositionAnalyzer.discoverDiscriminatorChildren(schema.className!, schema.schema);
        for (final child in children) {
          interfaceImplementations.putIfAbsent(child, () => []).add(schema.className!);
        }
      }
    }

    print('  Interface implementations discovered: ${interfaceImplementations.length} schemas implementing interfaces');

    // Discover descendants (schemas that extend other concrete schemas via allOf)
    for (final schema in modelsToGenerate) {
      if (schema.className == null || schema.schema.allOf == null) continue;
      
      final analysis = compositionAnalyzer.analyzeAllOf(schema.schema.allOf!);
      if (analysis.isInheritance && analysis.baseSchema != null && schema.schema.allOf![0].isReference()) {
        final parentRef = schema.schema.allOf![0].asReference()!;
        final parentClassName = parentRef.split('/').last;
        
        // Only track if parent is not an interface (interfaces are handled separately)
        final parentMetadata = schemaMetadataMap[parentClassName];
        if (parentMetadata != null && 
            parentMetadata.classification != ModelType.oneOfInterface &&
            parentMetadata.classification != ModelType.discriminatorInterface &&
            parentMetadata.classification != ModelType.primitiveUnion) {
          descendants.putIfAbsent(parentClassName, () => []).add(schema.className!);
        }
      }
    }
    
    print('  Descendants discovered: ${descendants.length} classes with descendants');

    // Generate each model
    final generatedFileNames = <String>[];
    final generatedClassNames = <String>{}; // Track all generated class names for import detection

    // Pre-generate complex allOf patterns to discover all combination classes and update descendants map
    print('  Pre-generating complex patterns to discover all descendants...');
    for (final schema in standaloneSchemas) {
      if (schema.classification == ModelType.complexAllOf || 
          schema.classification == ModelType.allOfOneOf ||
          schema.classification == ModelType.hybrid) {
        try {
          // Generate pattern specs (this will update the descendants map via PatternOrchestrator)
          final preSpecs = patternOrchestrator.generatePattern(metadata: schema, name: schema.className!);
          // Extract class names from pre-generated specs and add to generatedClassNames
          for (final spec in preSpecs) {
            final className = _getClassNameFromSpec(spec);
            if (className != null) {
              generatedClassNames.add(className);
            }
          }
        } catch (e) {
          // Ignore errors during pre-generation
        }
      }
    }
    print('  Total descendants after pre-generation: ${descendants.entries.map((e) => '${e.key}: ${e.value.length}').join(', ')}');

    for (final schema in standaloneSchemas) {
      try {
        print('  Generating ${schema.className} (${schema.fileName}.dart) [${schema.classification}]...');

        // Check if this schema has inline enums and unions
        final schemaKey = '${schema.fileName}_${schema.className}';
        final inlineEnums = inlineEnumsByParent[schemaKey] ?? [];
        final inlineUnions = inlineUnionsByParent[schemaKey] ?? [];

        // classOrEnum can be either a single Spec or a List<Spec> (for hybrid patterns)
        dynamic classOrEnum;

        switch (schema.classification!) {
          case ModelType.enum_:
            classOrEnum = enumGenerator.generateEnum(schema.schema, schema.className!);
            break;

          case ModelType.object:
            // Check if this schema should implement any interfaces
            final interfacesToImplement = (interfaceImplementations[schema.className!] ?? []).toSet().toList();

            if (interfacesToImplement.isNotEmpty) {
              // Check if any interface is a discriminator interface
              String? discriminatorProperty;
              String? discriminatorValue;
              
              for (final interfaceName in interfacesToImplement) {
                // Find the interface schema
                final interfaceSchema = modelsToGenerate.firstWhere(
                  (m) => m.className == interfaceName,
                  orElse: () => schema,
                );
                
                // Check if it has a discriminator
                if (interfaceSchema.schema.discriminator != null) {
                  discriminatorProperty = interfaceSchema.schema.discriminator!.propertyName;
                  discriminatorValue = compositionAnalyzer.getDiscriminatorValue(
                    schema.className!,
                    interfaceSchema.schema.discriminator!.mapping,
                  );
                  break; // Use the first discriminator interface found
                }
              }
              
              // Use VariantClassGenerator to generate class with implements
              print('    Implementing interfaces: ${interfacesToImplement.join(", ")}');
              
              // Check if this class has descendants
              final classDescendants = descendants[schema.className];
              final descendantsRequiredProps = <String, List<String>>{};
              if (classDescendants != null) {
                for (final descendantName in classDescendants) {
                  // First check if required props were tracked during complex allOf generation
                  if (descendantsRequiredPropsGlobal.containsKey(descendantName)) {
                    descendantsRequiredProps[descendantName] = descendantsRequiredPropsGlobal[descendantName]!;
                  } else {
                    // Otherwise resolve from schema metadata
                    final descendantMetadata = schemaMetadataMap[descendantName];
                    if (descendantMetadata != null) {
                      descendantsRequiredProps[descendantName] = compositionAnalyzer.resolveAllRequired(
                        descendantMetadata.schema,
                      );
                    }
                  }
                }
                print('    Has ${classDescendants.length} descendant(s): ${classDescendants.join(", ")}');
              }
              
              final variantGenerator = VariantClassGenerator();
              classOrEnum = variantGenerator.generateVariantClass(
                className: schema.className!,
                schema: schema.schema,
                interfaces: interfacesToImplement,
                discriminatorProperty: discriminatorProperty,
                discriminatorValue: discriminatorValue,
                descendants: classDescendants,
                descendantsRequiredProps: descendantsRequiredProps,
              );
            } else {
              // Simple object class without interfaces - check if it has descendants
              final classDescendants = descendants[schema.className];
              if (classDescendants != null && classDescendants.isNotEmpty) {
                // This class has descendants, use VariantClassGenerator to support custom fromJson
                final descendantsRequiredProps = <String, List<String>>{};
                for (final descendantName in classDescendants) {
                  // First check if required props were tracked during pattern generation
                  if (descendantsRequiredPropsGlobal.containsKey(descendantName)) {
                    descendantsRequiredProps[descendantName] = descendantsRequiredPropsGlobal[descendantName]!;
                  } else {
                    // Otherwise resolve from schema metadata
                    final descendantMetadata = schemaMetadataMap[descendantName];
                    if (descendantMetadata != null) {
                      descendantsRequiredProps[descendantName] = compositionAnalyzer.resolveAllRequired(
                        descendantMetadata.schema,
                      );
                    }
                  }
                }
                print('    Has ${classDescendants.length} descendant(s): ${classDescendants.join(", ")}');
                
                final variantGenerator = VariantClassGenerator();
                classOrEnum = variantGenerator.generateVariantClass(
                  className: schema.className!,
                  schema: schema.schema,
                  interfaces: [], // No interfaces
                  descendants: classDescendants,
                  descendantsRequiredProps: descendantsRequiredProps,
                );
              } else {
                // No descendants, use simple object generator
                classOrEnum = objectGenerator.generateClass(schema.schema, schema.className!);
              }
            }
            break;

          case ModelType.simpleAllOf:
            // Handle allOf
            final analysis = compositionAnalyzer.analyzeAllOf(schema.schema.allOf!);
            // Store whether this is actually inheritance (first item is a reference)
            schema.isActualInheritance = analysis.isInheritance && analysis.baseSchema != null;

            if (analysis.isInheritance && analysis.baseSchema != null) {
              // Check if the parent is a discriminator schema
              String? parentClassName;
              SchemaObject? parentSchema;

              if (schema.schema.allOf![0].isReference()) {
                final baseRef = schema.schema.allOf![0].asReference()!;
                parentClassName = baseRef.split('/').last;
                parentSchema = schemaRegistry[parentClassName];
              }

              // If parent has discriminator, use VariantClassGenerator with discriminator field
              if (parentSchema != null && parentSchema.discriminator != null) {
                print('    Parent $parentClassName is a discriminator schema - generating as variant');

                // Get discriminator value for this child
                final discriminatorValue = compositionAnalyzer.getDiscriminatorValue(
                  schema.className!,
                  parentSchema.discriminator!.mapping,
                );

                // Get parent properties to merge
                final parentProperties = parentSchema.properties ?? {};
                final parentRequired = parentSchema.required_;

                final variantGenerator = VariantClassGenerator();
                classOrEnum = variantGenerator.generateVariantClass(
                  className: schema.className!,
                  schema: analysis.mergedSchema,
                  interfaces: [parentClassName!],
                  discriminatorProperty: parentSchema.discriminator!.propertyName,
                  discriminatorValue: discriminatorValue,
                  parentProperties: parentProperties.map((k, v) => MapEntry(k, v.asValue()!)),
                  parentRequired: parentRequired,
                );
              } else {
                // Regular inheritance
                // Check if this schema should also implement interfaces (e.g., it's a variant of a oneOf)
                final interfacesToImplement = interfaceImplementations[schema.className!] ?? [];
                
                // In the new hierarchy model, we NEVER use extends except for Equatable
                // All allOf relationships use implements with field duplication
                final baseClassType = typeMapper.mapSchemaToType(analysis.baseSchema!);
                final baseClassName = baseClassType.symbol;
                
                // Resolve base schema for parent properties to duplicate
                SchemaObject? resolvedBaseSchema;
                Map<String, SchemaObject>? parentProperties;
                List<String>? parentRequired;
                
                if (schema.schema.allOf![0].isReference()) {
                  final baseRef = schema.schema.allOf![0].asReference()!;
                  resolvedBaseSchema = _resolveBaseSchemaRecursive(baseRef, schemas, compositionAnalyzer);
                  if (resolvedBaseSchema != null) {
                    parentProperties = resolvedBaseSchema.properties?.map((k, v) => MapEntry(k, v.asValue()!));
                    parentRequired = resolvedBaseSchema.required_;
                    print('    Found base schema: props: ${resolvedBaseSchema.properties?.keys.join(", ")}');
                  }
                }
                
                // Combine base interface with any additional interfaces
                // Deduplicate to avoid implementing the same interface twice
                final allInterfaces = <String>{};
                if (baseClassName != null && baseClassName != 'Equatable') {
                  allInterfaces.add(baseClassName);
                }
                allInterfaces.addAll(interfacesToImplement);
                final uniqueInterfaces = allInterfaces.toList();
                
                if (uniqueInterfaces.isNotEmpty) {
                  print('    Implementing interfaces: ${uniqueInterfaces.join(", ")}');
                  
                  // Check if this class has descendants
                  final classDescendants = descendants[schema.className];
                  final descendantsRequiredProps = <String, List<String>>{};
                  if (classDescendants != null) {
                    for (final descendantName in classDescendants) {
                      // First check if required props were tracked during complex allOf generation
                      if (descendantsRequiredPropsGlobal.containsKey(descendantName)) {
                        descendantsRequiredProps[descendantName] = descendantsRequiredPropsGlobal[descendantName]!;
                      } else {
                        // Otherwise resolve from schema metadata
                        final descendantMetadata = schemaMetadataMap[descendantName];
                        if (descendantMetadata != null) {
                          descendantsRequiredProps[descendantName] = compositionAnalyzer.resolveAllRequired(
                            descendantMetadata.schema,
                          );
                        }
                      }
                    }
                    print('    Has ${classDescendants.length} descendant(s): ${classDescendants.join(", ")}');
                  }
                  
                  final variantGenerator = VariantClassGenerator();
                  classOrEnum = variantGenerator.generateVariantClass(
                    className: schema.className!,
                    schema: analysis.mergedSchema,
                    interfaces: uniqueInterfaces,
                    parentProperties: parentProperties,
                    parentRequired: parentRequired,
                    descendants: classDescendants,
                    descendantsRequiredProps: descendantsRequiredProps,
                  );
                } else {
                  // No interfaces, just a regular class with merged properties
                  classOrEnum = objectGenerator.generateClass(
                    analysis.mergedSchema,
                    schema.className!,
                  );
                }
              }
            } else {
              // Use composition (merge all properties)
              classOrEnum = objectGenerator.generateClass(analysis.mergedSchema, schema.className!);
            }
            break;

          case ModelType.discriminatorInterface:
          case ModelType.oneOfInterface:
          case ModelType.primitiveUnion:
            // Generate using PatternOrchestrator
            // Primitive union patterns generate: interface + wrapper classes + inline variants (all in one file)
            try {
              // Get parent interfaces for this interface
              final parentInterfaces = interfaceImplementations[schema.className!];
              final patternSpecs = patternOrchestrator.generatePattern(
                metadata: schema,
                name: schema.className!,
                parentInterfaces: parentInterfaces,
              );

              if (patternSpecs.isEmpty) {
                throw Exception('Primitive union pattern generation produced no specs');
              }

              // For primitive union, patternSpecs contains: [wrappers/variants..., interface]
              // We'll return all of them as a list for multi-spec file generation
              classOrEnum = patternSpecs;
              print('    Generated primitive union with ${patternSpecs.length} spec(s)');
            } catch (e) {
              print('    Warning: Failed to generate primitive union pattern: $e');
              print('    Falling back to old union generator');
              // Fallback to old union generator
              try {
                final unionAnalysis = compositionAnalyzer.analyzeUnion(schema.schema);
                final unionSpecs = unionGenerator.generateUnion(
                  schema: schema.schema,
                  unionName: schema.className!,
                  variants: unionAnalysis.variants,
                  isOneOf: unionAnalysis.isOneOf,
                  discriminatorProperty: unionAnalysis.discriminatorProperty,
                  discriminatorMapping: unionAnalysis.discriminatorMapping,
                );

                if (unionSpecs.isNotEmpty) {
                  classOrEnum = unionSpecs.first;
                } else {
                  classOrEnum = objectGenerator.generateClass(schema.schema, schema.className!);
                }
              } catch (e2) {
                print('    Fallback also failed: $e2');
                classOrEnum = objectGenerator.generateClass(schema.schema, schema.className!);
              }
            }
            break;

          case ModelType.hybrid:
            // Generate using PatternOrchestrator
            // Hybrid patterns generate: interface + wrapper classes (all in one file)
            try {
              final patternSpecs = patternOrchestrator.generatePattern(metadata: schema, name: schema.className!);

              if (patternSpecs.isEmpty) {
                throw Exception('Hybrid pattern generation produced no specs');
              }

              // For hybrid, patternSpecs contains: [interface, wrapper1, wrapper2, ...]
              // We'll return all of them as a list for multi-spec file generation
              classOrEnum = patternSpecs;
              print(
                '    Generated hybrid pattern with ${patternSpecs.length} spec(s): interface + ${patternSpecs.length - 1} wrapper(s)',
              );
            } catch (e) {
              print('    Warning: Failed to generate hybrid pattern: $e');
              print('    Falling back to simple object');
              classOrEnum = objectGenerator.generateClass(schema.schema, schema.className!);
            }
            break;

          case ModelType.complexAllOf:
            // Generate using PatternOrchestrator
            // Complex allOf generates: interface + all Cartesian product combinations
            try {
              final patternSpecs = patternOrchestrator.generatePattern(metadata: schema, name: schema.className!);

              if (patternSpecs.isEmpty) {
                throw Exception('Complex allOf pattern generation produced no specs');
              }

              // patternSpecs contains: [interface, combination1, combination2, ...]
              classOrEnum = patternSpecs;
              print(
                '    Generated complex allOf with ${patternSpecs.length} spec(s): interface + ${patternSpecs.length - 1} combination(s)',
              );
            } catch (e) {
              print('    Warning: Failed to generate complex allOf pattern: $e');
              print('    Falling back to simple object');
              classOrEnum = objectGenerator.generateClass(schema.schema, schema.className!);
            }
            break;

          case ModelType.allOfOneOf:
            // allOf + oneOf: oneOf reference + additional properties → Interface + wrapper classes
            final allOfOneOfSpecs = patternOrchestrator.generatePattern(
              metadata: schema,
              name: schema.className!,
            );
            classOrEnum = allOfOneOfSpecs;
            print('    Generated allOf + oneOf pattern with ${allOfOneOfSpecs.length} spec(s)');
            break;

          case ModelType.arrayWrapper:
            // Generate a wrapper class with a 'data' property containing the array
            // We need to wrap the entire array schema, not just the items
            final wrappedSchema = SchemaObject(
              type: SchemaType.object,
              properties: {'data': Referenceable.value(schema.schema)},
              required_: ['data'],
            );
            classOrEnum = objectGenerator.generateClass(wrappedSchema, schema.className!);
            break;

          case ModelType.simpleMap:
          case ModelType.primitive:
            // These shouldn't reach here due to _shouldGenerateModel filter
            continue;
        }

        // Determine relative imports - find referenced model classes
        // Also check inline unions for nested object schemas
        final relativeImports = _findRequiredImports(schema, modelsToGenerate, inlineUnions, compositionAnalyzer, interfaceImplementations);

        // Generate inline enums and unions for this schema
        // Handle both single Spec and List<Spec> (for hybrid patterns)
        final allSpecs = <Spec>[];
        if (classOrEnum is List<Spec>) {
          allSpecs.addAll(classOrEnum);
        } else {
          allSpecs.add(classOrEnum as Spec);
        }

        // Add inline enums
        for (final inlineEnum in inlineEnums) {
          print('    Adding inline enum ${inlineEnum.className}...');
          final enumSpec = enumGenerator.generateEnum(inlineEnum.schema, inlineEnum.className!);
          allSpecs.add(enumSpec);
        }

        // Add inline unions
        for (final inlineUnion in inlineUnions) {
          print('    Adding inline union ${inlineUnion.className}...');
          try {
            final unionAnalysis = compositionAnalyzer.analyzeUnion(inlineUnion.schema);
            final unionSpecs = unionGenerator.generateUnion(
              schema: inlineUnion.schema,
              unionName: inlineUnion.className!,
              variants: unionAnalysis.variants,
              isOneOf: unionAnalysis.isOneOf,
              discriminatorProperty: unionAnalysis.discriminatorProperty,
              discriminatorMapping: unionAnalysis.discriminatorMapping,
            );
            allSpecs.addAll(unionSpecs);
          } catch (e) {
            print('    Warning: Failed to generate inline union ${inlineUnion.className}: $e');
          }
        }

        // Write each spec to its own file
        // In the new hierarchy model, we NEVER extend custom base classes
        // All classes extend Equatable and implement interfaces
        final extendsCustomBaseClass = false;

        // First pass: collect all class names that will be generated
        final batchClassNames = <String>[];
        for (final spec in allSpecs) {
          final className = _getClassNameFromSpec(spec);
          if (className != null) {
            batchClassNames.add(className);
            generatedClassNames.add(className);
          }
        }

        // Second pass: write each spec to its own file
        for (final spec in allSpecs) {
          // Extract class name from spec
          final className = _getClassNameFromSpec(spec);
          if (className == null) {
            print('    Warning: Could not extract class name from spec, skipping...');
            continue;
          }

          // Generate file name from class name
          final fileName = ReCase(className).snakeCase;
          
          // Find imports needed for this specific spec
          // Pass generatedClassNames so we can detect imports for classes in the same batch
          final specImports = _findImportsForSpec(spec, modelsToGenerate, relativeImports, generatedClassNames);

          // Create library for this spec
          final library = fileWriter.createModelLibrary(
            fileName,
            spec,
            specImports,
            extendsCustomBaseClass: extendsCustomBaseClass,
          );

          // Write to file
          final filePath = '$outputDirectory/models/$fileName.dart';
          await fileWriter.writeLibrary(library, filePath);

          generatedFileNames.add(fileName);
          print('    Wrote ${className} to $fileName.dart');
        }
      } catch (e, stackTrace) {
        print('    ✗ Error generating ${schema.className ?? "unknown"}:');
        print('      Schema location: ${schema.location}');
        if (schema.referenceString != null) {
          print('      Reference: ${schema.referenceString}');
        }
        if (schema.fileName != null) {
          print('      File: ${schema.fileName}.dart');
        }
        print('      Error: $e');
        print('      Stack trace: $stackTrace');
        rethrow; // Re-throw to stop generation on errors
      }
    }

    print('✓ Generated ${generatedFileNames.length} model class(es)');
  }

  bool _propertyChainsMatch(List<String> chain1, List<String> chain2) {
    if (chain1.length != chain2.length) return false;
    for (var i = 0; i < chain1.length; i++) {
      if (chain1[i] != chain2[i]) return false;
    }
    return true;
  }

  bool _shouldGenerateModel(SchemaMetadata metadata) {
    // Skip simple primitives without enum
    if (metadata.classification == ModelType.primitive) {
      return false;
    }

    // Skip simple maps without title
    if (metadata.classification == ModelType.simpleMap && metadata.schema.title == null) {
      return false;
    }

    // Generate models for array wrappers
    if (metadata.classification == ModelType.arrayWrapper) {
      return true;
    }

    return true;
  }

  /// Extract class name from a Spec (Class or Enum).
  String? _getClassNameFromSpec(Spec spec) {
    if (spec is Class) {
      return spec.name;
    } else if (spec is Enum) {
      return spec.name;
    }
    return null;
  }

  /// Find imports needed for a specific spec.
  /// This includes imports for types referenced in the spec's fields, methods, etc.
  List<String> _findImportsForSpec(
    Spec spec,
    List<SchemaMetadata> modelsToGenerate,
    List<String> baseImports,
    Set<String> generatedClassNames,
  ) {
    final imports = <String>[];
    final className = _getClassNameFromSpec(spec);
    if (className == null) return imports;

    // Add baseImports for simple object classes (they need imports from schema analysis)
    // Don't add baseImports for variant/wrapper classes or interfaces - they only need their own imports
    // baseImports are for the parent schema and may include classes only needed in the interface's factory
    // Variant classes should only import what they actually use (implements, extends, fields, methods)
    // Interfaces don't need baseImports because they only reference variant classes in fromJson, not parent union types
    
      // Check if this is a variant/wrapper class (has implements or is a wrapper)
      final isVariantOrWrapper = spec is Class && (
        spec.implements.isNotEmpty || 
        (spec.name.endsWith('Value')) ||
        (spec.name.endsWith('Variant'))
      );
      
      // Check if this is an interface (abstract interface class)
      final isInterface = spec is Class && spec.abstract == true && spec.modifier == ClassModifier.interface;
      
      if (!isVariantOrWrapper && !isInterface) {
        // For simple object classes, add baseImports (from schema property analysis)
        for (final importPath in baseImports) {
          // Extract class name from import path (e.g., "person.dart" -> "Person")
          final fileName = importPath.replaceAll('.dart', '');
          final importedClassName = ReCase(fileName).pascalCase;
          
          // Only add import if it's not the current class
          if (importedClassName != className) {
            imports.add(importPath);
          }
        }
      }
      

    // Find additional imports by analyzing the spec
    if (spec is Class) {
      // Check implements
      for (final implement in spec.implements) {
        final interfaceName = implement.symbol;
        if (interfaceName != null && interfaceName != className) {
          final interfaceFileName = ReCase(interfaceName).snakeCase;
          final importPath = '$interfaceFileName.dart';
          if (!imports.contains(importPath)) {
            imports.add(importPath);
          }
        }
      }

      // Check extends
      if (spec.extend != null) {
        final baseName = spec.extend!.symbol;
        if (baseName != null && baseName != 'Equatable' && baseName != className) {
          final baseFileName = ReCase(baseName).snakeCase;
          final importPath = '$baseFileName.dart';
          if (!imports.contains(importPath)) {
            imports.add(importPath);
          }
        }
      }

      // Check fields
      for (final field in spec.fields) {
        final fieldType = field.type;
        if (fieldType != null) {
          _addImportForType(fieldType, className, imports, modelsToGenerate);
        }
      }

      // Check methods (for return types and parameters)
      for (final method in spec.methods) {
        if (method.returns != null) {
          _addImportForType(method.returns!, className, imports, modelsToGenerate);
        }
        for (final param in method.requiredParameters) {
          if (param.type != null) {
            _addImportForType(param.type!, className, imports, modelsToGenerate);
          }
        }
        for (final param in method.optionalParameters) {
          if (param.type != null) {
            _addImportForType(param.type!, className, imports, modelsToGenerate);
          }
        }
        
        // For factory methods, parse the body code to find referenced class names
        if (method.name == 'fromJson' && method.body != null) {
          // Convert Code to string using emitter
          final emitter = DartEmitter();
          final bodyCode = method.body!.accept(emitter).toString();
          _parseCodeForClassNames(bodyCode, className, imports, modelsToGenerate, generatedClassNames);
        }
      }
      
      // Check constructors (for factory constructors)
      for (final constructor in spec.constructors) {
        if (constructor.factory && constructor.body != null) {
          // Convert Code to string using emitter
          final emitter = DartEmitter();
          final bodyCode = constructor.body!.accept(emitter).toString();
          _parseCodeForClassNames(bodyCode, className, imports, modelsToGenerate, generatedClassNames);
        }
      }
    }

    return imports;
  }

  /// Parse code string to find referenced class names.
  void _parseCodeForClassNames(
    String code,
    String currentClassName,
    List<String> imports,
    List<SchemaMetadata> modelsToGenerate,
    Set<String> generatedClassNames,
  ) {
    // Find patterns like: ClassName.fromJson, ClassName.canParse, ClassName(value: ...)
    // Match class names (PascalCase) followed by . or (
    final classPattern = RegExp(r'\b([A-Z][a-zA-Z0-9]*)\s*[\.\(]');
    final matches = classPattern.allMatches(code);
    
    for (final match in matches) {
      final className = match.group(1);
      if (className == null) continue;
      
      // Skip primitives and built-in types
      final primitives = {'String', 'Map', 'List', 'Set', 'Object', 'dynamic', 'int', 'double', 'bool'};
      if (primitives.contains(className)) continue;
      
      // Skip current class
      if (className == currentClassName) continue;
      
      // Check if it's a model class or a generated variant/wrapper
      final isModelClass = modelsToGenerate.any((m) => m.className == className);
      final isGeneratedClass = generatedClassNames.contains(className);
      
      if (isModelClass || isGeneratedClass) {
        final fileName = ReCase(className).snakeCase;
        final importPath = '$fileName.dart';
        if (!imports.contains(importPath)) {
          imports.add(importPath);
        }
      }
    }
  }

  /// Helper to add import for a type reference if it's a model class.
  void _addImportForType(
    Reference typeRef,
    String currentClassName,
    List<String> imports,
    List<SchemaMetadata> modelsToGenerate,
  ) {
    final symbol = typeRef.symbol;
    if (symbol == null) return;

    // Skip primitives and built-in types
    final primitives = {'String', 'int', 'double', 'bool', 'dynamic', 'Object', 'List', 'Map', 'Set'};
    if (primitives.contains(symbol)) return;

    // Check if it's a model class
    final isModelClass = modelsToGenerate.any((m) => m.className == symbol);
    if (isModelClass && symbol != currentClassName) {
      final fileName = ReCase(symbol).snakeCase;
      final importPath = '$fileName.dart';
      if (!imports.contains(importPath)) {
        imports.add(importPath);
      }
    }

    // Check generic type arguments (only for TypeReference)
    if (typeRef is TypeReference && typeRef.types.isNotEmpty) {
      for (final typeArg in typeRef.types) {
        _addImportForType(typeArg, currentClassName, imports, modelsToGenerate);
      }
    }
  }

  List<String> _findRequiredImports(
    SchemaMetadata schema,
    List<SchemaMetadata> allModels,
    List<SchemaMetadata> inlineUnions,
    CompositionAnalyzer compositionAnalyzer,
    Map<String, List<String>> interfaceImplementations,
  ) {
    final imports = <String>{};

    // Helper function to recursively find referenced types
    void findReferencedType(String refString) {
      // Extract the class name from the reference
      String referencedClassName;

      if (refString.startsWith('#/components/schemas/')) {
        // Internal component reference like "#/components/schemas/NewUser"
        referencedClassName = refString.split('/').last;
      } else if (refString.contains('#')) {
        // External with fragment like "country.yaml#/components/schemas/Country"
        referencedClassName = refString.split('/').last;
      } else {
        // Simple external file reference like "new_user.yaml"
        final fileName = refString.split('/').last.replaceAll(RegExp(r'\.(yaml|yml|json)$'), '');
        referencedClassName = ReCase(fileName).pascalCase;
      }

      // Find the model with matching class name or reference string
      for (final model in allModels) {
        final matchesByClassName = model.className == referencedClassName;
        final matchesByRef = model.referenceString == refString;

        // For external file references, also check if the referenceString starts with the file name
        final matchesByExternalFile =
            !refString.startsWith('#') &&
            model.referenceString != null &&
            model.referenceString!.split('#').first == refString.split('#').first;

        if ((matchesByClassName || matchesByRef || matchesByExternalFile) &&
            model.fileName != null &&
            model.fileName != schema.fileName) {
          imports.add('${model.fileName}.dart');
          break;
        }
      }
    }

    // Helper function to check a schema for references
    void checkSchemaForRefs(SchemaObject schemaObj) {
      // Check if the schema itself has a ref field
      if (schemaObj.ref != null) {
        findReferencedType(schemaObj.ref!);
      }

      // Check array items
      if (schemaObj.type?.name == 'array' && schemaObj.items != null) {
        if (schemaObj.items!.isReference()) {
          findReferencedType(schemaObj.items!.asReference()!);
        } else {
          final itemsSchema = schemaObj.items!.asValue();
          if (itemsSchema != null) {
            checkSchemaForRefs(itemsSchema);
          }
        }
      }

      // Check properties
      if (schemaObj.properties != null) {
        for (final propEntry in schemaObj.properties!.entries) {
          final propRef = propEntry.value;
          if (propRef.isReference()) {
            findReferencedType(propRef.asReference()!);
          } else {
            final propSchema = propRef.asValue();
            if (propSchema != null) {
              // Check if this is a nested object schema that was discovered separately
              if (propSchema.type?.name == 'object' && propSchema.title != null) {
                // Look for a discovered schema with this title
                for (final model in allModels) {
                  if (model.schema.title == propSchema.title &&
                      model.fileName != null &&
                      model.fileName != schema.fileName) {
                    imports.add('${model.fileName}.dart');
                    break;
                  }
                }
              }
              checkSchemaForRefs(propSchema);
            }
          }
        }
      }
    }

    // For inheritance (allOf with first item being a reference), add the base class import
    if (schema.schema.allOf != null && schema.schema.allOf!.isNotEmpty) {
      // Check if this is actual inheritance (first item is a reference)
      final isActualInheritance = schema.schema.allOf![0].isReference();

      // Only add import for the first allOf item if it's a reference (the base class)
      // Other allOf references are for property merging, not inheritance, so don't import them
      if (isActualInheritance) {
        final baseRef = schema.schema.allOf![0].asReference()!;
        findReferencedType(baseRef);
      }

      // Check all allOf items (including inline schemas) for property references
      for (var i = 0; i < schema.schema.allOf!.length; i++) {
        if (schema.schema.allOf![i].isReference()) {
          // Skip the first item if it's the base class (already handled above)
          // For other references, they're for property merging, not imports
          if (i > 0) {
            // Don't add import for merged properties - they're already in the class
            continue;
          }
        } else {
          // Inline schema - check its properties for references
          final inlineSchema = schema.schema.allOf![i].asValue();
          if (inlineSchema != null) {
            // Check for nested object schemas in properties
            if (inlineSchema.properties != null) {
              for (final propEntry in inlineSchema.properties!.entries) {
                final propRef = propEntry.value;
                if (!propRef.isReference()) {
                  final propSchema = propRef.asValue();
                  if (propSchema != null && propSchema.type?.name == 'object' && propSchema.title != null) {
                    // Look for a discovered schema with this title
                    for (final model in allModels) {
                      if (model.schema.title == propSchema.title &&
                          model.fileName != null &&
                          model.fileName != schema.fileName) {
                        imports.add('${model.fileName}.dart');
                        break;
                      }
                    }
                  }
                }
              }
            }
            checkSchemaForRefs(inlineSchema);
          }
        }
      }
    } else {
      // Only check schema.schema if there's no allOf (properties are in allOf items, not in schema.schema)
      checkSchemaForRefs(schema.schema);
    }

    // For oneOf/anyOf interfaces, add imports for all variant classes
    if (schema.schema.oneOf != null || schema.schema.anyOf != null) {
      final variants = schema.schema.oneOf ?? schema.schema.anyOf ?? [];
      for (final variantRef in variants) {
        if (variantRef.isReference()) {
          findReferencedType(variantRef.asReference()!);
        }
      }
    }

    // For discriminator interfaces, add imports for all discriminator children
    if (schema.schema.discriminator != null && schema.className != null) {
      final children = compositionAnalyzer.discoverDiscriminatorChildren(schema.className!, schema.schema);
      for (final childName in children) {
        // Find the model with matching class name
        for (final model in allModels) {
          if (model.className == childName &&
              model.fileName != null &&
              model.fileName != schema.fileName) {
            imports.add('${model.fileName}.dart');
            break;
          }
        }
      }
    }

    // Check inline unions for nested object schemas
    for (final inlineUnion in inlineUnions) {
      final unionAnalysis = compositionAnalyzer.analyzeUnion(inlineUnion.schema);
      for (final variantRef in unionAnalysis.variants) {
        if (!variantRef.isReference()) {
          final variantSchema = variantRef.asValue();
          if (variantSchema != null) {
            // Check variant properties
            if (variantSchema.properties != null) {
              for (final propEntry in variantSchema.properties!.entries) {
                final propRef = propEntry.value;
                if (!propRef.isReference()) {
                  final propSchema = propRef.asValue();
                  if (propSchema != null && propSchema.type?.name == 'object' && propSchema.title != null) {
                    // Look for a discovered schema with this title
                    for (final model in allModels) {
                      if (model.schema.title == propSchema.title &&
                          model.fileName != null &&
                          model.fileName != schema.fileName) {
                        imports.add('${model.fileName}.dart');
                        break;
                      }
                    }
                  }
                }
              }
            }

            // Check variant allOf items
            if (variantSchema.allOf != null) {
              for (final allOfItem in variantSchema.allOf!) {
                if (!allOfItem.isReference()) {
                  final allOfSchema = allOfItem.asValue();
                  if (allOfSchema != null && allOfSchema.properties != null) {
                    for (final propEntry in allOfSchema.properties!.entries) {
                      final propRef = propEntry.value;
                      if (!propRef.isReference()) {
                        final propSchema = propRef.asValue();
                        if (propSchema != null && propSchema.type?.name == 'object' && propSchema.title != null) {
                          // Look for a discovered schema with this title
                          for (final model in allModels) {
                            if (model.schema.title == propSchema.title &&
                                model.fileName != null &&
                                model.fileName != schema.fileName) {
                              imports.add('${model.fileName}.dart');
                              break;
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    // Add imports for interfaces being implemented
    final interfacesToImplement = interfaceImplementations[schema.className!] ?? [];
    for (final interfaceName in interfacesToImplement) {
      // Find the interface's file
      for (final model in allModels) {
        if (model.className == interfaceName &&
            model.fileName != null &&
            model.fileName != schema.fileName) {
          imports.add('${model.fileName}.dart');
          break;
        }
      }
    }

    return imports.toList()..sort();
  }

  /// Recursively resolve a base schema, including all properties from its inheritance chain.
  SchemaObject? _resolveBaseSchemaRecursive(
    String baseRef,
    List<SchemaMetadata> allSchemas,
    CompositionAnalyzer compositionAnalyzer,
  ) {
    // Find the base schema in our list of discovered schemas
    SchemaMetadata? baseMetadata;
    for (final discoveredSchema in allSchemas) {
      if (discoveredSchema.referenceString == baseRef ||
          (baseRef.startsWith('#/components/schemas/') && discoveredSchema.location.path == baseRef)) {
        baseMetadata = discoveredSchema;
        break;
      }
    }

    if (baseMetadata == null) {
      return null;
    }

    final baseSchema = baseMetadata.schema;
    final allProperties = <String, Referenceable<SchemaObject>>{};
    final allRequired = <String>[];

    // If the base schema has allOf (inheritance), recursively resolve its base classes
    if (baseSchema.allOf != null) {
      final baseAnalysis = compositionAnalyzer.analyzeAllOf(baseSchema.allOf!);

      // If the first item is a reference (inheritance), recursively resolve it
      if (baseAnalysis.isInheritance && baseAnalysis.baseSchema != null && baseSchema.allOf![0].isReference()) {
        final parentRef = baseSchema.allOf![0].asReference()!;
        final parentResolved = _resolveBaseSchemaRecursive(parentRef, allSchemas, compositionAnalyzer);
        if (parentResolved != null) {
          if (parentResolved.properties != null) {
            allProperties.addAll(parentResolved.properties!);
          }
          if (parentResolved.required_ != null) {
            allRequired.addAll(parentResolved.required_!);
          }
        }
      }

      // Add properties from merged inline schemas
      if (baseAnalysis.mergedSchema.properties != null) {
        allProperties.addAll(baseAnalysis.mergedSchema.properties!);
      }
      if (baseAnalysis.mergedSchema.required_ != null) {
        allRequired.addAll(baseAnalysis.mergedSchema.required_!);
      }
    }

    // Add properties directly defined on the base schema
    if (baseSchema.properties != null) {
      allProperties.addAll(baseSchema.properties!);
    }
    if (baseSchema.required_ != null) {
      allRequired.addAll(baseSchema.required_!);
    }

    return SchemaObject(
      properties: allProperties.isNotEmpty ? allProperties : null,
      required_: allRequired.isNotEmpty ? allRequired.toSet().toList() : null,
    );
  }

  String _formatSchemaLocation(SchemaMetadata schema) {
    final loc = schema.location;
    final parts = <String>[];

    parts.add('Type: ${loc.type}');
    if (loc.path.isNotEmpty) {
      parts.add('Path: ${loc.path}');
    }
    if (loc.httpMethod != null) {
      parts.add('Method: ${loc.httpMethod}');
    }
    if (loc.operationId != null) {
      parts.add('OperationId: ${loc.operationId}');
    }
    if (loc.responseCode != null) {
      parts.add('Response: ${loc.responseCode}');
    }
    if (loc.propertyChain.isNotEmpty) {
      parts.add('PropertyChain: ${loc.propertyChain.join(".")}');
    }

    return parts.join(', ');
  }

  String _getSchemaFile(SchemaMetadata schema) {
    if (schema.referenceString == null) {
      return 'inline schema (no reference)';
    }

    if (schema.referenceString!.startsWith('#/')) {
      return 'main.yaml at ${schema.referenceString}';
    }

    // External file reference
    final parts = schema.referenceString!.split('#');
    final fileName = parts[0];
    if (parts.length > 1) {
      return '$fileName at fragment ${parts[1]}';
    }
    return fileName;
  }

  String _buildYamlPath(SchemaMetadata schema) {
    final loc = schema.location;
    final pathParts = <String>[];

    // Start with the file
    if (schema.referenceString != null && !schema.referenceString!.startsWith('#/')) {
      final fileParts = schema.referenceString!.split('#');
      pathParts.add('File: ${fileParts[0]}');
      if (fileParts.length > 1) {
        pathParts.add('Fragment: ${fileParts[1]}');
      }
    } else {
      pathParts.add('File: main.yaml');
    }

    // Add the YAML path based on location type
    switch (loc.type) {
      case SchemaLocationType.component:
        if (loc.path.startsWith('#/components/schemas/')) {
          final schemaName = loc.path.split('/').last;
          pathParts.add('components.schemas.$schemaName');
        } else {
          pathParts.add(loc.path);
        }
        break;

      case SchemaLocationType.requestBody:
        pathParts.add('paths.${loc.path}.${loc.httpMethod}.requestBody.content.application/json.schema');
        break;

      case SchemaLocationType.response:
        pathParts.add(
          'paths.${loc.path}.${loc.httpMethod}.responses.${loc.responseCode}.content.application/json.schema',
        );
        break;

      case SchemaLocationType.nestedProperty:
        // Build the full property path
        final basePath = loc.path.replaceFirst('#/', '').replaceAll('/', '.');
        if (loc.propertyChain.isNotEmpty) {
          pathParts.add('$basePath.properties.${loc.propertyChain.join(".properties.")}');
        } else {
          pathParts.add(basePath);
        }
        break;

      default:
        pathParts.add(loc.path);
    }

    return pathParts.join(' -> ');
  }
}

