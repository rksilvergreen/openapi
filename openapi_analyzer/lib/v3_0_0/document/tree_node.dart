part of 'document.dart';

abstract class TreeNode {
  @JsonKey(includeFromJson: false, includeToJson: false)
  TreeNodeId? _$id;
  TreeNode([this._$children = const {}]);

  @JsonKey(includeFromJson: false, includeToJson: false)
  Edge? $parent;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<Edge> $children = [];

  final Map<String, Edge?> _$children;

  void setId(Tree tree, String jsonPointer) => _$id = TreeNodeId(tree, jsonPointer);
}

class TreeNodeId {
  final Tree tree;
  final String jsonPointer;

  TreeNodeId(this.tree, this.jsonPointer);

  Document? get document => tree.document;
  String get absolutePointer => '${tree.id}#$jsonPointer';
}
