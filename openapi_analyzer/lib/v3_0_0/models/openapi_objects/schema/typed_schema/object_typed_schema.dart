import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_graph.dart';
import '../raw_schema.dart';
import '../../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';

import 'typed_schema.dart';

class ObjectTypedSchema extends SingleTypeTypedSchema<Map<String, dynamic>, ObjectTypedSchema> {
  final Map<String, SchemaNode>? properties;
  final bool additionalPropertiesAllowed;
  final SchemaNode? additionalProperties;
  final int? maxProperties;
  final int? minProperties;
  final List<String>? required;

  ObjectTypedSchema({
    required SchemaNode $node,
    required String description,
    required bool readOnly,
    required bool writeOnly,
    required Map<String, dynamic>? example,
    required bool deprecated,
    required bool nullable,
    required Map<String, dynamic>? defaultValue,
    required List<Map<String, dynamic>> enumValues,
    this.properties,
    this.additionalPropertiesAllowed = true,
    this.additionalProperties,
    this.maxProperties,
    this.minProperties,
    this.required,
  }) : super(
         $node,
         SchemaType.object,
         description,
         readOnly,
         writeOnly,
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );

  factory ObjectTypedSchema.fromRaw(SchemaNode node, RawSchema raw) {
    _validateConstraints(raw, node, OpenApiGraph.i.validationContext);
    return ObjectTypedSchema(
      $node: node,
      description: raw.description ?? '',
      readOnly: raw.readOnly,
      writeOnly: raw.writeOnly,
      example: raw.example,
      deprecated: raw.deprecated,
      nullable: raw.nullable,
      defaultValue: raw.default_ is Map ? raw.default_ as Map<String, dynamic> : null,
      enumValues: (raw.enum_?.whereType<Map>().cast<Map<String, dynamic>>().toList()) ?? [],
      minProperties: raw.minProperties,
      maxProperties: raw.maxProperties,
      required: raw.required_,
    );
  }

  /// Validates atomic constraints for object type.
  static void _validateConstraints(RawSchema raw, SchemaNode node, ValidationContext ctx) {
    final path = node.$id.relativePath;

    if (raw.minProperties != null && raw.maxProperties != null) {
      if (raw.minProperties! > raw.maxProperties!) {
        ctx.addException(
          OpenApiValidationException(
            path,
            'minProperties (${raw.minProperties}) cannot be greater than maxProperties (${raw.maxProperties})',
            specReference: 'JSON Schema Validation',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }

    // Validate required properties exist in properties
    if (raw.required_ != null && raw.properties != null) {
      for (final requiredProp in raw.required_!) {
        if (!raw.properties!.containsKey(requiredProp)) {
          ctx.addException(
            OpenApiValidationException(
              path,
              'Required property "$requiredProp" not found in properties',
              specReference: 'JSON Schema Validation',
              severity: ValidationSeverity.low, // Not critical - could be in allOf
            ),
          );
        }
      }
    }
  }
}
