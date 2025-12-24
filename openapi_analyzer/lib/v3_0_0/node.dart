import 'package:collection/collection.dart';
import 'edge.dart';

abstract class Node {
  final NodeId $id;
  // final Map<String, dynamic> json;
  Node(String document, String jsonPointer) : $id = NodeId(document, jsonPointer);

  final List<Edge> $from = [];
  final List<Edge> $to = [];

  T? parent<T extends Node>(String? via, EdgeForm? form) =>
      $from
              .firstWhereOrNull(
                (edge) => edge.from is T && (via == null || edge.via == via) && (form == null || edge.form == form),
              )
              ?.from
          as T?;

  /// Returns the "true parent" - either the single inline parent or the single referenced parent.
  /// A true parent is:
  /// - The single inline parent (if there's exactly one inline edge), OR
  /// - The single referenced parent (if there's no inline parent and exactly one referenced edge)
  T? trueParent<T extends Node>([String? via]) {
    final edge = trueParentEdge<T>(via);
    return edge?.from as T?;
  }

  /// Returns the edge to the "true parent".
  /// Returns the inline edge if there's exactly one, otherwise the referenced edge if there's exactly one.
  Edge? trueParentEdge<T extends Node>([String? via]) {
    // First, look for inline edges
    final inlineEdges = $from
        .where((edge) => edge.from is T && (via == null || edge.via == via) && edge.form == EdgeForm.inline)
        .toList();

    if (inlineEdges.length == 1) {
      return inlineEdges.first;
    }

    // If no inline edges (or multiple), look for referenced edges
    if (inlineEdges.isEmpty) {
      final referencedEdges = $from
          .where((edge) => edge.from is T && (via == null || edge.via == via) && edge.form == EdgeForm.referenced)
          .toList();

      if (referencedEdges.length == 1) {
        return referencedEdges.first;
      }
    }

    return null;
  }
}

class NodeId {
  final String document;
  final String jsonPointer;
  final String absolutePointer;

  const NodeId(this.document, this.jsonPointer) : absolutePointer = '$document#$jsonPointer';
}