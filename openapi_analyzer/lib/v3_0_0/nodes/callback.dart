import 'path_item.dart';
import '../node.dart';
import '../map_node.dart';

class Callback extends Node {
  final PathsMap expressions;
  final Map<String, dynamic>? extensions;
  Callback({required this.expressions, this.extensions});
}

class CallbacksMap extends MapNode<Callback> {
  final Map<String, dynamic>? extensions;
  CallbacksMap({this.extensions});
}
