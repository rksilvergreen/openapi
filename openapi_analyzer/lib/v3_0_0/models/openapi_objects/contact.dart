import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class ContactNode extends OpenApiNode with LeafNode {
  ContactNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final Contact content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // All fields optional: name, url, email
    if (json.containsKey('name')) {
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPointer([jsonPointer, 'name']));
    }

    if (json.containsKey('url')) {
      ValidationUtils.requireString(json['url'], ValidationUtils.buildPointer([jsonPointer, 'url']));
    }

    if (json.containsKey('email')) {
      ValidationUtils.requireString(json['email'], ValidationUtils.buildPointer([jsonPointer, 'email']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, {'name', 'url', 'email'}, jsonPointer, 'Contact Object');
  }

  @override
  void createContent() {
    content = Contact._(
      $node: this,
      name: json['name'],
      url: json['url'],
      email: json['email'],
      extensions: extractExtensions(json),
    );
  }
}

/// Contact information for the exposed API.
class Contact {
  final ContactNode $node;
  final String? name;
  final String? url;
  final String? email;
  final Map<String, dynamic>? extensions;

  Contact._({required this.$node, required this.name, this.url, this.email, this.extensions});
}
