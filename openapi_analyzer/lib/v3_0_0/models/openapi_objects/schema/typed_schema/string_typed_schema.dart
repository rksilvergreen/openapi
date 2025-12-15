import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_graph.dart';
import '../raw_schema.dart';
import '../../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';

import 'typed_schema.dart';

class StringTypedSchema extends SingleTypeTypedSchema<String, StringTypedSchema> {
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final String? format;

  StringTypedSchema({
    required SchemaNode $node,
    required String description,
    required bool readOnly,
    required bool writeOnly,
    required Map<String, dynamic>? example,
    required bool deprecated,
    required bool nullable,
    required String? defaultValue,
    required List<String> enumValues,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.format,
  }) : super(
         $node,
         SchemaType.string,
         description,
         readOnly,
         writeOnly,
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );

  factory StringTypedSchema.fromRaw(SchemaNode node, RawSchema raw) {
    _validateConstraints(raw, node, OpenApiGraph.i.validationContext);
    return StringTypedSchema(
      $node: node,
      description: raw.description ?? '',
      readOnly: raw.readOnly,
      writeOnly: raw.writeOnly,
      example: raw.example,
      deprecated: raw.deprecated,
      nullable: raw.nullable,
      defaultValue: raw.default_ is String ? raw.default_ as String : null,
      enumValues: (raw.enum_?.whereType<String>().toList()) ?? [],
      minLength: raw.minLength,
      maxLength: raw.maxLength,
      pattern: raw.pattern,
      format: raw.format,
    );
  }

  /// Validates atomic constraints for string type.
  static void _validateConstraints(RawSchema raw, SchemaNode node, ValidationContext ctx) {
    final path = node.$id.relativePath;

    if (raw.minLength != null && raw.maxLength != null) {
      if (raw.minLength! > raw.maxLength!) {
        ctx.addException(
          OpenApiValidationException(
            path,
            'minLength (${raw.minLength}) cannot be greater than maxLength (${raw.maxLength})',
            specReference: 'JSON Schema Validation',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }
}
