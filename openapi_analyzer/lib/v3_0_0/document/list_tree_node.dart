part of 'document.dart';

abstract class ListTreeNode<CHILD_NODE extends TreeNode> extends TreeNode with ListMixin<CHILD_NODE> {
  late final List<CHILD_NODE> _nodes;

  ListTreeNode(this._nodes);

  @override
  int get length => _nodes.length;

  @override
  set length(int newLength) {
    _nodes.length = newLength;
  }

  @override
  CHILD_NODE operator [](int index) => _nodes[index];

  @override
  void operator []=(int index, CHILD_NODE value) {
    _nodes[index] = value;
  }

  @override
  List<CHILD_NODE> toList({bool growable = true}) => _nodes.toList(growable: growable);
}
