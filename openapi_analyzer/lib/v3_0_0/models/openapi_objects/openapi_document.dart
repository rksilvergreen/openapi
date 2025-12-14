import '../openapi_graph.dart';
import 'info.dart';
import 'server.dart';
import 'paths.dart';
import 'components.dart';
import 'security_requirement.dart';
import 'tag.dart';
import 'external_documentation.dart';

class OpenApiDocumentNode extends OpenApiNode {
  OpenApiDocumentNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final InfoNode infoNode;
  late final List<ServerNode>? serversNode;
  late final PathsNode pathsNode;
  late final ComponentsNode componentsNode;
  late final List<SecurityRequirementNode>? securityNode;
  late final List<TagNode>? tagsNode;
  late final ExternalDocumentationNode? externalDocsNode;

  late final OpenApiDocument content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = OpenApiDocument._($node: this, openapi: json['openapi'], extensions: extractExtensions(json));
  }
}

/// Root document object of the OpenAPI document.
class OpenApiDocument {
  final OpenApiDocumentNode $node;

  final String openapi;
  Info get info => $node.infoNode.content;
  List<Server>? get servers => $node.serversNode?.map((server) => server.content).toList();
  Paths get paths => $node.pathsNode.content;
  Components? get components => $node.componentsNode.content;
  List<SecurityRequirement>? get security => $node.securityNode?.map((security) => security.content).toList();
  List<Tag>? get tags => $node.tagsNode?.map((tag) => tag.content).toList();
  ExternalDocumentation? get externalDocs => $node.externalDocsNode?.content;
  final Map<String, dynamic>? extensions;

  OpenApiDocument._({required this.$node, required this.openapi, this.extensions});
}
