import 'package:openapi_analyzer/v3_0_0/doc_nodes/schema.dart';
import 'typed_schema.dart';

abstract class ObjectTypedSchema extends TypedSchema<Map<String, dynamic>> {
  SchemasMapDocNode? get properties;
  bool? get additionalPropertiesAllowed;
  SchemaNode? get additionalProperties;
  int? get maxProperties;
  int? get minProperties;
  List<String>? get required;
}
