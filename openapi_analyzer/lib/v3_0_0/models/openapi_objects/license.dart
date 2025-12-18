import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

abstract class License {
  String get name;
  String? get url;
  Map<String, dynamic>? get extensions;
}

class LicenseNode extends OpenApiNode with LeafNode implements License {
  LicenseNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String name;
  late final String? url;
  late final Map<String, dynamic>? extensions;

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
    name = json['name'];
    url = json['url'];
    extensions = extractExtensions(json);
  }
}
