import 'parameter.dart';
import 'dart:collection';
import '../list_node.dart';
import 'package:openapi_analyzer/v3_0_0/objects/parameter.dart';

class ParametersListNode extends ListNode<ParameterNode, Parameter> implements ParametersList {
  ParametersListNode(super.json, super.document, super.jsonPointer);
}
