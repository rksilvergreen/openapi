import 'encoding.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class EncodingsMap implements MapBase<String, Encoding> {
  Map<String, dynamic>? get extensions;
}

class EncodingsMapNode extends MapNode<EncodingNode, Encoding> implements EncodingsMap {
  EncodingsMapNode(super.json, super.document, super.jsonPointer);
}
