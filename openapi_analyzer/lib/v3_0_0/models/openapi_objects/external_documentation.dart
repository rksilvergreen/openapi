import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class ExternalDocumentationNode extends OpenApiNode {
  ExternalDocumentationNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final ExternalDocumentation content;

  void create() {
    _validateStructure();
    _createContent();
  }

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate required: url (non-empty string)
    final url = ValidationUtils.requireField(json, 'url', path);
    ValidationUtils.requireNonEmptyString(url, ValidationUtils.buildPath(path, 'url'));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'description', 'url'},
      path,
      'External Documentation Object',
    );
  }
  void _createContent() {
    content = ExternalDocumentation._(
      $node: this,
      description: json['description'],
      url: json['url'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Additional external documentation.
class ExternalDocumentation {
  final ExternalDocumentationNode $node;
  final String? description;
  final String url;
  final Map<String, dynamic>? extensions;

  ExternalDocumentation._({required this.$node, this.description, required this.url, this.extensions});
}
