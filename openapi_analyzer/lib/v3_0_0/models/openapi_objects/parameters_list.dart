import 'parameter.dart';
import 'dart:collection';
import '../list_node.dart';

abstract class ParametersList implements ListBase<Parameter> {}

class ParametersListNode extends ListNode<ParameterNode, Parameter> implements ParametersList {
  ParametersListNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(json, document, jsonPointer);
}
