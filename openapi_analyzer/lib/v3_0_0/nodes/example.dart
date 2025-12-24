import '../node.dart';
import '../map_node.dart';

class Example extends Node {
  final String? summary;
  final String? description;
  final dynamic value;
  final String? externalValue;
  final Map<String, dynamic>? extensions;

  Example({this.summary, this.description, this.value, this.externalValue, this.extensions});
}

class ExamplesMap extends MapNode<Example> {
  final Map<String, dynamic>? extensions;
  ExamplesMap({this.extensions});
}