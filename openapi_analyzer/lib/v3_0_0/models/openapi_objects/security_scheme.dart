import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'enums.dart';
import 'oauth_flows.dart';

class SecuritySchemeNode extends OpenApiNode {
  SecuritySchemeNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final OAuthFlowsNode? flowsNode;

  late final SecurityScheme content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate required: type (enum: apiKey, http, oauth2, openIdConnect)
    final type = ValidationUtils.requireField(json, 'type', path);
    ValidationUtils.requireString(type, ValidationUtils.buildPath(path, 'type'));
    ValidationUtils.validateEnum(type as String, [
      'apiKey',
      'http',
      'oauth2',
      'openIdConnect',
    ], ValidationUtils.buildPath(path, 'type'));

    // Validate required fields based on type
    if (type == 'apiKey') {
      ValidationUtils.requireField(json, 'name', path);
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPath(path, 'name'));

      final inValue = ValidationUtils.requireField(json, 'in', path);
      ValidationUtils.requireString(inValue, ValidationUtils.buildPath(path, 'in'));
      ValidationUtils.validateEnum(inValue as String, [
        'query',
        'header',
        'cookie',
      ], ValidationUtils.buildPath(path, 'in'));
    } else if (type == 'http') {
      ValidationUtils.requireField(json, 'scheme', path);
      ValidationUtils.requireString(json['scheme'], ValidationUtils.buildPath(path, 'scheme'));
    } else if (type == 'oauth2') {
      ValidationUtils.requireField(json, 'flows', path);
      ValidationUtils.requireMap(json['flows'], ValidationUtils.buildPath(path, 'flows'));
    } else if (type == 'openIdConnect') {
      ValidationUtils.requireField(json, 'openIdConnectUrl', path);
      ValidationUtils.requireString(json['openIdConnectUrl'], ValidationUtils.buildPath(path, 'openIdConnectUrl'));
    }

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'type', 'description', 'name', 'in', 'scheme', 'bearerFormat', 'flows', 'openIdConnectUrl'},
      path,
      'Security Scheme Object',
    );
  }

  void _createChildNodes() {
    // Create OAuthFlows node
    if (json.containsKey('flows')) {
      final flowsJson = json['flows'] as Map<String, dynamic>;
      flowsNode = OAuthFlowsNode(NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'flows')), flowsJson);
      OpenApiGraph.i.addOpenApiNode(flowsNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, flowsNode!.$id.absolutePointer, 'flows'));
      flowsNode!.create();
    }
  }

  void _createContent() {
    content = SecurityScheme._(
      $node: this,
      type: SecuritySchemeType.values.firstWhere((e) => e.value == json['type']),
      description: json['description'],
      name: json['name'],
      in_: json['in'] != null ? SecuritySchemeIn.values.firstWhere((e) => e.value == json['in']) : null,
      scheme: json['scheme'],
      bearerFormat: json['bearerFormat'],
      openIdConnectUrl: json['openIdConnectUrl'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Defines a security scheme that can be used by the operations.
class SecurityScheme {
  final SecuritySchemeNode $node;
  final SecuritySchemeType type;
  final String? description;
  final String? name;
  final SecuritySchemeIn? in_;
  final String? scheme;
  final String? bearerFormat;
  OAuthFlows? get flows => $node.flowsNode?.content;
  final String? openIdConnectUrl;
  final Map<String, dynamic>? extensions;

  SecurityScheme._({
    required this.$node,
    required this.type,
    this.description,
    this.name,
    this.in_,
    this.scheme,
    this.bearerFormat,
    this.openIdConnectUrl,
    this.extensions,
  });
}
