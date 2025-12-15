import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_graph.dart';
import '../raw_schema.dart';
import '../../../../validation/validation_context.dart';

import 'typed_schema.dart';

class BooleanTypedSchema extends SingleTypeTypedSchema<bool, BooleanTypedSchema> {
  final String? format;

  BooleanTypedSchema({
    required SchemaNode $node,
    required String description,
    required bool readOnly,
    required bool writeOnly,
    required Map<String, dynamic>? example,
    required bool deprecated,
    required bool nullable,
    required bool? defaultValue,
    required List<bool> enumValues,
    this.format,
  }) : super(
         $node,
         SchemaType.boolean,
         description,
         readOnly,
         writeOnly,
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );

  factory BooleanTypedSchema.fromRaw(SchemaNode node, RawSchema raw) {
    _validateConstraints(raw, node, OpenApiGraph.i.validationContext);
    return BooleanTypedSchema(
      $node: node,
      description: raw.description ?? '',
      readOnly: raw.readOnly,
      writeOnly: raw.writeOnly,
      example: raw.example,
      deprecated: raw.deprecated,
      nullable: raw.nullable,
      defaultValue: raw.default_ is bool ? raw.default_ as bool : null,
      enumValues: (raw.enum_?.whereType<bool>().toList()) ?? [],
    );
  }

  /// Validates atomic constraints for boolean type.
  static void _validateConstraints(RawSchema raw, SchemaNode node, ValidationContext ctx) {
    // Boolean type has no specific constraints to validate
  }
}
