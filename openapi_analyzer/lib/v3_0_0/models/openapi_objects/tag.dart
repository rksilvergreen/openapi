import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
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

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.relativePath;

    // Validate required: name (non-empty string)
    final name = ValidationUtils.requireField(json, 'name', path);
    ValidationUtils.requireNonEmptyString(name, ValidationUtils.buildPath(path, 'name'));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate optional: externalDocs (object)
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPath(path, 'externalDocs'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'name', 'description', 'externalDocs'},
      path,
      'Tag Object',
    );
  }
  void _createChildNodes() {}
  void _createContent() {
    content = Tag._(
      $node: this,
      name: json['name'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
  }
}

/// Adds metadata to a single tag that is used by the Operation Object.
class Tag {
  final TagNode $node;
  final String name;
  final String? description;
  ExternalDocumentation? get externalDocs => $node.externalDocsNode?.content;
  final Map<String, dynamic>? extensions;

  Tag._({required this.$node, required this.name, this.description, this.extensions});
}
