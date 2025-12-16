import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
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
    infoNode = createNode<InfoNode>(jsonKey: 'info', required: true, factory: (id, json) => InfoNode(id, json))!;
  }

  void _createServersNodes() {
    serversNode = createListNode<ServerNode>(jsonKey: 'servers', factory: (id, json) => ServerNode(id, json));
  }

  void _createPathsNode() {
    pathsNode = createNode<PathsNode>(jsonKey: 'paths', required: true, factory: (id, json) => PathsNode(id, json))!;
  }

  void _createComponentsNode() {
    componentsNode = createNode<ComponentsNode>(jsonKey: 'components', factory: (id, json) => ComponentsNode(id, json));
  }

  void _createSecurityNodes() {
    securityNode = createListNode<SecurityRequirementNode>(
      jsonKey: 'security',
      factory: (id, json) => SecurityRequirementNode(id, json),
    );
  }

  void _createTagsNodes() {
    tagsNode = createListNode<TagNode>(jsonKey: 'tags', factory: (id, json) => TagNode(id, json));
  }

  void _createExternalDocsNode() {
    externalDocsNode = createNode<ExternalDocumentationNode>(
      jsonKey: 'externalDocs',
      factory: (id, json) => ExternalDocumentationNode(id, json),
    );
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
