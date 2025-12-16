import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'contact.dart';
import 'license.dart';

class InfoNode extends OpenApiNode {
  InfoNode(super.$id, super.json);

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final ContactNode? contactNode;
  late final LicenseNode? licenseNode;

  late final Info content;

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate required: title (non-empty string)
    final title = ValidationUtils.requireField(json, 'title', path);
    ValidationUtils.requireNonEmptyString(title, ValidationUtils.buildPath(path, 'title'));

    // Validate required: version (non-empty string)
    final version = ValidationUtils.requireField(json, 'version', path);
    ValidationUtils.requireNonEmptyString(version, ValidationUtils.buildPath(path, 'version'));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate optional: termsOfService (string)
    if (json.containsKey('termsOfService')) {
      ValidationUtils.requireString(json['termsOfService'], ValidationUtils.buildPath(path, 'termsOfService'));
    }

    // Validate optional: contact (object)
    if (json.containsKey('contact')) {
      ValidationUtils.requireMap(json['contact'], ValidationUtils.buildPath(path, 'contact'));
    }

    // Validate optional: license (object)
    if (json.containsKey('license')) {
      ValidationUtils.requireMap(json['license'], ValidationUtils.buildPath(path, 'license'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'title', 'description', 'termsOfService', 'contact', 'license', 'version'},
      path,
      'Info Object',
    );
  }

  void _createChildNodes() {
    // Create Contact node
    if (json.containsKey('contact')) {
      final contactJson = json['contact'] as Map<String, dynamic>;
      contactNode = ContactNode(
        NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'contact')),
        contactJson,
      );
      OpenApiGraph.i.addOpenApiNode(contactNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, contactNode!.$id.absolutePointer, 'contact'));
      contactNode!.create();
    }

    // Create License node
    if (json.containsKey('license')) {
      final licenseJson = json['license'] as Map<String, dynamic>;
      licenseNode = LicenseNode(
        NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'license')),
        licenseJson,
      );
      OpenApiGraph.i.addOpenApiNode(licenseNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, licenseNode!.$id.absolutePointer, 'license'));
      licenseNode!.create();
    }
  }

  void _createContent() {
    content = Info._(
      $node: this,
      title: json['title'],
      description: json['description'],
      termsOfService: json['termsOfService'],
      version: json['version'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
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
