import '../node.dart';
import '../list_node.dart';
import '../map_node.dart';

class Server extends Node {
  final String url;
  final String? description;
  final ServerVariablesMap? variables;
  final Map<String, dynamic>? extensions;
  final String $name;

  Server({required this.url, this.description, this.variables, this.extensions, required this.$name});
}

class ServerList extends ListNode<Server> {}

class ServerVariable extends Node {
  final List<String>? enum_;
  final String default_;
  final String? description;
  final Map<String, dynamic>? extensions;

  ServerVariable({this.enum_, required this.default_, this.description, this.extensions});
}

class ServerVariablesMap extends MapNode<ServerVariable> {
  final Map<String, dynamic>? extensions;
  ServerVariablesMap({this.extensions});
}

