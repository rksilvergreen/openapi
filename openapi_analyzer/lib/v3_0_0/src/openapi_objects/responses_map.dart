import 'response.dart';
import '../map_node.dart';
import 'dart:collection';
import 'package:openapi_analyzer/v3_0_0/objects/response.dart';

class ResponsesMapNode extends MapNode<ResponseNode, Response> implements ResponsesMap {
  ResponsesMapNode(super.json, super.document, super.jsonPointer);
}
