import 'package:code_builder/code_builder.dart';
import 'package:openapi_analyzer/openapi_analyzer.dart';

import 'dart_type_mapper.dart';

/// Generates Dart sealed class unions from anyOf/oneOf schemas.
class UnionGenerator {
  final DartTypeMapper typeMapper;
  final StructuralDisjointnessAnalyzer disjointnessAnalyzer;

  UnionGenerator(this.typeMapper) : disjointnessAnalyzer = StructuralDisjointnessAnalyzer();

  /// Generate a sealed class union for anyOf/oneOf schemas.
  ///
  /// Returns a list of Specs: the sealed base class and all variant classes.
  List<Spec> generateUnion({
    required SchemaObject schema,
    required String unionName,
    required List<Referenceable<SchemaObject>> variants,
    required bool isOneOf, // true for oneOf, false for anyOf
    String? discriminatorProperty,
    Map<String, String>? discriminatorMapping,
  }) {
    final specs = <Spec>[];

    // Check if we can safely generate this union
    if (discriminatorProperty == null) {
      // No discriminator - check structural disjointness
      final analysis = disjointnessAnalyzer.analyzeVariants(variants);
      if (!analysis.isDisjoint) {
        throw Exception('Cannot generate union type for $unionName: ${analysis.errorMessage}');
      }
    }

    // Collect variant names for fromJson dispatch
    final variantNames = <String>[];
    for (var i = 0; i < variants.length; i++) {
      final variantRef = variants[i];

      if (variantRef.isReference()) {
        // For references, extract the class name from the reference
        // This is a simplification - proper implementation would resolve the reference
        final refString = variantRef.asReference();
        if (refString != null) {
          final className = refString.split('/').last;
          variantNames.add(className);
        }
        continue;
      }

      final variantSchema = variantRef.asValue();
      if (variantSchema != null) {
        // Use the schema's title if available, otherwise use a generic suffix
        final variantName = variantSchema.title ?? '$unionName${_variantSuffix(i)}';
        variantNames.add(variantName);
      }
    }

    // Generate sealed base class
    specs.add(_generateSealedBaseClass(unionName, schema, variantNames, variants, isOneOf));

    // Generate variant classes
    for (var i = 0; i < variants.length; i++) {
      final variantRef = variants[i];

      if (variantRef.isReference()) {
        // For references, the variant class should already exist
        // We don't need to generate it, just use it in the union
        continue;
      }

      final variantSchema = variantRef.asValue();
      if (variantSchema != null) {
        // Use the schema's title if available, otherwise use a generic suffix
        final variantName = variantSchema.title ?? '$unionName${_variantSuffix(i)}';
        specs.add(_generateVariantClass(variantName, unionName, variantSchema, discriminatorProperty));
      }
    }

    return specs;
  }

  /// Generate the sealed base class for the union.
  Class _generateSealedBaseClass(
    String className,
    SchemaObject schema,
    List<String> variantNames,
    List<Referenceable<SchemaObject>> variants,
    bool isOneOf,
  ) {
    return Class((b) {
      b.name = className;
      b.sealed = true;

      // Add const constructor
      b.constructors.add(
        Constructor((c) {
          c.constant = true;
        }),
      );

      // Add factory fromJson
      b.constructors.add(_generateUnionFromJson(className, schema, variantNames, variants, isOneOf));

      // Add abstract toJson method
      b.methods.add(
        Method((m) {
          m.name = 'toJson';
          m.returns = TypeReference((t) {
            t.symbol = 'Map';
            t.types.addAll([refer('String'), refer('dynamic')]);
          });
        }),
      );
    });
  }

  /// Generate a variant class that extends the sealed base.
  Class _generateVariantClass(
    String variantName,
    String baseName,
    SchemaObject variantSchema,
    String? discriminatorProperty,
  ) {
    return Class((b) {
      b.name = variantName;
      b.extend = refer(baseName);

      // Add annotations
      b.annotations.add(refer('CopyWith', 'package:copy_with_extension/copy_with_extension.dart').call([]));
      b.annotations.add(refer('JsonSerializable', 'package:json_annotation/json_annotation.dart').call([]));

      // Merge properties and required from allOf if present
      final mergedProperties = _mergeAllOfProperties(variantSchema);
      final mergedRequired = _mergeAllOfRequired(variantSchema);

      // Add fields
      if (mergedProperties.isNotEmpty) {
        for (final entry in mergedProperties.entries) {
          final propName = entry.key;
          final propSchemaRef = entry.value;

          // Skip the discriminator property as it's known at compile time
          if (discriminatorProperty != null && propName == discriminatorProperty) {
            continue;
          }

          final propSchema = propSchemaRef.isReference()
              ? SchemaObject(ref: propSchemaRef.asReference())
              : propSchemaRef.asValue() ?? SchemaObject();

          final isRequired = mergedRequired.contains(propName);

          b.fields.add(
            Field((f) {
              f.name = propName;
              f.modifier = FieldModifier.final$;
              f.type = typeMapper.mapSchemaToType(propSchema, nullable: !isRequired);

              f.annotations.add(
                refer(
                  'JsonKey',
                  'package:json_annotation/json_annotation.dart',
                ).call([], {'name': literalString(propName, raw: true)}),
              );
            }),
          );
        }
      }

      // Add constructor
      b.constructors.add(
        Constructor((c) {
          if (mergedProperties.isNotEmpty) {
            for (final propName in mergedProperties.keys) {
              if (discriminatorProperty != null && propName == discriminatorProperty) {
                continue;
              }

              final isRequired = mergedRequired.contains(propName);
              c.optionalParameters.add(
                Parameter((p) {
                  p.name = propName;
                  p.named = true;
                  p.toThis = true;
                  if (isRequired) {
                    p.required = true;
                  }
                }),
              );
            }
          }
        }),
      );

      // canParse methods are no longer generated - logic is moved to parent union's fromJson

      // Add fromJson factory
      b.methods.add(
        Method((m) {
          m.name = 'fromJson';
          m.static = true;
          m.returns = refer(variantName);
          m.requiredParameters.add(
            Parameter((p) {
              p.name = 'json';
              p.type = TypeReference((t) {
                t.symbol = 'Map';
                t.types.addAll([refer('String'), refer('dynamic')]);
              });
            }),
          );
          m.body = refer('_\$${variantName}FromJson').call([refer('json')]).code;
        }),
      );

      // Add toJson method
      b.methods.add(
        Method((m) {
          m.name = 'toJson';
          m.returns = TypeReference((t) {
            t.symbol = 'Map';
            t.types.addAll([refer('String'), refer('dynamic')]);
          });
          m.annotations.add(refer('override'));
          m.body = refer('_\$${variantName}ToJson').call([refer('this')]).code;
        }),
      );
    });
  }

  /// Generate the factory fromJson for the sealed base class with variant dispatch.
  Constructor _generateUnionFromJson(
    String className,
    SchemaObject schema,
    List<String> variantNames,
    List<Referenceable<SchemaObject>> variants,
    bool isOneOf,
  ) {
    return Constructor((c) {
      c.factory = true;
      c.name = 'fromJson';
      c.requiredParameters.add(
        Parameter((p) {
          p.name = 'json';
          p.type = TypeReference((t) {
            t.symbol = 'Map';
            t.types.addAll([refer('String'), refer('dynamic')]);
          });
        }),
      );

      // Generate dispatch logic with structural checks
      final statements = <Code>[];

      // Declare matches list
      statements.add(Code('final matches = <$className>[];'));
      statements.add(Code(''));

      // Try each variant by checking required properties inline
      // Build a map of variantName -> required properties by iterating through variants
      final variantRequiredProps = <String, List<String>>{};
      for (var i = 0; i < variants.length; i++) {
        final variantRef = variants[i];
        String? variantName;

        if (variantRef.isReference()) {
          final refString = variantRef.asReference();
          if (refString != null) {
            variantName = refString.split('/').last;
            // For references, we can't easily get required props here
            // Use empty list - this will match any JSON (less strict but works)
            variantRequiredProps[variantName] = [];
          }
        } else {
          final variantSchema = variantRef.asValue();
          if (variantSchema != null) {
            // Use the same naming logic as in generateUnion
            variantName = variantSchema.title ?? '$className${_variantSuffix(i)}';
            variantRequiredProps[variantName] = variantSchema.required_?.toList() ?? [];
          }
        }
      }

      // Now generate checks for each variant name (in the order they appear in variantNames)
      for (final variantName in variantNames) {
        final requiredProps = variantRequiredProps[variantName] ?? [];

        if (requiredProps.isEmpty) {
          // No required properties - always matches
          statements.add(Code('matches.add($variantName.fromJson(json));'));
        } else {
          // Check all required properties are present
          final checks = requiredProps.map((prop) => "json.containsKey('$prop')").join(' && ');
          statements.add(Code('if ($checks) {'));
          statements.add(Code('  matches.add($variantName.fromJson(json));'));
          statements.add(Code('}'));
        }
      }

      statements.add(Code(''));

      // Check match count
      statements.add(Code('if (matches.isEmpty) {'));
      statements.add(Code("  throw FormatException('JSON does not match any $className variant');"));
      statements.add(Code('}'));

      if (isOneOf) {
        // For oneOf, exactly one match required
        statements.add(Code('if (matches.length > 1) {'));
        statements.add(
          Code("  throw FormatException('JSON matches multiple $className variants (expected exactly one)');"),
        );
        statements.add(Code('}'));
      }
      // For anyOf, one or more matches is acceptable, just return the first

      statements.add(Code(''));
      statements.add(Code('return matches.first;'));

      c.body = Block.of(statements);
    });
  }

  String _variantSuffix(int index) {
    // Generate suffixes like Variant0, Variant1, etc.
    return 'Variant$index';
  }

  /// Merge properties from allOf items in a schema.
  Map<String, Referenceable<SchemaObject>> _mergeAllOfProperties(SchemaObject schema) {
    final merged = <String, Referenceable<SchemaObject>>{};

    // Add direct properties
    if (schema.properties != null) {
      merged.addAll(schema.properties!);
    }

    // Merge properties from allOf items
    if (schema.allOf != null) {
      for (final item in schema.allOf!) {
        if (!item.isReference()) {
          final itemSchema = item.asValue();
          if (itemSchema != null) {
            final itemProps = _mergeAllOfProperties(itemSchema);
            merged.addAll(itemProps);
          }
        }
      }
    }

    return merged;
  }

  /// Merge required fields from allOf items in a schema.
  Set<String> _mergeAllOfRequired(SchemaObject schema) {
    final merged = <String>{};

    // Add direct required fields
    if (schema.required_ != null) {
      merged.addAll(schema.required_!);
    }

    // Merge required from allOf items
    if (schema.allOf != null) {
      for (final item in schema.allOf!) {
        if (!item.isReference()) {
          final itemSchema = item.asValue();
          if (itemSchema != null) {
            merged.addAll(_mergeAllOfRequired(itemSchema));
          }
        }
      }
    }

    return merged;
  }
}
