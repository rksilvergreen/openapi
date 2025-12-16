import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'info.dart';
import 'server.dart';
import 'paths.dart';
import 'components.dart';
import 'security_requirement.dart';
import 'tag.dart';
import 'external_documentation.dart';

class OpenApiDocumentNode extends OpenApiNode {
  OpenApiDocumentNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final InfoNode infoNode;
  late final List<ServerNode>? serversNode;
  late final PathsNode pathsNode;
  late final ComponentsNode? componentsNode;
  late final List<SecurityRequirementNode>? securityNode;
  late final List<TagNode>? tagsNode;
  late final ExternalDocumentationNode? externalDocsNode;

  late final OpenApiDocument content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    _structureValidated = true;
    final jsonPointer = $id.jsonPointer;

    _validateOpenapi(jsonPointer);
    _validateInfo(jsonPointer);
    _validatePaths(jsonPointer);
    _validateServers(jsonPointer);
    _validateComponents(jsonPointer);
    _validateSecurity(jsonPointer);
    _validateTags(jsonPointer);
    _validateExternalDocs(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateOpenapi(String jsonPointer) {
    final openapi = ValidationUtils.requireField(json, 'openapi', jsonPointer);
    ValidationUtils.requireString(openapi, ValidationUtils.buildPath(jsonPointer, 'openapi'));
    ValidationUtils.validatePattern(
      openapi as String,
      r'^3\.0\.\d+$',
      ValidationUtils.buildPath(jsonPointer, 'openapi'),
      description: 'OpenAPI version must match pattern 3.0.x',
    );
  }

  void _validateInfo(String jsonPointer) {
    final info = ValidationUtils.requireField(json, 'info', jsonPointer);
    ValidationUtils.requireMap(info, ValidationUtils.buildPath(jsonPointer, 'info'));
  }

  void _validatePaths(String jsonPointer) {
    final paths = ValidationUtils.requireField(json, 'paths', jsonPointer);
    ValidationUtils.requireMap(paths, ValidationUtils.buildPath(jsonPointer, 'paths'));
  }

  void _validateServers(String jsonPointer) {
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPath(jsonPointer, 'servers'));
    }
  }

  void _validateComponents(String jsonPointer) {
    if (json.containsKey('components')) {
      ValidationUtils.requireMap(json['components'], ValidationUtils.buildPath(jsonPointer, 'components'));
    }
  }

  void _validateSecurity(String jsonPointer) {
    if (json.containsKey('security')) {
      ValidationUtils.requireList(json['security'], ValidationUtils.buildPath(jsonPointer, 'security'));
    }
  }

  void _validateTags(String jsonPointer) {
    if (json.containsKey('tags')) {
      ValidationUtils.requireList(json['tags'], ValidationUtils.buildPath(jsonPointer, 'tags'));
    }
  }

  void _validateExternalDocs(String jsonPointer) {
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPath(jsonPointer, 'externalDocs'));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'openapi', 'info', 'servers', 'paths', 'components', 'security', 'tags', 'externalDocs'},
      jsonPointer,
      'OpenAPI Object',
    );
  }

  void _createChildNodes() {
    _createInfoNode();
    _createServersNodes();
    _createPathsNode();
    _createComponentsNode();
    _createSecurityNodes();
    _createTagsNodes();
    _createExternalDocsNode();
  }

  void _createInfoNode() {
    if (json.containsKey('info')) {
      final infoJson = json['info'] as Map<String, dynamic>;
      infoNode = InfoNode(NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'info')), infoJson);
      OpenApiGraph.i.addOpenApiNode(infoNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, infoNode.$id.absolutePointer, 'info'));
      infoNode.create();
    }
  }

  void _createServersNodes() {
    if (json.containsKey('servers')) {
      final serversList = json['servers'] as List;
      serversNode = [];
      for (var i = 0; i < serversList.length; i++) {
        final serverJson = serversList[i] as Map<String, dynamic>;
        final serverNodeInstance = ServerNode(
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'servers'), '[$i]'),
          ),
          serverJson,
        );
        serversNode!.add(serverNodeInstance);
        OpenApiGraph.i.addOpenApiNode(serverNodeInstance);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, serverNodeInstance.$id.absolutePointer, 'servers'));
        serverNodeInstance.create();
      }
    }
  }

  void _createPathsNode() {
    if (json.containsKey('paths')) {
      final pathsJson = json['paths'] as Map<String, dynamic>;
      pathsNode = PathsNode(NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'paths')), pathsJson);
      OpenApiGraph.i.addOpenApiNode(pathsNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, pathsNode.$id.absolutePointer, 'paths'));
      pathsNode.create();
    }
  }

  void _createComponentsNode() {
    if (json.containsKey('components')) {
      final componentsJson = json['components'] as Map<String, dynamic>;
      componentsNode = ComponentsNode(
        NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'components')),
        componentsJson,
      );
      OpenApiGraph.i.addOpenApiNode(componentsNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, componentsNode!.$id.absolutePointer, 'components'));
      componentsNode!.create();
    }
  }

  void _createSecurityNodes() {
    if (json.containsKey('security')) {
      final securityList = json['security'] as List;
      securityNode = [];
      for (var i = 0; i < securityList.length; i++) {
        final securityJson = securityList[i] as Map<String, dynamic>;
        final securityNodeInstance = SecurityRequirementNode(
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'security'), '[$i]'),
          ),
          securityJson,
        );
        securityNode!.add(securityNodeInstance);
        OpenApiGraph.i.addOpenApiNode(securityNodeInstance);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, securityNodeInstance.$id.absolutePointer, 'security'));
        securityNodeInstance.create();
      }
    }
  }

  void _createTagsNodes() {
    if (json.containsKey('tags')) {
      final tagsList = json['tags'] as List;
      tagsNode = [];
      for (var i = 0; i < tagsList.length; i++) {
        final tagJson = tagsList[i] as Map<String, dynamic>;
        final tagNodeInstance = TagNode(
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'tags'), '[$i]')),
          tagJson,
        );
        tagsNode!.add(tagNodeInstance);
        OpenApiGraph.i.addOpenApiNode(tagNodeInstance);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, tagNodeInstance.$id.absolutePointer, 'tags'));
        tagNodeInstance.create();
      }
    }
  }

  void _createExternalDocsNode() {
    if (json.containsKey('externalDocs')) {
      final externalDocsJson = json['externalDocs'] as Map<String, dynamic>;
      externalDocsNode = ExternalDocumentationNode(
        NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'externalDocs')),
        externalDocsJson,
      );
      OpenApiGraph.i.addOpenApiNode(externalDocsNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, externalDocsNode!.$id.absolutePointer, 'externalDocs'));
      externalDocsNode!.create();
    }
  }

  void _createContent() {
    content = OpenApiDocument._($node: this, openapi: json['openapi'], extensions: extractExtensions(json));
    _contentCreated = true;
  }
}

/// Root document object of the OpenAPI document.
class OpenApiDocument {
  final OpenApiDocumentNode $node;

  final String openapi;
  Info get info => $node.infoNode.content;
  List<Server>? get servers => $node.serversNode?.map((server) => server.content).toList();
  Paths get paths => $node.pathsNode.content;
  Components? get components => $node.componentsNode?.content;
  List<SecurityRequirement>? get security => $node.securityNode?.map((security) => security.content).toList();
  List<Tag>? get tags => $node.tagsNode?.map((tag) => tag.content).toList();
  ExternalDocumentation? get externalDocs => $node.externalDocsNode?.content;
  final Map<String, dynamic>? extensions;

  OpenApiDocument._({required this.$node, required this.openapi, this.extensions});
}
