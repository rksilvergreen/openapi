import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class LicenseNode extends OpenApiNode with LeafNode {
  LicenseNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final License content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate required: name (non-empty string)
    final name = ValidationUtils.requireField(json, 'name', jsonPointer);
    ValidationUtils.requireNonEmptyString(name, ValidationUtils.buildPointer([jsonPointer, 'name']));

    // Validate optional: url (string)
    if (json.containsKey('url')) {
      ValidationUtils.requireString(json['url'], ValidationUtils.buildPointer([jsonPointer, 'url']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, {'name', 'url'}, jsonPointer, 'License Object');
  }

  @override
  void createContent() {
    content = License._($node: this, name: json['name'], url: json['url'], extensions: extractExtensions(json));
  }
}

/// License information for the exposed API.
class License {
  final LicenseNode $node;

  final String name;
  final String? url;
  final Map<String, dynamic>? extensions;

  License._({required this.$node, required this.name, this.url, this.extensions});
}
