import 'package:code_builder/code_builder.dart';
import 'package:openapi_analyzer/openapi_analyzer.dart';

import 'dart_name_generator.dart';

/// Generates Dart enum code for enum schemas using code_builder.
class EnumGenerator {
  /// Generate a Dart enum for a schema with enum values.
  Enum generateEnum(SchemaObject schema, String enumName) {
    return Enum((b) {
      b.name = enumName;

      // Add enum values
      if (schema.enum_ != null) {
        for (final value in schema.enum_!) {
          b.values.add(_generateEnumValue(value, schema: schema));
        }
      }
    });
  }

  EnumValue _generateEnumValue(dynamic value, {SchemaObject? schema}) {
    final String valueStr = value.toString();
    // Convert to valid Dart identifier
    final dartName = DartNameGenerator.normalizeIdentifier(valueStr);

    return EnumValue((b) {
      b.name = dartName;

      // Determine the appropriate literal type for @JsonValue
      // Check schema type first, then fall back to value type
      Expression jsonValueLiteral;

      if (schema?.type != null) {
        // Use schema type to determine literal type
        if (schema!.type!.name == 'integer') {
          // Integer enum - parse value as int
          if (value is int) {
            jsonValueLiteral = literal(value);
          } else if (value is num) {
            jsonValueLiteral = literal(value.toInt());
          } else {
            // Try to parse string as int
            final intValue = int.tryParse(valueStr);
            if (intValue != null) {
              jsonValueLiteral = literal(intValue);
            } else {
              jsonValueLiteral = literalString(valueStr);
            }
          }
        } else if (schema.type!.name == 'number') {
          // Number enum - parse value as double
          if (value is double) {
            jsonValueLiteral = literalNum(value);
          } else if (value is int) {
            jsonValueLiteral = literalNum(value.toDouble());
          } else if (value is num) {
            jsonValueLiteral = literalNum(value.toDouble());
          } else {
            // Try to parse string as double
            final doubleValue = double.tryParse(valueStr);
            if (doubleValue != null) {
              jsonValueLiteral = literalNum(doubleValue);
            } else {
              jsonValueLiteral = literalString(valueStr);
            }
          }
        } else if (schema.type!.name == 'boolean') {
          // Boolean enum
          if (value is bool) {
            jsonValueLiteral = literal(value);
          } else {
            jsonValueLiteral = literalString(valueStr);
          }
        } else {
          // String or other types - use string literal
          jsonValueLiteral = literalString(valueStr);
        }
      } else {
        // No schema type - infer from value type
        if (value is int) {
          jsonValueLiteral = literal(value);
        } else if (value is double || value is num) {
          jsonValueLiteral = literalNum(value);
        } else if (value is bool) {
          jsonValueLiteral = literal(value);
        } else {
          jsonValueLiteral = literalString(valueStr);
        }
      }

      // Add @JsonValue annotation
      b.annotations.add(refer('JsonValue', 'package:json_annotation/json_annotation.dart').call([jsonValueLiteral]));
    });
  }
}
