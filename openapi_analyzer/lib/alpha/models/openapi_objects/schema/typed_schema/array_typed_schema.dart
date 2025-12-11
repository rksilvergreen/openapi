import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';

import 'typed_schema.dart';

class ArrayTypedSchema extends SingleTypeTypedSchema<List<dynamic>, ArrayTypedSchema> {
  final SchemaNode? items;
  final int? maxItems;
  final int? minItems;
  final bool? uniqueItems;

  ArrayTypedSchema({
    required SchemaNode $node,
    required String description,
    required bool readOnly,
    required bool writeOnly,
    required Map<String, dynamic>? example,
    required bool deprecated,
    required bool nullable,
    required List<dynamic>? defaultValue,
    required List<List<dynamic>> enumValues,
    this.items,
    this.maxItems,
    this.minItems,
    this.uniqueItems,
  }) : super(
         $node,
         SchemaType.array,
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
