import 'header.dart';
import '../map_node.dart';
import 'dart:collection';
import 'package:openapi_analyzer/v3_0_0/objects/header.dart';

class HeadersMapNode extends MapNode<HeaderNode, Header> implements HeadersMap {
  HeadersMapNode(super.json, super.document, super.jsonPointer);
}
