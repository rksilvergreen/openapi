import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema.dart';
import 'typed_schema.dart';

abstract class ObjectTypedSchema extends TypedSchema<Map<String, dynamic>> {
  SchemasMapNode? get properties;
  bool? get additionalPropertiesAllowed;
  SchemaNode? get additionalProperties;
  int? get maxProperties;
  int? get minProperties;
  List<String>? get required;
}

