part of 'document.dart';

abstract class TreeNode {
  late final String _$id;
  Tree? _$tree;

  TreeNode() {
    _$id = Uuid().v4();
  }

  String get $id => _$id;
  Tree? get $tree => _$tree;
  TreeNode? get $parent => $tree?.nodes[$tree?.nodes[$id]?.parent]?.node;
  Map<String, TreeNode>? get $children =>
      $tree?.nodes[$id]?.children.map((k, v) => MapEntry(k.key, $tree!.nodes[v]!.node));
}
