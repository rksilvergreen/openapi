import 'dart:collection';
import 'validation/validation_utils.dart';
import 'doc_node.dart';

abstract class ListDocNode<CHILD_NODE extends DocNode> extends DocNode with DocInternalNode, ListMixin<CHILD_NODE> {
  ListDocNode(super.json);

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

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;
    final jsonList = json.values.toList();
    for (var i = 0; i < jsonList.length; i++) {
      ValidationUtils.requireMap(jsonList[i], ValidationUtils.buildPointer([jsonPointer, '[$i]']));
    }
  }

  @override
  void createChildNodes() {
    createListDocNode<CHILD_NODE>();
  }

  @override
  void createContent() {
    _childNodes = $to.where((edge) => edge.to is CHILD_NODE).map((edge) => edge.to as CHILD_NODE).toList();
  }
}
