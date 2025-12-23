import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema.dart';

abstract class ArrayEffectiveSchema {
  SchemaNode? get items;
  int? get maxItems;
  int? get minItems;
  bool? get uniqueItems;
}

