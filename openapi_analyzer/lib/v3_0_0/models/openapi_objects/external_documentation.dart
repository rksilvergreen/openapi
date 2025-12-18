import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

abstract class ExternalDocumentation {
  String? get description;
  String get url;
  Map<String, dynamic>? get extensions;
}

class ExternalDocumentationNode extends OpenApiNode with LeafNode implements ExternalDocumentation {
  ExternalDocumentationNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String? description;
  late final String url;
  late final Map<String, dynamic>? extensions;

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
    description = json['description'];
    url = json['url'];
    extensions = extractExtensions(json);
  }
}
