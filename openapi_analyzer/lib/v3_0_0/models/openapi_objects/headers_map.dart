import 'header.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class HeadersMap implements MapBase<String, Header> {
  Map<String, dynamic>? get extensions;
}

class HeadersMapNode extends MapNode<HeaderNode, Header> implements HeadersMap {
  HeadersMapNode(super.json, super.document, super.jsonPointer);
}
