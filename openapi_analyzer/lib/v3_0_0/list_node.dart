import 'dart:collection';
import 'node.dart';

abstract class ListNode<CHILD_NODE extends Node> extends Node with ListMixin<CHILD_NODE> {
  late final List<CHILD_NODE> _childNodes;

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
