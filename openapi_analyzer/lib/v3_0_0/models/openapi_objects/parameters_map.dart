import 'parameter.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class ParametersMap implements MapBase<String, Parameter> {
  Map<String, dynamic>? get extensions;
}

class ParametersMapNode extends MapNode<ParameterNode, Parameter> implements ParametersMap {
  ParametersMapNode(super.json, super.document, super.jsonPointer);
}
