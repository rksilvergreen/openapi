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
    final path = $id.jsonPointer;

    // Validate required: openapi (string, pattern ^3\.0\.\d+$)
    final openapi = ValidationUtils.requireField(json, 'openapi', path);
    ValidationUtils.requireString(openapi, ValidationUtils.buildPath(path, 'openapi'));
    ValidationUtils.validatePattern(
      openapi as String,
      r'^3\.0\.\d+$',
      ValidationUtils.buildPath(path, 'openapi'),
      description: 'OpenAPI version must match pattern 3.0.x',
    );

    // Validate required: info (object)
    final info = ValidationUtils.requireField(json, 'info', path);
    ValidationUtils.requireMap(info, ValidationUtils.buildPath(path, 'info'));

    // Validate required: paths (object)
    final paths = ValidationUtils.requireField(json, 'paths', path);
    ValidationUtils.requireMap(paths, ValidationUtils.buildPath(path, 'paths'));

    // Validate optional: servers (array)
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPath(path, 'servers'));
    }

    // Validate optional: components (object)
    if (json.containsKey('components')) {
      ValidationUtils.requireMap(json['components'], ValidationUtils.buildPath(path, 'components'));
    }

    // Validate optional: security (array)
    if (json.containsKey('security')) {
      ValidationUtils.requireList(json['security'], ValidationUtils.buildPath(path, 'security'));
    }

    // Validate optional: tags (array)
    if (json.containsKey('tags')) {
      ValidationUtils.requireList(json['tags'], ValidationUtils.buildPath(path, 'tags'));
    }

    // Validate optional: externalDocs (object)
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPath(path, 'externalDocs'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'openapi', 'info', 'servers', 'paths', 'components', 'security', 'tags', 'externalDocs'},
      path,
      'OpenAPI Object',
    );
  }

  void _createChildNodes() {
    // Create Info node
    if (json.containsKey('info')) {
      final infoJson = json['info'] as Map<String, dynamic>;
      infoNode = InfoNode(NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'info')), infoJson);
      OpenApiGraph.i.addOpenApiNode(infoNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, infoNode.$id.absolutePointer, 'info'));
      infoNode.create();
    }

    // Create Servers nodes
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

    // Create Paths node
    if (json.containsKey('paths')) {
      final pathsJson = json['paths'] as Map<String, dynamic>;
      pathsNode = PathsNode(NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'paths')), pathsJson);
      OpenApiGraph.i.addOpenApiNode(pathsNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, pathsNode.$id.absolutePointer, 'paths'));
      pathsNode.create();
    }

    // Create Components node
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

    // Create Security nodes
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

    // Create Tags nodes
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

    // Create ExternalDocs node
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
