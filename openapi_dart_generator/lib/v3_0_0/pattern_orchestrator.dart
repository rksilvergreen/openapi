import 'package:code_builder/code_builder.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/schema/schema_object.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/referenceable.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/enums.dart';

import '../../processor/schema_classifier.dart';
import '../../processor/composition_analyzer.dart';
import 'interface_generator.dart';
import 'variant_class_generator.dart';
import 'primitive_wrapper_generator.dart';
import '../../processor/schema_discoverer.dart';

/// Orchestrates generation of all hierarchy patterns from GENERATION_ALGORITHM.md.
///
/// Coordinates:
/// - Discriminator interfaces and children
/// - oneOf interfaces and variants
/// - allOf patterns (simple, complex, allOf+oneOf)
/// - Hybrid schemas (properties + oneOf)
/// - Primitive wrappers
class PatternOrchestrator {
  final SchemaClassifier classifier;
  final CompositionAnalyzer compositionAnalyzer;
  final InterfaceGenerator interfaceGenerator;
  final VariantClassGenerator variantGenerator;
  final PrimitiveWrapperGenerator primitiveWrapperGenerator;
  final Map<String, SchemaMetadata> schemaMetadataMap;
  final Map<String, List<String>> descendants; // parent class -> list of children classes
  final Map<String, List<String>> descendantsRequiredProps; // class -> required properties

  PatternOrchestrator({
    required this.schemaMetadataMap,
    required this.descendants,
    required this.descendantsRequiredProps,
    Map<String, SchemaObject>? schemaRegistry,
  }) : classifier = SchemaClassifier(schemaRegistry: schemaRegistry),
       compositionAnalyzer = CompositionAnalyzer(schemaRegistry: schemaRegistry),
       interfaceGenerator = InterfaceGenerator(),
       variantGenerator = VariantClassGenerator(),
       primitiveWrapperGenerator = PrimitiveWrapperGenerator();

  /// Generate all specs for a schema based on its pattern.
  ///
  /// Returns a list of Spec objects (classes, interfaces, etc.)
  List<Spec> generatePattern({required SchemaMetadata metadata, required String name, List<String>? parentInterfaces}) {
    final schema = metadata.schema;
    final modelType = metadata.classification ?? classifier.classify(schema);

    switch (modelType) {
      case ModelType.discriminatorInterface:
        return _generateDiscriminatorPattern(metadata, name, parentInterfaces);

      case ModelType.oneOfInterface:
        return _generateOneOfInterfacePattern(metadata, name, parentInterfaces);

      case ModelType.primitiveUnion:
        return _generatePrimitiveUnionPattern(metadata, name, parentInterfaces);

      case ModelType.simpleAllOf:
        return _generateSimpleAllOfPattern(metadata, name);

      case ModelType.complexAllOf:
        return _generateComplexAllOfPattern(metadata, name);

      case ModelType.allOfOneOf:
        return _generateAllOfOneOfPattern(metadata, name);

      case ModelType.hybrid:
        return _generateHybridPattern(metadata, name);

      case ModelType.object:
      case ModelType.enum_:
      case ModelType.simpleMap:
      case ModelType.primitive:
      case ModelType.arrayWrapper:
        // These are handled by existing generators
        return [];
    }
  }

  /// Pattern 8: Discriminator Interface
  ///
  /// Schema with discriminator keyword becomes abstract interface.
  /// Children are discovered via oneOf, allOf references, or mapping.
  List<Spec> _generateDiscriminatorPattern(SchemaMetadata metadata, String name, List<String>? parentInterfaces) {
    final schema = metadata.schema;
    final specs = <Spec>[];

    // Discover all children of this discriminator parent
    final children = compositionAnalyzer.discoverDiscriminatorChildren(name, schema);

    // Generate the interface
    specs.add(
      interfaceGenerator.generateInterface(
        interfaceName: name,
        schema: schema,
        variantNames: children,
        discriminatorProperty: schema.discriminator?.propertyName,
        discriminatorMapping: schema.discriminator?.mapping,
        parentInterfaces: parentInterfaces,
        variantRequiredProperties: {}, // Discriminator uses value-based discrimination, not property checks
      ),
    );

    // Note: Child classes will be generated when their own schemas are processed
    // They will use variantGenerator with discriminatorProperty set

    return specs;
  }

  /// Pattern 2: oneOf Interface
  ///
  /// oneOf without discriminator becomes abstract interface.
  /// Variants implement the interface.
  List<Spec> _generateOneOfInterfacePattern(SchemaMetadata metadata, String name, List<String>? parentInterfaces) {
    final schema = metadata.schema;
    final specs = <Spec>[];

    final analysis = compositionAnalyzer.analyzeUnion(schema);

    // Collect required properties for each variant, recursively expanding interfaces
    final variantRequiredProps = <String, List<String>>{};
    final expandedVariantNames = <String>[];
    
    for (var i = 0; i < analysis.variants.length; i++) {
      final variantRef = analysis.variants[i];
      if (!variantRef.isReference()) {
        final variantSchema = variantRef.asValue();
        if (variantSchema != null) {
          final variantName = variantSchema.title ?? '${name}Variant$i';
          expandedVariantNames.add(variantName);
          variantRequiredProps[variantName] = variantSchema.required_?.toList() ?? [];
        }
      } else {
        // For references, try to resolve from schemaRegistry
        final refString = variantRef.asReference();
        if (refString != null) {
          final variantName = refString.split('/').last;
          // Try to get from schemaRegistry if available
          if (compositionAnalyzer.schemaRegistry.isNotEmpty) {
            // Try full ref string first
            var resolvedSchema = compositionAnalyzer.schemaRegistry[refString];
            // If not found, try just the schema name
            if (resolvedSchema == null) {
              resolvedSchema = compositionAnalyzer.schemaRegistry[variantName];
            }
            if (resolvedSchema != null) {
              // Check if this variant is itself an interface that needs expansion
              final variantMetadata = schemaMetadataMap[variantName];
              if (variantMetadata != null &&
                  (variantMetadata.classification == ModelType.oneOfInterface ||
                      variantMetadata.classification == ModelType.discriminatorInterface ||
                      variantMetadata.classification == ModelType.primitiveUnion)) {
                // Recursively expand this interface's variants
                final expanded = _expandInterfaceVariants(variantName, resolvedSchema);
                expandedVariantNames.addAll(expanded.keys);
                variantRequiredProps.addAll(expanded);
              } else {
                // Regular concrete class
                expandedVariantNames.add(variantName);
                variantRequiredProps[variantName] = compositionAnalyzer.resolveAllRequired(resolvedSchema);
              }
            } else {
              expandedVariantNames.add(variantName);
              variantRequiredProps[variantName] = [];
            }
          } else {
            expandedVariantNames.add(variantName);
            variantRequiredProps[variantName] = [];
          }
        }
      }
    }

    // Generate the interface
    specs.add(
      interfaceGenerator.generateInterface(
        interfaceName: name,
        schema: schema,
        variantNames: expandedVariantNames,
        parentInterfaces: parentInterfaces,
        variantRequiredProperties: variantRequiredProps,
      ),
    );

    // Generate variant classes for inline schemas
    for (var i = 0; i < analysis.variants.length; i++) {
      final variantRef = analysis.variants[i];

      if (!variantRef.isReference()) {
        final variantSchema = variantRef.asValue();
        if (variantSchema != null) {
          final variantName = variantSchema.title ?? '${name}Variant$i';

          specs.add(
            variantGenerator.generateVariantClass(className: variantName, schema: variantSchema, interfaces: [name]),
          );
        }
      }
    }

    return specs;
  }

  /// Pattern 7: Primitive Union
  ///
  /// oneOf with primitive types needs wrapper classes.
  List<Spec> _generatePrimitiveUnionPattern(SchemaMetadata metadata, String name, List<String>? parentInterfaces) {
    final schema = metadata.schema;
    final specs = <Spec>[];

    final analysis = compositionAnalyzer.analyzeUnion(schema);
    final variantNames = <String>[];

    // Collect variant names and primitive types
    for (var i = 0; i < analysis.variants.length; i++) {
      final variantRef = analysis.variants[i];

      if (variantRef.isReference()) {
        final refString = variantRef.asReference();
        if (refString != null) {
          variantNames.add(refString.split('/').last);
        }
      } else {
        final variantSchema = variantRef.asValue();
        if (variantSchema != null) {
          if (_isPrimitiveSchema(variantSchema)) {
            // Generate wrapper name and add to variants
            final typeName = _getPrimitiveTypeName(variantSchema);
            final wrapperName = '$name${typeName}Value';
            variantNames.add(wrapperName);

            // Generate the wrapper class
            specs.add(
              primitiveWrapperGenerator.generatePrimitiveWrapper(
                wrapperName: wrapperName,
                primitiveType: _mapPrimitiveToDart(variantSchema.type?.name ?? 'String'),
                interfaceName: name,
              ),
            );
          } else {
            // Regular object variant
            final variantName = variantSchema.title ?? '${name}Variant$i';
            variantNames.add(variantName);

            specs.add(
              variantGenerator.generateVariantClass(className: variantName, schema: variantSchema, interfaces: [name]),
            );
          }
        }
      }
    }

    // Collect required properties for each variant (for inline canParse logic)
    final variantRequiredProps = <String, List<String>>{};
    for (var i = 0; i < analysis.variants.length; i++) {
      final variantRef = analysis.variants[i];
      if (!variantRef.isReference()) {
        final variantSchema = variantRef.asValue();
        if (variantSchema != null) {
          if (_isPrimitiveSchema(variantSchema)) {
            // Primitives don't need property checks
            final typeName = _getPrimitiveTypeName(variantSchema);
            final wrapperName = '$name${typeName}Value';
            variantRequiredProps[wrapperName] = [];
          } else {
            final variantName = variantSchema.title ?? '${name}Variant$i';
            variantRequiredProps[variantName] = variantSchema.required_?.toList() ?? [];
          }
        }
      } else {
        // For references, try to resolve from schemaRegistry
        final refString = variantRef.asReference();
        if (refString != null) {
          final variantName = refString.split('/').last;
          if (compositionAnalyzer.schemaRegistry.isNotEmpty) {
            // Try full ref string first
            var resolvedSchema = compositionAnalyzer.schemaRegistry[refString];
            // If not found, try just the schema name
            if (resolvedSchema == null) {
              resolvedSchema = compositionAnalyzer.schemaRegistry[variantName];
            }
            if (resolvedSchema != null) {
              // Use resolveAllRequired to recursively get all required fields from allOf chains
              variantRequiredProps[variantName] = compositionAnalyzer.resolveAllRequired(resolvedSchema);
            } else {
              variantRequiredProps[variantName] = [];
            }
          } else {
            variantRequiredProps[variantName] = [];
          }
        }
      }
    }

    // Generate the interface
    specs.add(
      interfaceGenerator.generateInterface(
        interfaceName: name,
        schema: schema,
        variantNames: variantNames,
        parentInterfaces: parentInterfaces,
        variantRequiredProperties: variantRequiredProps,
      ),
    );

    return specs;
  }

  /// Pattern 3a: Simple allOf
  ///
  /// Single reference + properties → Concrete class implements parent.
  List<Spec> _generateSimpleAllOfPattern(SchemaMetadata metadata, String name) {
    final schema = metadata.schema;
    final specs = <Spec>[];

    if (schema.allOf == null || schema.allOf!.isEmpty) {
      return specs;
    }

    // Get the parent interface name from first allOf item
    final firstItem = schema.allOf!.first;
    final parentInterfaces = <String>[];

    if (firstItem.isReference()) {
      final refString = firstItem.asReference();
      if (refString != null) {
        parentInterfaces.add(refString.split('/').last);
      }
    }

    // Merge properties from all allOf items
    final analysis = compositionAnalyzer.analyzeAllOf(schema.allOf!);

    // Generate the concrete class that implements the parent
    specs.add(
      variantGenerator.generateVariantClass(
        className: name,
        schema: analysis.mergedSchema,
        interfaces: parentInterfaces,
      ),
    );

    return specs;
  }

  /// Pattern 4: Complex allOf (Cartesian Product)
  ///
  /// Multiple oneOf references → Interface + all combinations.
  List<Spec> _generateComplexAllOfPattern(SchemaMetadata metadata, String name) {
    final schema = metadata.schema;
    final specs = <Spec>[];

    if (schema.allOf == null || schema.allOf!.isEmpty) {
      return specs;
    }

    // Resolve all allOf references and collect their variants
    final allVariantLists = <List<_UnionVariantInfo>>[];

    for (final allOfItem in schema.allOf!) {
      if (allOfItem.isReference()) {
        final refString = allOfItem.asReference();
        if (refString != null) {
          final refName = refString.split('/').last;
          final refSchema = compositionAnalyzer.schemaRegistry[refName];

          // Check if this reference is a oneOf/anyOf union
          if (refSchema != null && (refSchema.oneOf != null || refSchema.anyOf != null)) {
            // Get all variants for this union
            final variants = refSchema.oneOf ?? refSchema.anyOf ?? [];
            final variantInfos = <_UnionVariantInfo>[];

            for (final variantRef in variants) {
              if (variantRef.isReference()) {
                final variantRefString = variantRef.asReference();
                if (variantRefString != null) {
                  final variantName = variantRefString.split('/').last;
                  final variantSchema = compositionAnalyzer.schemaRegistry[variantName];
                  if (variantSchema != null) {
                    variantInfos.add(_UnionVariantInfo(variantName, variantSchema));
                  }
                }
              } else {
                final variantSchema = variantRef.asValue();
                if (variantSchema != null) {
                  final variantName = variantSchema.title ?? 'Variant${variantInfos.length}';
                  variantInfos.add(_UnionVariantInfo(variantName, variantSchema));
                }
              }
            }

            if (variantInfos.isNotEmpty) {
              allVariantLists.add(variantInfos);
            }
          }
        }
      }
    }

    if (allVariantLists.isEmpty) {
      // No unions found, can't generate Cartesian product
      return specs;
    }

    // Generate Cartesian product of all variant combinations
    final combinations = _generateCartesianProduct(allVariantLists);
    final combinationNames = <String>[];

    // Generate a wrapper class for each combination
    for (final combination in combinations) {
      // Build combination name (e.g., "AbominationCatAdminUser")
      final combinationName = name + combination.map((v) => v.name).join();
      combinationNames.add(combinationName);

      // Merge properties from all variants in this combination
      final mergedProperties = <String, SchemaObject>{};
      final mergedRequired = <String>[];
      final interfaces = <String>[name]; // Implements the base interface

      for (final variant in combination) {
        // Add variant name to interfaces
        interfaces.add(variant.name);

        // Recursively resolve and merge properties from variant and its allOf chain
        final variantProps = compositionAnalyzer.resolveAllProperties(variant.schema);
        mergedProperties.addAll(variantProps);

        // Recursively resolve and merge required fields from variant and its allOf chain
        final variantRequired = compositionAnalyzer.resolveAllRequired(variant.schema);
        mergedRequired.addAll(variantRequired);
      }

      // Create merged schema
      final mergedSchema = SchemaObject(
        type: SchemaType.object,
        properties: mergedProperties.map((k, v) => MapEntry(k, Referenceable.value(v))),
        required_: mergedRequired.isNotEmpty ? mergedRequired.toSet().toList() : null,
      );

      // Generate combination class
      specs.add(
        variantGenerator.generateVariantClass(className: combinationName, schema: mergedSchema, interfaces: interfaces),
      );

      // Track required properties for this combination class
      descendantsRequiredProps[combinationName] = mergedRequired.toSet().toList();

      // Update descendants map: each implemented interface should know about this combination class
      for (final interface in interfaces) {
        if (interface != name) {
          // Don't add as descendant of the base interface (Abomination)
          // Only add to concrete classes (not interfaces themselves)
          final interfaceMetadata = schemaMetadataMap[interface];
          if (interfaceMetadata != null &&
              interfaceMetadata.classification != ModelType.oneOfInterface &&
              interfaceMetadata.classification != ModelType.discriminatorInterface &&
              interfaceMetadata.classification != ModelType.primitiveUnion) {
            descendants.putIfAbsent(interface, () => []).add(combinationName);
          }
        }
      }
    }

    // Collect required properties for each combination (for inline canParse logic)
    final variantRequiredProps = <String, List<String>>{};
    for (var i = 0; i < combinations.length; i++) {
      final combination = combinations[i];
      final combinationName = combinationNames[i];

      // Merge required fields from all variants in this combination
      final allRequired = <String>[];
      for (final variant in combination) {
        final variantRequired = compositionAnalyzer.resolveAllRequired(variant.schema);
        allRequired.addAll(variantRequired);
      }
      variantRequiredProps[combinationName] = allRequired.toSet().toList();
    }

    // Generate the interface (placed last so it appears first in the file)
    specs.add(
      interfaceGenerator.generateInterface(
        interfaceName: name,
        schema: schema,
        variantNames: combinationNames,
        variantRequiredProperties: variantRequiredProps,
      ),
    );

    // Return with interface first, then combinations
    return [specs.last, ...specs.take(specs.length - 1)];
  }

  /// Pattern 5: allOf + oneOf
  ///
  /// oneOf reference + properties → Interface + variant classes.
  /// Example: Fauna = Animal (oneOf) + additional properties (fins, color)
  List<Spec> _generateAllOfOneOfPattern(SchemaMetadata metadata, String name) {
    final schema = metadata.schema;
    final specs = <Spec>[];

    if (schema.allOf == null || schema.allOf!.isEmpty) {
      return specs;
    }

    // Find the oneOf reference and collect additional properties
    SchemaObject? unionSchema;
    String? unionSchemaName;
    final additionalProperties = <String, SchemaObject>{};
    final additionalRequired = <String>[];

    for (final allOfItem in schema.allOf!) {
      if (allOfItem.isReference()) {
        final refString = allOfItem.asReference();
        if (refString != null) {
          final refName = refString.split('/').last;
          final refSchema = compositionAnalyzer.schemaRegistry[refName];

          // Check if this is a oneOf/anyOf union
          if (refSchema != null && (refSchema.oneOf != null || refSchema.anyOf != null)) {
            unionSchema = refSchema;
            unionSchemaName = refName;
          }
        }
      } else {
        // Inline schema with additional properties
        final inlineSchema = allOfItem.asValue();
        if (inlineSchema != null) {
          if (inlineSchema.properties != null) {
            for (final entry in inlineSchema.properties!.entries) {
              final propSchema = entry.value.asValue();
              if (propSchema != null) {
                additionalProperties[entry.key] = propSchema;
              }
            }
          }
          if (inlineSchema.required_ != null) {
            additionalRequired.addAll(inlineSchema.required_!);
          }
        }
      }
    }

    if (unionSchema == null || unionSchemaName == null) {
      print('    Warning: allOfOneOf pattern but no oneOf reference found');
      return specs;
    }

    // Get variants from the union
    final variants = unionSchema.oneOf ?? unionSchema.anyOf ?? [];
    final variantNames = <String>[];
    final wrapperSpecs = <Spec>[];

    // Generate wrapper classes for each variant
    for (var i = 0; i < variants.length; i++) {
      final variantRef = variants[i];

      if (variantRef.isReference()) {
        final refString = variantRef.asReference();
        if (refString != null) {
          final refName = refString.split('/').last;
          final wrapperName = '$name$refName';
          variantNames.add(wrapperName);

          // Get the variant schema from the registry
          final variantSchema = compositionAnalyzer.schemaRegistry[refName];

          if (variantSchema != null) {
            // Merge variant properties with additional properties
            final mergedProperties = <String, SchemaObject>{
              ...compositionAnalyzer.resolveAllProperties(variantSchema),
              ...additionalProperties,
            };

            // Merge required arrays
            final mergedRequired = <String>[...compositionAnalyzer.resolveAllRequired(variantSchema), ...additionalRequired];

            // Create merged schema
            final mergedSchema = SchemaObject(
              type: variantSchema.type ?? SchemaType.object,
              properties: mergedProperties.map((k, v) => MapEntry(k, Referenceable.value(v))),
              required_: mergedRequired.isNotEmpty ? mergedRequired.toSet().toList() : null,
            );

            // Generate wrapper class
            wrapperSpecs.add(
              variantGenerator.generateVariantClass(
                className: wrapperName,
                schema: mergedSchema,
                interfaces: [name, refName],
                parentProperties: additionalProperties,
              ),
            );
          }
        }
      } else {
        final variantSchema = variantRef.asValue();
        if (variantSchema != null) {
          final variantName = variantSchema.title ?? '${name}Variant$i';
          final wrapperName = '$name$variantName';
          variantNames.add(wrapperName);

          // Merge variant properties with additional properties
          final mergedProperties = <String, SchemaObject>{
            ...compositionAnalyzer.resolveAllProperties(variantSchema),
            ...additionalProperties,
          };

          // Merge required arrays
          final mergedRequired = <String>[...compositionAnalyzer.resolveAllRequired(variantSchema), ...additionalRequired];

          // Create merged schema
          final mergedSchema = SchemaObject(
            type: variantSchema.type ?? SchemaType.object,
            properties: mergedProperties.map((k, v) => MapEntry(k, Referenceable.value(v))),
            required_: mergedRequired.isNotEmpty ? mergedRequired.toSet().toList() : null,
          );

          // Generate wrapper class
          wrapperSpecs.add(
            variantGenerator.generateVariantClass(
              className: wrapperName,
              schema: mergedSchema,
              interfaces: [name, variantName],
              parentProperties: additionalProperties,
            ),
          );
        }
      }
    }

    // Collect required properties for each wrapper (for inline canParse logic)
    final variantRequiredProps = <String, List<String>>{};
    for (var i = 0; i < variants.length; i++) {
      final variantRef = variants[i];
      final wrapperName = variantNames[i];

      if (variantRef.isReference()) {
        final refString = variantRef.asReference();
        if (refString != null) {
          final refName = refString.split('/').last;
          final variantSchema = compositionAnalyzer.schemaRegistry[refName];
          if (variantSchema != null) {
            final mergedRequired = <String>[...compositionAnalyzer.resolveAllRequired(variantSchema), ...additionalRequired];
            variantRequiredProps[wrapperName] = mergedRequired.toSet().toList();
          }
        }
      } else {
        final variantSchema = variantRef.asValue();
        if (variantSchema != null) {
          final mergedRequired = <String>[...compositionAnalyzer.resolveAllRequired(variantSchema), ...additionalRequired];
          variantRequiredProps[wrapperName] = mergedRequired.toSet().toList();
        }
      }
    }

    // Generate the interface with abstract getters for additional properties
    // Create a schema with just the additional properties for the interface
    final interfaceSchema = SchemaObject(
      type: SchemaType.object,
      properties: additionalProperties.map((k, v) => MapEntry(k, Referenceable.value(v))),
      required_: additionalRequired.isNotEmpty ? additionalRequired : null,
    );

    specs.add(
      interfaceGenerator.generateInterface(
        interfaceName: name,
        schema: interfaceSchema,
        variantNames: variantNames,
        variantRequiredProperties: variantRequiredProps,
      ),
    );
    specs.addAll(wrapperSpecs);

    return specs;
  }

  /// Pattern 6: Hybrid
  ///
  /// properties + oneOf → Interface with getters + wrapper classes.
  List<Spec> _generateHybridPattern(SchemaMetadata metadata, String name) {
    final schema = metadata.schema;
    final specs = <Spec>[];

    final variants = schema.oneOf ?? schema.anyOf ?? [];
    final variantNames = <String>[];
    final wrapperSpecs = <Spec>[];

    // Get base schema properties
    final baseProperties = schema.properties ?? {};

    // Generate wrapper classes for each variant
    for (var i = 0; i < variants.length; i++) {
      final variantRef = variants[i];

      if (variantRef.isReference()) {
        final refString = variantRef.asReference();
        if (refString != null) {
          final refName = refString.split('/').last;
          final wrapperName = '$name$refName';
          variantNames.add(wrapperName);

          // Get the variant schema from the registry
          final variantSchema = compositionAnalyzer.schemaRegistry[refName];

          if (variantSchema != null) {
            // Merge base properties with variant properties
            final mergedProperties = <String, SchemaObject>{
              ...baseProperties.map((k, v) => MapEntry(k, v.asValue()!)),
              ...?variantSchema.properties?.map((k, v) => MapEntry(k, v.asValue()!)),
            };

            // Merge required arrays
            final mergedRequired = <String>[...?schema.required_, ...?variantSchema.required_];

            // Create merged schema
            final mergedSchema = SchemaObject(
              type: variantSchema.type,
              properties: mergedProperties.map((k, v) => MapEntry(k, Referenceable.value(v))),
              required_: mergedRequired.isNotEmpty ? mergedRequired : null,
            );

            // Generate wrapper class
            wrapperSpecs.add(
              variantGenerator.generateVariantClass(
                className: wrapperName,
                schema: mergedSchema,
                interfaces: [name, refName],
                parentProperties: baseProperties.map((k, v) => MapEntry(k, v.asValue()!)),
              ),
            );

            // Track required properties for this wrapper
            descendantsRequiredProps[wrapperName] = mergedRequired.toSet().toList();

            // Update descendants map: the variant class (e.g., Pterodactyl) should know about this wrapper
            final variantMetadata = schemaMetadataMap[refName];
            if (variantMetadata != null &&
                variantMetadata.classification != ModelType.oneOfInterface &&
                variantMetadata.classification != ModelType.discriminatorInterface &&
                variantMetadata.classification != ModelType.primitiveUnion) {
              descendants.putIfAbsent(refName, () => []).add(wrapperName);
            }
          }
        }
      } else {
        final variantSchema = variantRef.asValue();
        if (variantSchema != null) {
          final variantName = variantSchema.title ?? '${name}Variant$i';
          final wrapperName = '$name$variantName';
          variantNames.add(wrapperName);

          // Merge base schema properties with variant properties
          final mergedProperties = <String, SchemaObject>{
            ...baseProperties.map((k, v) => MapEntry(k, v.asValue()!)),
            ...?variantSchema.properties?.map((k, v) => MapEntry(k, v.asValue()!)),
          };

          // Merge required arrays
          final mergedRequired = <String>[...?schema.required_, ...?variantSchema.required_];

          // Create merged schema
          final mergedSchema = SchemaObject(
            type: variantSchema.type,
            properties: mergedProperties.map((k, v) => MapEntry(k, Referenceable.value(v))),
            required_: mergedRequired.isNotEmpty ? mergedRequired : null,
          );

          // Generate wrapper class
          wrapperSpecs.add(
            variantGenerator.generateVariantClass(
              className: wrapperName,
              schema: mergedSchema,
              interfaces: [name],
              parentProperties: baseProperties.map((k, v) => MapEntry(k, v.asValue()!)),
            ),
          );
        }
      }
    }

    // Collect required properties for each wrapper (for inline canParse logic)
    final variantRequiredProps = <String, List<String>>{};
    for (var i = 0; i < variants.length; i++) {
      final variantRef = variants[i];
      if (variantRef.isReference()) {
        final refString = variantRef.asReference();
        if (refString != null) {
          final refName = refString.split('/').last;
          final wrapperName = '$name$refName';

          // Get the variant schema from the registry
          final variantSchema = compositionAnalyzer.schemaRegistry[refName];
          if (variantSchema != null) {
            // Merge base required with variant required
            final mergedRequired = <String>[...?schema.required_, ...?variantSchema.required_];
            variantRequiredProps[wrapperName] = mergedRequired;
          } else {
            variantRequiredProps[wrapperName] = schema.required_?.toList() ?? [];
          }
        }
      } else {
        final variantSchema = variantRef.asValue();
        if (variantSchema != null) {
          final variantName = variantSchema.title ?? '${name}Variant$i';
          final wrapperName = '$name$variantName';
          // Merge base required with variant required
          final mergedRequired = <String>[...?schema.required_, ...?variantSchema.required_];
          variantRequiredProps[wrapperName] = mergedRequired;
        }
      }
    }

    // Generate the interface first, then wrapper classes
    specs.add(
      interfaceGenerator.generateInterface(
        interfaceName: name,
        schema: schema,
        variantNames: variantNames,
        variantRequiredProperties: variantRequiredProps,
      ),
    );
    specs.addAll(wrapperSpecs);

    return specs;
  }

  /// Check if a schema is a primitive type.
  bool _isPrimitiveSchema(SchemaObject schema) {
    final type = schema.type?.name;
    return type == 'string' || type == 'integer' || type == 'number' || type == 'boolean';
  }

  /// Get a type name for primitive wrapper naming.
  String _getPrimitiveTypeName(SchemaObject schema) {
    final type = schema.type?.name;
    switch (type) {
      case 'string':
        return 'String';
      case 'integer':
        return 'Integer';
      case 'number':
        return 'Number';
      case 'boolean':
        return 'Boolean';
      default:
        return 'Value';
    }
  }

  /// Map OpenAPI primitive type to Dart type.
  String _mapPrimitiveToDart(String openApiType) {
    switch (openApiType) {
      case 'string':
        return 'String';
      case 'integer':
        return 'int';
      case 'number':
        return 'double';
      case 'boolean':
        return 'bool';
      default:
        return 'dynamic';
    }
  }

  /// Generate Cartesian product of variant lists
  List<List<_UnionVariantInfo>> _generateCartesianProduct(List<List<_UnionVariantInfo>> lists) {
    if (lists.isEmpty) return [];
    if (lists.length == 1) return lists[0].map((v) => [v]).toList();

    final result = <List<_UnionVariantInfo>>[];
    final firstList = lists[0];
    final remainingProduct = _generateCartesianProduct(lists.skip(1).toList());

    for (final item in firstList) {
      for (final combination in remainingProduct) {
        result.add([item, ...combination]);
      }
    }

    return result;
  }

  /// Recursively expand an interface into its leaf (concrete) variants.
  ///
  /// Returns a map of variant name -> required properties.
  /// If a variant is itself an interface, it recursively expands its children.
  Map<String, List<String>> _expandInterfaceVariants(String interfaceName, SchemaObject interfaceSchema) {
    final result = <String, List<String>>{};
    
    // Get the variants of this interface
    final variants = interfaceSchema.oneOf ?? interfaceSchema.anyOf ?? [];
    
    for (final variantRef in variants) {
      if (variantRef.isReference()) {
        final refString = variantRef.asReference();
        if (refString != null) {
          final variantName = refString.split('/').last;
          final variantSchema = compositionAnalyzer.schemaRegistry[variantName];
          
          if (variantSchema != null) {
            // Check if this variant is itself an interface
            final variantMetadata = schemaMetadataMap[variantName];
            if (variantMetadata != null &&
                (variantMetadata.classification == ModelType.oneOfInterface ||
                    variantMetadata.classification == ModelType.discriminatorInterface ||
                    variantMetadata.classification == ModelType.primitiveUnion)) {
              // Recursively expand this nested interface
              final expanded = _expandInterfaceVariants(variantName, variantSchema);
              result.addAll(expanded);
            } else {
              // Leaf variant (concrete class)
              result[variantName] = compositionAnalyzer.resolveAllRequired(variantSchema);
            }
          }
        }
      } else {
        // Inline variant schema
        final variantSchema = variantRef.asValue();
        if (variantSchema != null) {
          final variantName = variantSchema.title ?? '${interfaceName}Variant${result.length}';
          result[variantName] = variantSchema.required_?.toList() ?? [];
        }
      }
    }
    
    return result;
  }
}

/// Helper class for tracking union variant information
class _UnionVariantInfo {
  final String name;
  final SchemaObject schema;

  _UnionVariantInfo(this.name, this.schema);
}
