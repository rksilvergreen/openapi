import 'schema.dart';
import '../../map_node.dart';
import 'dart:collection';

abstract class SchemasMap implements MapBase<String, Schema> {
  Map<String, dynamic>? get extensions;
}

class SchemasMapNode extends MapNode<SchemaNode, Schema> implements SchemasMap {
  SchemasMapNode(super.json, super.document, super.jsonPointer);
}
