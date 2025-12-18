import 'dart:collection';

import 'openapi_graph.dart';
import '../validation/validation_utils.dart';
import 'node_creation_helpers.dart';

abstract class ListNode<CHILD_NODE extends OpenApiNode, LIST> extends OpenApiNode
    with InternalNode, ListMixin<LIST>
    implements List<LIST> {
  ListNode(super.json, super.document, super.jsonPointer);

  late final List<LIST> childNodes;

  @override
  int get length => childNodes.length;

  @override
  set length(int newLength) {
    childNodes.length = newLength;
  }

  @override
  LIST operator [](int index) => childNodes[index];

  @override
  void operator []=(int index, LIST value) {
    childNodes[index] = value;
  }

  @override
  List<LIST> toList({bool growable = true}) => childNodes.toList(growable: growable);

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
    childNodes = $to.where((edge) => edge.to is LIST).map((edge) => (edge as OpenApiEdge).to as LIST).toList();
  }
}
