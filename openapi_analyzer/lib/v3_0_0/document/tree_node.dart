part of 'document.dart';

abstract class TreeNode {
  TreeNodeId? $id;
  TreeNode([this.$id]);

  Edge? $parent;
  final List<Edge> $children = [];

  void setId(Tree tree, String jsonPointer) => $id = TreeNodeId(tree, jsonPointer);
}

class TreeNodeId {
  final Tree tree;
  final String jsonPointer;

  TreeNodeId(this.tree, this.jsonPointer);

  Document? get document => tree.document;
  String get absolutePointer => '${tree.id}#$jsonPointer';
}
