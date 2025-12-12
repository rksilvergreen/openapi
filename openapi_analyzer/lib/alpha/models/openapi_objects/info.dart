import '../openapi_graph.dart';
import 'contact.dart';
import 'license.dart';

class InfoNode extends OpenApiNode {
  InfoNode(super.$id, super.json) {
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

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
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
