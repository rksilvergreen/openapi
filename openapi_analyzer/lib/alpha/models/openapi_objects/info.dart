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
  bool _contentValidated = false;

  bool get structureValidated => _structureValidated;
  bool get contentValidated => _contentValidated;

  late final ContactNode? contactNode;
  late final LicenseNode? licenseNode;

  late final Info content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Info._(
      $id: $id,
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
  final InfoNode _$node;

  final String title;
  final String? description;
  final String? termsOfService;
  Contact? get contact => _$node.contactNode?.content;
  License? get license => _$node.licenseNode?.content;
  final String version;
  final Map<String, dynamic>? extensions;

  Info._({
    required NodeId $id,
    required this.title,
    this.description,
    this.termsOfService,
    required this.version,
    this.extensions,
  }) : _$node = OpenApiRegistry.i.getOpenApiNode<InfoNode>($id);
}