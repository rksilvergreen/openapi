import 'dart:collection';

import 'openapi_graph.dart';
import '../validation/validation_utils.dart';
import 'node_creation_helpers.dart';

abstract class ListNode<CHILD_NODE extends Node, LIST> extends Node
    with InternalNode, ListMixin<LIST>
    implements List<LIST> {
  ListNode(super.json, super.document, super.jsonPointer);

  late final List<LIST> _childNodes;

  @override
  int get length => _childNodes.length;

  @override
  set length(int newLength) {
    _childNodes.length = newLength;
  }

  @override
  LIST operator [](int index) => _childNodes[index];

  @override
  void operator []=(int index, LIST value) {
    _childNodes[index] = value;
  }

  @override
  List<LIST> toList({bool growable = true}) => _childNodes.toList(growable: growable);

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    final jsonList = json.values.toList();
    for (var i = 0; i < jsonList.length; i++) {
      ValidationUtils.requireMap(jsonList[i], ValidationUtils.buildPointer([jsonPointer, '[$i]']));
    }
  }

  @override
  void createChildNodes() {
    createListNode<CHILD_NODE>();
  }

  @override
  void createContent() {
    _childNodes = $to.where((edge) => edge.to is LIST).map((edge) => edge.to as LIST).toList();
  }
}
