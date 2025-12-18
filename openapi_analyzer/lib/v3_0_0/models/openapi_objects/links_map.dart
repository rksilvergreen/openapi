import 'link.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class LinksMap implements MapBase<String, Link> {
  Map<String, dynamic>? get extensions;
}

class LinksMapNode extends MapNode<LinkNode, Link> implements LinksMap {
  LinksMapNode(super.json, super.document, super.jsonPointer);
}
