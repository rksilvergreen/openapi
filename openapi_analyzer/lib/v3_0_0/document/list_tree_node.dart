part of 'document.dart';

abstract class ListTreeNode<CHILD_NODE extends TreeNode> extends TreeNode with ListMixin<CHILD_NODE> {
  List<CHILD_NODE> get _list => $children?.values.cast<CHILD_NODE>().toList() ?? [];

  @override
  int get length => _list.length;

  @override
  set length(int newLength) => throw UnsupportedError('Unmodifiable list');

  @override
  CHILD_NODE operator [](int index) => _list[index];

  @override
  void operator []=(int index, CHILD_NODE value) => throw UnsupportedError('Unmodifiable list');

  @override
  List<CHILD_NODE> toList({bool growable = true}) => _list.toList(growable: growable);
}