import 'tree_node.dart';
import 'package:collection/collection.dart';

class Edge {
  final TreeNode parent;
  final TreeNode child;
  final String via;

  Edge(this.parent, this.child, this.via);
}

// extension EdgeIterableExtension on Iterable<Edge> {
//   T? to<T extends Node>(String via) => firstWhereOrNull((edge) => (edge.to is T) && (edge.via == via))!.to as T;

//   T? from<T extends Node>(String via) => firstWhereOrNull((edge) => (edge.from is T) && (edge.via == via))!.from as T;
// }