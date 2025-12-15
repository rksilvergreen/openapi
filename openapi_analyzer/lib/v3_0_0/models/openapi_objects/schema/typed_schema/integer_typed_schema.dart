import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_graph.dart';
import '../raw_schema.dart';
import '../../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';

import 'typed_schema.dart';

class IntegerTypedSchema extends SingleTypeTypedSchema<int, IntegerTypedSchema> {
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;
  final String? format;

  IntegerTypedSchema({
    required SchemaNode $node,
    required String description,
    required bool readOnly,
    required bool writeOnly,
    required Map<String, dynamic>? example,
    required bool deprecated,
    required bool nullable,
    required int? defaultValue,
    required List<int> enumValues,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.format,
  }) : super(
         $node,
         SchemaType.integer,
         description,
         readOnly,
         writeOnly,
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );

  factory IntegerTypedSchema.fromRaw(SchemaNode node, RawSchema raw) {
    _validateConstraints(raw, node, OpenApiGraph.i.validationContext);
    return IntegerTypedSchema(
      $node: node,
      description: raw.description ?? '',
      readOnly: raw.readOnly,
      writeOnly: raw.writeOnly,
      example: raw.example,
      deprecated: raw.deprecated,
      nullable: raw.nullable,
      defaultValue: raw.default_ is int ? raw.default_ as int : null,
      enumValues: (raw.enum_?.whereType<int>().toList()) ?? [],
      multipleOf: raw.multipleOf?.toDouble(),
      maximum: raw.maximum?.toInt(),
      exclusiveMaximum: raw.exclusiveMaximum is num ? (raw.exclusiveMaximum as num).toInt() : null,
      minimum: raw.minimum?.toInt(),
      exclusiveMinimum: raw.exclusiveMinimum is num ? (raw.exclusiveMinimum as num).toInt() : null,
      format: raw.format,
    );
  }

  /// Validates atomic constraints for integer type.
  static void _validateConstraints(RawSchema raw, SchemaNode node, ValidationContext ctx) {
    final path = node.$id.relativePath;

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
