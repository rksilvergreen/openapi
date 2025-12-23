import 'parameter.dart';
import '../map_node.dart';
import 'dart:collection';
import 'package:openapi_analyzer/v3_0_0/objects/parameter.dart';

class ParametersMapNode extends MapNode<ParameterNode, Parameter> implements ParametersMap {
  ParametersMapNode(super.json, super.document, super.jsonPointer);
}
