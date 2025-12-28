import 'package:collection/collection.dart';
import 'document.dart';
import 'tree.dart';
import 'edge.dart';

abstract class TreeNode {
  NodeId? $id;
  // final Map<String, dynamic> json;
  TreeNode([this.$id]);

  Edge? $parent;
  final List<Edge> $children = [];

  void setId(Tree tree, String jsonPointer) => $id = NodeId(tree, jsonPointer);

  // T? parent<T extends Node>(String? via, EdgeForm? form) =>
  //     $from
  //             .firstWhereOrNull(
  //               (edge) => edge.from is T && (via == null || edge.via == via) && (form == null || edge.form == form),
  //             )
  //             ?.from
  //         as T?;

  // /// Returns the "true parent" - either the single inline parent or the single referenced parent.
  // /// A true parent is:
  // /// - The single inline parent (if there's exactly one inline edge), OR
  // /// - The single referenced parent (if there's no inline parent and exactly one referenced edge)
  // T? trueParent<T extends Node>([String? via]) {
  //   final edge = trueParentEdge<T>(via);
  //   return edge?.from as T?;
  // }

  // /// Returns the edge to the "true parent".
  // /// Returns the inline edge if there's exactly one, otherwise the referenced edge if there's exactly one.
  // Edge? trueParentEdge<T extends Node>([String? via]) {
  //   // First, look for inline edges
  //   final inlineEdges = $from
  //       .where((edge) => edge.from is T && (via == null || edge.via == via) && edge.form == EdgeForm.inline)
  //       .toList();

  //   if (inlineEdges.length == 1) {
  //     return inlineEdges.first;
  //   }

  //   // If no inline edges (or multiple), look for referenced edges
  //   if (inlineEdges.isEmpty) {
  //     final referencedEdges = $from
  //         .where((edge) => edge.from is T && (via == null || edge.via == via) && edge.form == EdgeForm.referenced)
  //         .toList();

  //     if (referencedEdges.length == 1) {
  //       return referencedEdges.first;
  //     }
  //   }

  //   return null;
  // }
}

class NodeId {
  final Tree tree;
  final String jsonPointer;

  NodeId(this.tree, this.jsonPointer);

  Document? get document => tree.document;
  String get absolutePointer => '${tree.id}#$jsonPointer';
}
