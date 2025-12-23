import 'request_body.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class RequestBodiesMap implements MapBase<String, RequestBody> {
  Map<String, dynamic>? get extensions;
}

class RequestBodiesMapNode extends MapNode<RequestBodyNode, RequestBody> implements RequestBodiesMap {
  RequestBodiesMapNode(super.json, super.document, super.jsonPointer);
}

