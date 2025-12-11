import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';

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
}
