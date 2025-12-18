import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'contact.dart';
import 'license.dart';
import '../node_creation_helpers.dart';

abstract class Info {
  String get title;
  String? get description;
  String? get termsOfService;
  Contact? get contact;
  License? get license;
  String get version;
  Map<String, dynamic>? get extensions;
}

class InfoNode extends OpenApiNode with InternalNode implements Info {
  InfoNode(Map<String, dynamic> json, String document, String jsonPointer) : super(NodeId(document, jsonPointer), json);

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

    // Validate required: title (non-empty string)
    final title = ValidationUtils.requireField(json, 'title', jsonPointer);
    ValidationUtils.requireNonEmptyString(title, ValidationUtils.buildPointer([jsonPointer, 'title']));

    // Validate required: version (non-empty string)
    final version = ValidationUtils.requireField(json, 'version', jsonPointer);
    ValidationUtils.requireNonEmptyString(version, ValidationUtils.buildPointer([jsonPointer, 'version']));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }

    // Validate optional: termsOfService (string)
    if (json.containsKey('termsOfService')) {
      ValidationUtils.requireString(
        json['termsOfService'],
        ValidationUtils.buildPointer([jsonPointer, 'termsOfService']),
      );
    }

    // Validate optional: contact (object)
    if (json.containsKey('contact')) {
      ValidationUtils.requireMap(json['contact'], ValidationUtils.buildPointer([jsonPointer, 'contact']));
    }

    // Validate optional: license (object)
    if (json.containsKey('license')) {
      ValidationUtils.requireMap(json['license'], ValidationUtils.buildPointer([jsonPointer, 'license']));
    }

    // Validate no unknown fields
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
