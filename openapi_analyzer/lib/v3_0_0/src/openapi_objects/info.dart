import '../validation/validation_utils.dart';
import 'contact.dart';
import 'license.dart';
import '../node.dart';
import '../edge.dart';
import 'package:openapi_analyzer/v3_0_0/objects/info.dart';

class InfoNode extends Node with InternalNode implements Info {
  InfoNode(super.json, super.document, super.jsonPointer);

  late final String title;
  late final String? description;
  late final String? termsOfService;
  late final ContactNode? contact;
  late final LicenseNode? license;
  late final String version;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateTitle(jsonPointer);
    _validateVersion(jsonPointer);
    _validateDescription(jsonPointer);
    _validateTermsOfService(jsonPointer);
    _validateContact(jsonPointer);
    _validateLicense(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateTitle(String jsonPointer) {
    final title = ValidationUtils.requireField(json, 'title', jsonPointer);
    ValidationUtils.requireNonEmptyString(title, ValidationUtils.buildPointer([jsonPointer, 'title']));
  }

  void _validateVersion(String jsonPointer) {
    final version = ValidationUtils.requireField(json, 'version', jsonPointer);
    ValidationUtils.requireNonEmptyString(version, ValidationUtils.buildPointer([jsonPointer, 'version']));
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateTermsOfService(String jsonPointer) {
    if (json.containsKey('termsOfService')) {
      ValidationUtils.requireString(
        json['termsOfService'],
        ValidationUtils.buildPointer([jsonPointer, 'termsOfService']),
      );
    }
  }

  void _validateContact(String jsonPointer) {
    if (json.containsKey('contact')) {
      ValidationUtils.requireMap(json['contact'], ValidationUtils.buildPointer([jsonPointer, 'contact']));
    }
  }

  void _validateLicense(String jsonPointer) {
    if (json.containsKey('license')) {
      ValidationUtils.requireMap(json['license'], ValidationUtils.buildPointer([jsonPointer, 'license']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'title', 'description', 'termsOfService', 'contact', 'license', 'version'},
      jsonPointer,
      'Info Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<ContactNode>(jsonKey: 'contact');
    createNode<LicenseNode>(jsonKey: 'license');
  }

  @override
  void createContent() {
    title = json['title'];
    description = json['description'];
    termsOfService = json['termsOfService'];
    contact = $to.to<ContactNode>('contact');
    license = $to.to<LicenseNode>('license');
    version = json['version'];
    extensions = extractExtensions(json);
  }
}