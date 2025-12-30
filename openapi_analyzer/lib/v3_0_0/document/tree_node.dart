part of 'document.dart';

abstract class TreeNode {
  TreeNodeId _$id;
  TreeNode(this._$id);

  // Edge? $parent;
  // final List<Edge> $children = [];

  // Map<String, TreeNode?> get _$children => _$id.tree.children;
  TreeNode? _$parent() => _$id.tree.nodes[_$id.tree.parents[_$id.jsonPointer]!];
  TreeNode? _$child(String key) => _$id.tree.nodes[_$id.tree.children[_$id.jsonPointer]![key]!];

  void _setId(Tree tree, String jsonPointer) => _$id = TreeNodeId(tree, jsonPointer);
}

class TreeNodeId {
  final Tree tree;
  final String jsonPointer;

  TreeNodeId(this.tree, this.jsonPointer);

  Document? get document => tree.document;
  String get absolutePointer => '${tree.id}#$jsonPointer';
}
