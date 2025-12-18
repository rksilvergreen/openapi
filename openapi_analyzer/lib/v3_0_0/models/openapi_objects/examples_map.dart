import 'example.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class ExamplesMap implements MapBase<String, Example> {
  Map<String, dynamic>? get extensions;
}

class ExamplesMapNode extends MapNode<ExampleNode, Example> implements ExamplesMap {
  ExamplesMapNode(super.json, super.document, super.jsonPointer);
}
