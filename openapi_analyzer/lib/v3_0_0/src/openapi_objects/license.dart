import '../validation/validation_utils.dart';
import '../node.dart';

abstract class License {
  String get name;
  String? get url;
  Map<String, dynamic>? get extensions;
}

class LicenseNode extends Node with LeafNode implements License {
  LicenseNode(super.json, super.document, super.jsonPointer);

  late final String name;
  late final String? url;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateName(jsonPointer);
    _validateUrl(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateName(String jsonPointer) {
    final name = ValidationUtils.requireField(json, 'name', jsonPointer);
    ValidationUtils.requireNonEmptyString(name, ValidationUtils.buildPointer([jsonPointer, 'name']));
  }

  void _validateUrl(String jsonPointer) {
    if (json.containsKey('url')) {
      ValidationUtils.requireString(json['url'], ValidationUtils.buildPointer([jsonPointer, 'url']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(json, {'name', 'url'}, jsonPointer, 'License Object');
  }

  @override
  void createContent() {
    name = json['name'];
    url = json['url'];
    extensions = extractExtensions(json);
  }
}
