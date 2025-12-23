import '../map_node.dart';
import 'dart:collection';
import 'server_variable.dart';
import 'package:openapi_analyzer/v3_0_0/objects/server.dart';

class ServerVariablesMapNode extends MapNode<ServerVariableNode, ServerVariable> implements ServerVariablesMap {
  ServerVariablesMapNode(super.json, super.document, super.jsonPointer);
}
