import '../openapi_graph.dart';
import 'enums.dart';
import 'schema/schema_node.dart';
import 'schema/effective_schema/effective_schema.dart';
import 'example.dart';
import 'media_type.dart';

class ParameterNode extends OpenApiNode {
  ParameterNode(super.$id, super.json) {
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

  late final Parameter content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Parameter._(
      $id: $id,
      name: json['name'],
      in_: ParameterLocation.values.firstWhere((e) => e.value == json['in']),
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
      content: json['content'],
      extensions: extractExtensions(json),
    );
  }
}

/// Describes a single operation parameter.
class Parameter {
  final ParameterNode _$node;
  final String name;
  final ParameterLocation in_;
  final String? description;
  final bool required_;
  final bool deprecated;
  final bool allowEmptyValue;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  EffectiveSchema? get schema => _$node.schemaNode?.effective;
  final dynamic example;
  Map<String, Example>? get examples => _$node.examplesNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, MediaType>? content;
  final Map<String, dynamic>? extensions;

  Parameter._({
    required NodeId $id,
    required this.name,
    required this.in_,
    this.description,
    this.required_ = false,
    this.deprecated = false,
    this.allowEmptyValue = false,
    this.style,
    this.explode,
    this.allowReserved = false,
    this.example,
    this.content,
    this.extensions,
  }) : _$node = OpenApiGraph.i.getOpenApiNode<ParameterNode>($id);
}
