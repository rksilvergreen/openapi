import 'package:openapi_analyzer/v3_0_0/doc_nodes/schema.dart';

abstract class ArrayEffectiveSchema {
  SchemaNode? get items;
  int? get maxItems;
  int? get minItems;
  bool? get uniqueItems;
}

