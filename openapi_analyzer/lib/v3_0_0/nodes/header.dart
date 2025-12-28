import '../doc_nodes/enums_doc_node.dart';
import 'example.dart';
import 'media_type.dart';
import 'schema/schema.dart';
import '../node.dart';
import '../map_node.dart';

/// Header Object follows the structure of the Parameter Object.
class Header extends Node {
  String? description;
  bool required_;
  bool deprecated;
  bool allowEmptyValue;
  ParameterStyle? style;
  bool? explode;
  bool allowReserved;
  SchemasMap? schema;
  dynamic example;
  ExamplesMap? examples;
  MediaTypesMap? content;
  Map<String, dynamic>? extensions;
  String $name;

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

  factory Header.internalRef({required String jsonPointer, Header? node}) {

  }

  factory Header.externalRef({required String document, required String jsonPointer, Header? node}) {
    // create edge from node Id to node Id. When graph is built, these (and all) connections will be validated.
  }

  // when we set a node property to null, or to some other node, the original edge is deleted.
  // what happens if it was a parent edge?
  // A node can have multiple parents. If a node has an incoming inline edge, that is the parent. If a node has no
  // incoming inline edge, all its reference edges are parents.
}

class HeadersMap extends MapNode<Header> {
  final Map<String, dynamic>? extensions;
  HeadersMap({this.extensions});
}
