import '../doc_nodes/enums_doc_node.dart';
import 'schema/schema.dart';
import 'example.dart';
import 'media_type.dart';
import '../node.dart';
import '../list_node.dart';
import '../map_node.dart';

class Parameter extends Node {
  final String name;
  final ParameterLocation in_;
  final String? description;
  final bool required_;
  final bool deprecated;
  final bool allowEmptyValue;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final Schema? schema;
  final dynamic example;
  final ExamplesMap? examples;
  final MediaTypesMap? content;
  final Map<String, dynamic>? extensions;
  final String $name;

  Parameter({required this.name, required this.in_, this.description, required this.required_, required this.deprecated, required this.allowEmptyValue, this.style, this.explode, required this.allowReserved, this.schema, this.example, this.examples, this.content, this.extensions, required this.$name});
}

class ParametersList extends ListNode<Parameter> {}

class ParametersMap extends MapNode<Parameter> {
  final Map<String, dynamic>? extensions;
  ParametersMap({this.extensions});
}
