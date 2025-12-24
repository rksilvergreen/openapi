import '../doc_nodes/enums_doc_node.dart';
import 'example.dart';
import 'media_type.dart';
import 'schema/schema.dart';
import '../node.dart';
import '../map_node.dart';

/// Header Object follows the structure of the Parameter Object.
class Header extends Node {
  final String? description;
  final bool required_;
  final bool deprecated;
  final bool allowEmptyValue;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final SchemasMap? schema;
  final dynamic example;
  final ExamplesMap? examples;
  final MediaTypesMap? content;
  final Map<String, dynamic>? extensions;
  final String $name;

  Header({
    this.description,
    required this.required_,
    required this.deprecated,
    required this.allowEmptyValue,
    this.style,
    this.explode,
    required this.allowReserved,
    this.schema,
    this.example,
    this.examples,
    this.content,
    this.extensions,
    required this.$name,
  });
}

class HeadersMap extends MapNode<Header> {
  final Map<String, dynamic>? extensions;
  HeadersMap({this.extensions});
}
