import '../openapi_graph.dart';
import 'external_documentation.dart';

class TagNode extends OpenApiNode {
  TagNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final ExternalDocumentationNode? externalDocsNode;

  late final Tag content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Tag._(
      $id: $id,
      name: json['name'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
  }
}

/// Adds metadata to a single tag that is used by the Operation Object.
class Tag {
  final TagNode _$node;
  final String name;
  final String? description;
  ExternalDocumentation? get externalDocs => _$node.externalDocsNode?.content;
  final Map<String, dynamic>? extensions;

  Tag._({required NodeId $id, required this.name, this.description, this.extensions})
    : _$node = OpenApiGraph.i.getOpenApiNode<TagNode>($id);
}
