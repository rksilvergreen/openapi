part of 'document.dart';

abstract class ListTreeNode<CHILD_NODE extends TreeNode> extends TreeNode with ListMixin<CHILD_NODE> {
  late final List<CHILD_NODE> _childNodes;

  ListTreeNode(List<CHILD_NODE> childNodes) : _childNodes = childNodes;

  @override
  int get length => _childNodes.length;

  @override
  set length(int newLength) {
    _childNodes.length = newLength;
  }

  @override
  CHILD_NODE operator [](int index) => _childNodes[index];

  @override
  void operator []=(int index, CHILD_NODE value) {
    _childNodes[index] = value;
  }

  @override
  List<CHILD_NODE> toList({bool growable = true}) => _childNodes.toList(growable: growable);
}
