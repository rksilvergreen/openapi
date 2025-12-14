import '../openapi_graph.dart';
import 'enums.dart';
import 'schema/schema_node.dart';
import 'schema/effective_schema/effective_schema.dart';
import 'example.dart';
import 'media_type.dart';

class HeaderNode extends OpenApiNode {
  HeaderNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final SchemaNode? schemaNode;
  late final Map<String, ExampleNode>? examplesNodes;
  late final Map<String, MediaTypeNode>? contentNodes;

  late final Header content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Header._(
      $node: this,
      description: json['description'],
      required_: json['required'],
      deprecated: json['deprecated'],
      allowEmptyValue: json['allowEmptyValue'],
      style: json['style'] != null
          ? ParameterStyle.values.firstWhere((e) => e.value == json['style'])
          : null,
      explode: json['explode'],
      allowReserved: json['allowReserved'],
      example: json['example'],
      extensions: extractExtensions(json),
    );
  }
}

/// Header Object follows the structure of the Parameter Object.
class Header {
  final HeaderNode $node;
  final String? description;
  final bool required_;
  final bool deprecated;
  final bool allowEmptyValue;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  EffectiveSchema? get schema => $node.schemaNode?.effective;
  final dynamic example;
  Map<String, Example>? get examples => $node.examplesNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, MediaType>? get content => $node.contentNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Header._({
    required this.$node,
    this.description,
    this.required_ = false,
    this.deprecated = false,
    this.allowEmptyValue = false,
    this.style,
    this.explode,
    this.allowReserved = false,
    this.example,
    this.extensions,
  });
}
