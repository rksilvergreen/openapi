import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema.dart';
import 'typed_schema.dart';

abstract class ArrayTypedSchema extends TypedSchema<List<dynamic>> {
  SchemaNode? get items;
  int? get maxItems;
  int? get minItems;
  bool get uniqueItems;
}
