import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/schema/schema_object.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/enums.dart';

/// Generates Dart abstract interfaces from oneOf/discriminator schemas.
///
/// Implements patterns from GENERATION_ALGORITHM.md:
/// - Rule 2: oneOf → Abstract Interface
/// - Rule 7: Discriminator → Abstract Interface with value-based discrimination
class InterfaceGenerator {
  /// Generate an abstract interface for a oneOf or discriminator schema.
  ///
  /// For discriminator schemas, uses value-based discrimination.
  /// For non-discriminator schemas, uses field-based discrimination.
  Class generateInterface({
    required String interfaceName,
    required SchemaObject schema,
    required List<String> variantNames,
    String? discriminatorProperty,
    Map<String, String>? discriminatorMapping,
    List<String>? parentInterfaces,
    Map<String, List<String>>? variantRequiredProperties, // variantName -> list of required property names
  }) {
    return Class((b) {
      b.name = interfaceName;
      b.abstract = true;
      b.modifier = ClassModifier.interface;

      // Implement parent interfaces if any
      if (parentInterfaces != null && parentInterfaces.isNotEmpty) {
        b.implements.addAll(parentInterfaces.map((i) => refer(i)));
      }

      // Add abstract getter for discriminator property if present
      // Discriminator properties should always be in the interface, even if not in properties
      if (discriminatorProperty != null) {
        // Check if discriminator is already in properties
        final discriminatorInProperties = schema.properties?.containsKey(discriminatorProperty) ?? false;
        
        if (!discriminatorInProperties) {
          // Add discriminator as abstract getter (always required, always String)
          final discriminatorSchema = SchemaObject(type: SchemaType.string);
          b.methods.add(_generateAbstractGetter(discriminatorProperty, discriminatorSchema, isRequired: true));
        }
      }

      // Add abstract getters for properties if schema has them
      final requiredFields = schema.required_?.toSet() ?? <String>{};
      if (schema.properties != null && schema.properties!.isNotEmpty) {
        for (final entry in schema.properties!.entries) {
          final propName = entry.key;
          final propSchema = entry.value.asValue();

          if (propSchema != null) {
            final isRequired = requiredFields.contains(propName);
            b.methods.add(_generateAbstractGetter(propName, propSchema, isRequired: isRequired));
          }
        }
      }

      // Add factory constructor with discrimination logic
      b.constructors.add(
        _generateFromJsonFactory(interfaceName, variantNames, discriminatorProperty, discriminatorMapping, variantRequiredProperties),
      );

      // Add abstract toJson method
      // Use dynamic return type to support both object variants (Map) and primitive wrappers (primitives)
      b.methods.add(
        Method((m) {
          m.name = 'toJson';
          m.returns = refer('dynamic');
        }),
      );
    });
  }

  /// Generate an abstract getter for an interface property.
  Method _generateAbstractGetter(String propertyName, SchemaObject schema, {bool isRequired = false}) {
    return Method((m) {
      m.name = ReCase(propertyName).camelCase;
      m.type = MethodType.getter;
      // Property is nullable if schema is explicitly nullable OR if it's not required
      final isNullable = schema.nullable == true || !isRequired;
      m.returns = _mapToType(schema, isNullable: isNullable);
      // Abstract getter - no body
    });
  }

  /// Generate the factory fromJson constructor with discrimination logic.
  Constructor _generateFromJsonFactory(
    String interfaceName,
    List<String> variantNames,
    String? discriminatorProperty,
    Map<String, String>? discriminatorMapping,
    Map<String, List<String>>? variantRequiredProperties,
  ) {
    return Constructor((c) {
      c.factory = true;
      c.name = 'fromJson';
      c.requiredParameters.add(
        Parameter((p) {
          p.name = 'json';
          p.type = refer('dynamic');
        }),
      );

      // Build discrimination logic
      final code = StringBuffer();

      if (discriminatorProperty != null) {
        // Value-based discrimination (for discriminator schemas)
        code.writeln('if (json is Map<String, dynamic>) {');

        for (final variantName in variantNames) {
          // Get the discriminator value for this variant
          String? discriminatorValue;

          // Check if there's a mapping entry for this variant
          if (discriminatorMapping != null) {
            discriminatorMapping.forEach((key, value) {
              if (value.endsWith(variantName)) {
                discriminatorValue = key;
              }
            });
          }

          // If no mapping, use the variant name itself
          discriminatorValue ??= variantName;

          code.writeln("  if (json['$discriminatorProperty'] == '$discriminatorValue') {");
          code.writeln('    return $variantName.fromJson(json);');
          code.writeln('  }');
        }

        code.writeln("  throw Exception('Invalid JSON for $interfaceName');");
        code.writeln('}');
        code.writeln("throw Exception('Invalid JSON for $interfaceName');");
      } else {
        // Field-based discrimination (for non-discriminator schemas)
        code.writeln('if (json is Map<String, dynamic>) {');

        // Sort variants: those with required properties first, then those without
        // This ensures more specific matches are checked before generic ones
        final variantsWithProps = <String>[];
        final variantsWithoutProps = <String>[];
        
        for (final variantName in variantNames) {
          // Skip primitive wrappers - they'll be handled separately
          final isPrimitiveWrapper = variantName.endsWith('StringValue') ||
              variantName.endsWith('IntegerValue') ||
              variantName.endsWith('NumberValue') ||
              variantName.endsWith('BooleanValue');

          if (!isPrimitiveWrapper) {
            final requiredProps = variantRequiredProperties?[variantName] ?? [];
            if (requiredProps.isEmpty) {
              variantsWithoutProps.add(variantName);
            } else {
              variantsWithProps.add(variantName);
            }
          }
        }
        
        // Check variants with required properties first (more specific)
        for (final variantName in variantsWithProps) {
          final requiredProps = variantRequiredProperties![variantName]!;
          final checks = requiredProps.map((prop) => "json.containsKey('$prop')").join(' && ');
          code.writeln('  if ($checks) {');
          code.writeln('    return $variantName.fromJson(json);');
          code.writeln('  }');
        }
        
        // Then check variants without required properties (less specific, always match)
        // Only if there are variants without props, check them as fallback
        if (variantsWithoutProps.isNotEmpty) {
          // If we have variants without required props, they'll match any JSON
          // So we should check them last, and if none of the specific variants matched, use the first generic one
          code.writeln('  // Fallback to variants without required properties');
          code.writeln('  return ${variantsWithoutProps.first}.fromJson(json);');
        } else {
          // No fallback variants - throw error if no specific variant matched
          code.writeln("  throw Exception('JSON does not match any $interfaceName variant');");
        }
        code.writeln('}');

        // Handle primitive types (for string, int, etc.) - inline type checks
        code.writeln('// Handle primitive types');
        for (final variantName in variantNames) {
          // Detect primitive wrapper by checking if it ends with a known type suffix
          // Use inline type checks instead of canParse methods
          if (variantName.endsWith('StringValue')) {
            code.writeln('if (json is String) {');
            code.writeln('  return $variantName(value: json);');
            code.writeln('}');
          } else if (variantName.endsWith('IntegerValue')) {
            code.writeln('if (json is int) {');
            code.writeln('  return $variantName(value: json);');
            code.writeln('}');
          } else if (variantName.endsWith('NumberValue')) {
            code.writeln('if (json is double) {');
            code.writeln('  return $variantName(value: json);');
            code.writeln('}');
          } else if (variantName.endsWith('BooleanValue')) {
            code.writeln('if (json is bool) {');
            code.writeln('  return $variantName(value: json);');
            code.writeln('}');
          }
        }

        code.writeln("throw Exception('Invalid JSON for $interfaceName');");
      }

      c.body = Code(code.toString());
    });
  }

  /// Map a schema to a Dart type reference for getters.
  Reference _mapToType(SchemaObject schema, {bool? isNullable}) {
    final typeName = schema.type?.name;
    final nullable = isNullable ?? (schema.nullable == true);

    switch (typeName) {
      case 'string':
        return refer(nullable ? 'String?' : 'String');
      case 'integer':
        return refer(nullable ? 'int?' : 'int');
      case 'number':
        return refer(nullable ? 'double?' : 'double');
      case 'boolean':
        return refer(nullable ? 'bool?' : 'bool');
      default:
        return refer(nullable ? 'dynamic?' : 'dynamic');
    }
  }
}
