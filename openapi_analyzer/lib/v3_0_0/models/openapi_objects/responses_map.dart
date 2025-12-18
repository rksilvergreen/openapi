import 'response.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class ResponsesMap implements MapBase<String, Response> {
  Map<String, dynamic>? get extensions;
}

class ResponsesMapNode extends MapNode<ResponseNode, Response> implements ResponsesMap {
  ResponsesMapNode(super.json, super.document, super.jsonPointer);
}
