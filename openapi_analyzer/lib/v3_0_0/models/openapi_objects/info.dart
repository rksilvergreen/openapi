import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'contact.dart';
import 'license.dart';

class InfoNode extends OpenApiNode with InternalNode {
  InfoNode(Map<String, dynamic> json, String document, String jsonPointer) : super(NodeId(document, jsonPointer), json);

  late final ContactNode? contactNode;
  late final LicenseNode? licenseNode;

  late final Info content;

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
    // Create Contact node
    if (json.containsKey('contact')) {
      final contactJson = json['contact'] as Map<String, dynamic>;
      contactNode = ContactNode(contactJson, $id.document, ValidationUtils.buildPointer([$id.jsonPointer, 'contact']));
      OpenApiGraph.i.addOpenApiNode(contactNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, contactNode!.$id.absolutePointer, 'contact'));
      contactNode!.create();
    }

    // Create License node
    if (json.containsKey('license')) {
      final licenseJson = json['license'] as Map<String, dynamic>;
      licenseNode = LicenseNode(licenseJson, $id.document, ValidationUtils.buildPointer([$id.jsonPointer, 'license']));
      OpenApiGraph.i.addOpenApiNode(licenseNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, licenseNode!.$id.absolutePointer, 'license'));
      licenseNode!.create();
    }
  }

  @override
  void createContent() {
    content = Info._(
      $node: this,
      title: json['title'],
      description: json['description'],
      termsOfService: json['termsOfService'],
      version: json['version'],
      extensions: extractExtensions(json),
    );
  }
}

/// Metadata about the API.
class Info {
  final InfoNode $node;

  final String title;
  final String? description;
  final String? termsOfService;
  Contact? get contact => $node.contactNode?.content;
  License? get license => $node.licenseNode?.content;
  final String version;
  final Map<String, dynamic>? extensions;

  Info._({
    required this.$node,
    required this.title,
    this.description,
    this.termsOfService,
    required this.version,
    this.extensions,
  });
}
