import '../validation/validation_utils.dart';
import '../doc_node.dart';

class ContactDocNode extends DocNode with DocLeafNode {
  ContactDocNode(super.json, super.document, super.jsonPointer);

  late final String? name;
  late final String? url;
  late final String? email;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateName(jsonPointer);
    _validateUrl(jsonPointer);
    _validateEmail(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateName(String jsonPointer) {
    if (json.containsKey('name')) {
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPointer([jsonPointer, 'name']));
    }
  }

  void _validateUrl(String jsonPointer) {
    if (json.containsKey('url')) {
      ValidationUtils.requireString(json['url'], ValidationUtils.buildPointer([jsonPointer, 'url']));
    }
  }

  void _validateEmail(String jsonPointer) {
    if (json.containsKey('email')) {
      ValidationUtils.requireString(json['email'], ValidationUtils.buildPointer([jsonPointer, 'email']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(json, {'name', 'url', 'email'}, jsonPointer, 'Contact Object');
  }

  @override
  void createContent() {
    name = json['name'];
    url = json['url'];
    email = json['email'];
    extensions = extractExtensions(json);
  }
}
