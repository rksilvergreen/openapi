import '../openapi_graph.dart';
import 'enums.dart';
import 'header.dart';

class EncodingNode extends OpenApiNode {
  EncodingNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, HeaderNode>? headersNodes;

  late final Encoding content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Encoding._(
      $id: $id,
      contentType: json['contentType'],
      style: json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null,
      explode: json['explode'],
      allowReserved: json['allowReserved'] ?? false,
      extensions: extractExtensions(json),
    );
  }
}

/// A single encoding definition applied to a single schema property.
class Encoding {
  final EncodingNode _$node;
  final String? contentType;
  Map<String, Header>? get headers => _$node.headersNodes?.map((k, v) => MapEntry(k, v.content));
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final Map<String, dynamic>? extensions;

  Encoding._({
    required NodeId $id,
    this.contentType,
    this.style,
    this.explode,
    this.allowReserved = false,
    this.extensions,
  }) : _$node = OpenApiGraph.i.getOpenApiNode<EncodingNode>($id);
}
