part of 'document.dart';

abstract class TreeNode {
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String _$id;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Tree? _$tree;

  TreeNode() {
    _$id = Uuid().v4();
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get $id => _$id;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Tree? get $tree => _$tree;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TreeNode? get $parent => $tree?.nodes[$tree?.nodes[$id]?.parent]?.node;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, TreeNode>? get $children =>
      $tree?.nodes[$id]?.children.map((k, v) => MapEntry(k.key, $tree!.nodes[v]!.node));
}


