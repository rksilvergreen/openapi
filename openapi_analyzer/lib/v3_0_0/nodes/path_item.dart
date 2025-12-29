import '../document/tree_nodes/operation.dart';
import 'server.dart';
import 'parameter.dart';
import '../node.dart';
import '../map_node.dart';

class PathItem extends Node {
  final Operation? get_;
  final Operation? put;
  final Operation? post;
  final Operation? delete;
  final Operation? options;
  final Operation? head;
  final Operation? patch;
  final Operation? trace;
  final ServerList? servers;
  final ParametersList? parameters;
  final Map<String, dynamic>? extensions;

  PathItem({this.get_, this.put, this.post, this.delete, this.options, this.head, this.patch, this.trace, this.servers, this.parameters, this.extensions});
}

class PathsMap extends MapNode<PathItem> {
  final Map<String, dynamic>? extensions;
  PathsMap({this.extensions});
}

