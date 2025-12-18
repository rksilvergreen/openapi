import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'info.dart';
import 'server.dart';
import 'paths_map.dart';
import 'components.dart';
import 'security_requirement.dart';
import 'tag.dart';
import 'external_documentation.dart';
import 'security_requirements_list.dart';
import 'tags_list.dart';
import 'server_list.dart';

abstract class OpenApiDocument {
  String get openapi;
  Info get info;
  ServerList? get servers;
  PathsMap get paths;
  Components? get components;
  SecurityRequirementsList? get security;
  TagsList? get tags;
  ExternalDocumentation? get externalDocs;
  Map<String, dynamic>? get extensions;
}

class OpenApiDocumentNode extends OpenApiNode with InternalNode implements OpenApiDocument {
  OpenApiDocumentNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String openapi;
  late final InfoNode info;
  late final ServerListNode? servers;
  late final PathsMapNode paths;
  late final ComponentsNode? components;
  late final SecurityRequirementsListNode? security;
  late final TagsListNode? tags;
  late final ExternalDocumentationNode? externalDocs;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
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
    ValidationUtils.requireString(openapi, ValidationUtils.buildPointer([jsonPointer, 'openapi']));
    ValidationUtils.validatePattern(
      openapi as String,
      r'^3\.0\.\d+$',
      ValidationUtils.buildPointer([jsonPointer, 'openapi']),
      description: 'OpenAPI version must match pattern 3.0.x',
    );
  }

  void _validateInfo(String jsonPointer) {
    final info = ValidationUtils.requireField(json, 'info', jsonPointer);
    ValidationUtils.requireMap(info, ValidationUtils.buildPointer([jsonPointer, 'info']));
  }

  void _validatePaths(String jsonPointer) {
    final paths = ValidationUtils.requireField(json, 'paths', jsonPointer);
    ValidationUtils.requireMap(paths, ValidationUtils.buildPointer([jsonPointer, 'paths']));
  }

  void _validateServers(String jsonPointer) {
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPointer([jsonPointer, 'servers']));
    }
  }

  void _validateComponents(String jsonPointer) {
    if (json.containsKey('components')) {
      ValidationUtils.requireMap(json['components'], ValidationUtils.buildPointer([jsonPointer, 'components']));
    }
  }

  void _validateSecurity(String jsonPointer) {
    if (json.containsKey('security')) {
      ValidationUtils.requireList(json['security'], ValidationUtils.buildPointer([jsonPointer, 'security']));
    }
  }

  void _validateTags(String jsonPointer) {
    if (json.containsKey('tags')) {
      ValidationUtils.requireList(json['tags'], ValidationUtils.buildPointer([jsonPointer, 'tags']));
    }
  }

  void _validateExternalDocs(String jsonPointer) {
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPointer([jsonPointer, 'externalDocs']));
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

  @override
  void createChildNodes() {
    createNode<InfoNode>(jsonKey: 'info');
    createListNode<ServerNode>(jsonKey: 'servers');
    createNode<PathsMapNode>(jsonKey: 'paths');
    createNode<ComponentsNode>(jsonKey: 'components');
    createListNode<SecurityRequirementNode>(jsonKey: 'security');
    createListNode<TagNode>(jsonKey: 'tags');
    createNode<ExternalDocumentationNode>(jsonKey: 'externalDocs');
  }

  @override
  void createContent() {
    openapi = json['openapi'];
    info = $to.to<InfoNode>('info')!;
    servers = $to.to<ServerListNode>('servers');
    paths = $to.to<PathsMapNode>('paths')!;
    components = $to.to<ComponentsNode>('components');
    security = $to.to<SecurityRequirementsListNode>('security');
    tags = $to.to<TagsListNode>('tags');
    externalDocs = $to.to<ExternalDocumentationNode>('externalDocs');
    extensions = extractExtensions(json);
  }
}
