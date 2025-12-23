import 'link.dart';
import '../map_node.dart';
import 'dart:collection';
import 'package:openapi_analyzer/v3_0_0/objects/link.dart';

class LinksMapNode extends MapNode<LinkNode, Link> implements LinksMap {
  LinksMapNode(super.json, super.document, super.jsonPointer);
}
