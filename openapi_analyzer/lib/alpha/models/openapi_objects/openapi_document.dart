import '../openapi_graph.dart';
import 'info.dart';
import 'server.dart';
import 'paths.dart';
import 'components.dart';
import 'security.dart';
import 'tag.dart';
import 'external_documentation.dart';

class OpenApiDocumentNode extends OpenApiNode {
  OpenApiDocumentNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentValidated = false;

  bool get structureValidated => _structureValidated;
  bool get contentValidated => _contentValidated;

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
    content = OpenApiDocument._($id: $id, openapi: json['openapi'], extensions: extractExtensions(json));
  }
}

/// Root document object of the OpenAPI document.
class OpenApiDocument {
  final OpenApiDocumentNode _$node;

  final String openapi;
  Info get info => _$node.infoNode.content;
  List<Server>? get servers => _$node.serversNode?.map((server) => server.content).toList();
  Paths get paths => _$node.pathsNode.content;
  Components? get components => _$node.componentsNode.content;
  List<SecurityRequirement>? get security => _$node.securityNode?.map((security) => security.content).toList();
  List<Tag>? get tags => _$node.tagsNode?.map((tag) => tag.content).toList();
  ExternalDocumentation? get externalDocs => _$node.externalDocsNode?.content;
  final Map<String, dynamic>? extensions;

  OpenApiDocument._({required NodeId $id, required this.openapi, this.extensions})
    : _$node = OpenApiRegistry.i.getOpenApiNode<OpenApiDocumentNode>($id);
}
