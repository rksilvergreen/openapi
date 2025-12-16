import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class LicenseNode extends OpenApiNode {
  LicenseNode(Map<String, dynamic> json, String document, String jsonPointer)
      : super(NodeId(document, jsonPointer), json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final License content;

  void create() {
    _validateStructure();
    _createContent();
  }

  void _validateStructure() {
    _structureValidated = true;
    final jsonPointer = $id.jsonPointer;

    // Validate required: name (non-empty string)
    final name = ValidationUtils.requireField(json, 'name', jsonPointer);
    ValidationUtils.requireNonEmptyString(name, ValidationUtils.buildPath(jsonPointer, 'name'));

    // Validate optional: url (string)
    if (json.containsKey('url')) {
      ValidationUtils.requireString(json['url'], ValidationUtils.buildPath(jsonPointer, 'url'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'name', 'url'},
      jsonPointer,
      'License Object',
    );
  }
  void _createContent() {
    content = License._($node: this, name: json['name'], url: json['url'], extensions: extractExtensions(json));
    _contentCreated = true;
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
