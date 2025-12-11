import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';

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
}
