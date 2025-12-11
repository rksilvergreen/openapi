import '../openapi_graph.dart';

class ExternalDocumentationNode extends OpenApiNode {
  ExternalDocumentationNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentValidated = false;

  bool get structureValidated => _structureValidated;
  bool get contentValidated => _contentValidated;

  late final ExternalDocumentation content;

  void _validateStructure() {}
  void _createContent() {
    content = ExternalDocumentation._(
      $id: $id,
      description: json['description'],
      url: json['url'],
      extensions: extractExtensions(json),
    );
  }
}

/// Additional external documentation.
class ExternalDocumentation {
  final ExternalDocumentationNode _$node;
  final String? description;
  final String url;
  final Map<String, dynamic>? extensions;

  ExternalDocumentation._({required NodeId $id, this.description, required this.url, this.extensions})
    : _$node = OpenApiRegistry.i.getOpenApiNode<ExternalDocumentationNode>($id);
}
