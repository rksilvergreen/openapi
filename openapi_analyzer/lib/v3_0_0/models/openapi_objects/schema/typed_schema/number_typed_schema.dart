import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_graph.dart';
import '../raw_schema.dart';
import '../../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';

import 'typed_schema.dart';

class NumberTypedSchema extends SingleTypeTypedSchema<double, NumberTypedSchema> {
  final double? multipleOf;
  final double? maximum;
  final double? exclusiveMaximum;
  final double? minimum;
  final double? exclusiveMinimum;
  final String? format;

  NumberTypedSchema({
    required SchemaNode $node,
    required String description,
    required bool readOnly,
    required bool writeOnly,
    required Map<String, dynamic>? example,
    required bool deprecated,
    required bool nullable,
    required double? defaultValue,
    required List<double> enumValues,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.format,
  }) : super(
         $node,
         SchemaType.number,
         description,
         readOnly,
         writeOnly,
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );

  factory NumberTypedSchema.fromRaw(SchemaNode node, RawSchema raw) {
    _validateConstraints(raw, node, OpenApiGraph.i.validationContext);
    return NumberTypedSchema(
      $node: node,
      description: raw.description ?? '',
      readOnly: raw.readOnly,
      writeOnly: raw.writeOnly,
      example: raw.example,
      deprecated: raw.deprecated,
      nullable: raw.nullable,
      defaultValue: raw.default_ is num ? (raw.default_ as num).toDouble() : null,
      enumValues: (raw.enum_?.whereType<num>().map((e) => e.toDouble()).toList()) ?? [],
      multipleOf: raw.multipleOf?.toDouble(),
      maximum: raw.maximum?.toDouble(),
      exclusiveMaximum: raw.exclusiveMaximum is num ? (raw.exclusiveMaximum as num).toDouble() : null,
      minimum: raw.minimum?.toDouble(),
      exclusiveMinimum: raw.exclusiveMinimum is num ? (raw.exclusiveMinimum as num).toDouble() : null,
      format: raw.format,
    );
  }

  /// Validates atomic constraints for number type.
  static void _validateConstraints(RawSchema raw, SchemaNode node, ValidationContext ctx) {
    final path = node.$id.jsonPointer;

    if (raw.minimum != null && raw.maximum != null) {
      if (raw.minimum! > raw.maximum!) {
        ctx.addException(
          OpenApiValidationException(
            path,
            'minimum (${raw.minimum}) cannot be greater than maximum (${raw.maximum})',
            specReference: 'JSON Schema Validation',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
    if (raw.multipleOf != null && raw.multipleOf! <= 0) {
      ctx.addException(
        OpenApiValidationException(
          path,
          'multipleOf must be greater than 0',
          specReference: 'JSON Schema Validation',
          severity: ValidationSeverity.critical,
        ),
      );
    }
  }
}
