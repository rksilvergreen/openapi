import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class ExternalDocumentationNode extends OpenApiNode with LeafNode {
  ExternalDocumentationNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final ExternalDocumentation content;
  
  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate required: url (non-empty string)
    final url = ValidationUtils.requireField(json, 'url', jsonPointer);
    ValidationUtils.requireNonEmptyString(url, ValidationUtils.buildPointer([jsonPointer, 'url']));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, {'description', 'url'}, jsonPointer, 'External Documentation Object');
  }

  @override
  void createContent() {
    content = ExternalDocumentation._(
      $node: this,
      description: json['description'],
      url: json['url'],
      extensions: extractExtensions(json),
    );
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
