import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';

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
}
