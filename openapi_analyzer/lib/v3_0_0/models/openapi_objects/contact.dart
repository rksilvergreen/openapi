import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

abstract class Contact {
  String? get name;
  String? get url;
  String? get email;
  Map<String, dynamic>? get extensions;
}

class ContactNode extends OpenApiNode with LeafNode implements Contact {
  ContactNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String? name;
  late final String? url;
  late final String? email;
  late final Map<String, dynamic>? extensions;

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
    name = json['name'];
    url = json['url'];
    email = json['email'];
    extensions = extractExtensions(json);
  }
}
