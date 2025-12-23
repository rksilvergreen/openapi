import '../list_node.dart';
import 'dart:collection';
import 'server.dart';

abstract class ServerList implements ListBase<Server> {}

class ServerListNode extends ListNode<ServerNode, Server> implements ServerList {
  ServerListNode(super.json, super.document, super.jsonPointer);
}
