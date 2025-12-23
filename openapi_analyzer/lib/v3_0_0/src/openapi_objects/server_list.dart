import '../list_node.dart';
import 'dart:collection';
import 'server.dart';
import 'package:openapi_analyzer/v3_0_0/objects/server.dart';

class ServerListNode extends ListNode<ServerNode, Server> implements ServerList {
  ServerListNode(super.json, super.document, super.jsonPointer);
}
