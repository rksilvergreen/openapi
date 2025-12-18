import '../map_node.dart';
import 'dart:collection';
import 'server_variable.dart';

abstract class ServerVariablesMap implements MapBase<String, ServerVariable> {
  Map<String, dynamic>? get extensions;
}

class ServerVariablesMapNode extends MapNode<ServerVariableNode, ServerVariable> implements ServerVariablesMap {
  ServerVariablesMapNode(super.json, super.document, super.jsonPointer);
}
