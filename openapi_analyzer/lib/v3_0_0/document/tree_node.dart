part of 'document.dart';

abstract class TreeNode {
  TreeNodeId _$id;
  TreeNode(this._$id);

  // Edge? $parent;
  // final List<Edge> $children = [];

  // Map<String, TreeNode?> get _$children => _$id.tree.children;
  TreeNode? _$parent() => _$id.tree.nodes[_$id.tree.parents[_$id.pointer]!];
  TreeNode? _$child(String key) => _$id.tree.nodes[_$id.tree.children[_$id.pointer]![key]!];

  void _setId(Tree tree, String pointer) => _$id = TreeNodeId(tree, pointer);
}

class TreeNodeId {
  final Tree tree;
  final String pointer;

  TreeNodeId(this.tree, this.pointer);

  Document? get document => tree.document;
  String get absolutePointer => '${tree.id}#$pointer';
}
