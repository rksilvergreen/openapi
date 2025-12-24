import '../validation/validation_utils.dart';
import '../doc_node.dart';

class ExternalDocumentationDocNode extends DocNode with DocLeafNode {
  ExternalDocumentationDocNode(super.json);

  late final String? description;
  late final String url;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;

    _validateUrl(jsonPointer);
    _validateDescription(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateUrl(String jsonPointer) {
    final url = ValidationUtils.requireField(json, 'url', jsonPointer);
    ValidationUtils.requireNonEmptyString(url, ValidationUtils.buildPointer([jsonPointer, 'url']));
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(json, {'description', 'url'}, jsonPointer, 'External Documentation Object');
  }

  @override
  void createContent() {
    description = json['description'];
    url = json['url'];
    extensions = extractExtensions(json);
  }
}
