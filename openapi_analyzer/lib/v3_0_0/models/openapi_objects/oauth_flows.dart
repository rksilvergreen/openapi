import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'oauth_flow.dart';

class OAuthFlowsNode extends OpenApiNode {
  OAuthFlowsNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final OAuthFlowNode? implicitNode;
  late final OAuthFlowNode? passwordNode;
  late final OAuthFlowNode? clientCredentialsNode;
  late final OAuthFlowNode? authorizationCodeNode;

  late final OAuthFlows content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    final path = $id.relativePath;

    // All flow types are optional
    if (json.containsKey('implicit')) {
      ValidationUtils.requireMap(json['implicit'], ValidationUtils.buildPath(path, 'implicit'));
    }

    if (json.containsKey('password')) {
      ValidationUtils.requireMap(json['password'], ValidationUtils.buildPath(path, 'password'));
    }

    if (json.containsKey('clientCredentials')) {
      ValidationUtils.requireMap(json['clientCredentials'], ValidationUtils.buildPath(path, 'clientCredentials'));
    }

    if (json.containsKey('authorizationCode')) {
      ValidationUtils.requireMap(json['authorizationCode'], ValidationUtils.buildPath(path, 'authorizationCode'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'implicit', 'password', 'clientCredentials', 'authorizationCode'},
      path,
      'OAuth Flows Object',
    );

    _structureValidated = true;
  }

  void _createChildNodes() {
    // Create implicit flow node
    if (json.containsKey('implicit')) {
      final implicitJson = json['implicit'] as Map<String, dynamic>;
      implicitNode = OAuthFlowNode(
        NodeId($id.document, ValidationUtils.buildPath($id.relativePath, 'implicit')),
        implicitJson,
      );
      OpenApiGraph.i.addOpenApiNode(implicitNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, implicitNode!.$id.absolutePath, 'implicit'));
      implicitNode!.create();
    }

    // Create password flow node
    if (json.containsKey('password')) {
      final passwordJson = json['password'] as Map<String, dynamic>;
      passwordNode = OAuthFlowNode(
        NodeId($id.document, ValidationUtils.buildPath($id.relativePath, 'password')),
        passwordJson,
      );
      OpenApiGraph.i.addOpenApiNode(passwordNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, passwordNode!.$id.absolutePath, 'password'));
      passwordNode!.create();
    }

    // Create clientCredentials flow node
    if (json.containsKey('clientCredentials')) {
      final clientCredentialsJson = json['clientCredentials'] as Map<String, dynamic>;
      clientCredentialsNode = OAuthFlowNode(
        NodeId($id.document, ValidationUtils.buildPath($id.relativePath, 'clientCredentials')),
        clientCredentialsJson,
      );
      OpenApiGraph.i.addOpenApiNode(clientCredentialsNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, clientCredentialsNode!.$id.absolutePath, 'clientCredentials'));
      clientCredentialsNode!.create();
    }

    // Create authorizationCode flow node
    if (json.containsKey('authorizationCode')) {
      final authorizationCodeJson = json['authorizationCode'] as Map<String, dynamic>;
      authorizationCodeNode = OAuthFlowNode(
        NodeId($id.document, ValidationUtils.buildPath($id.relativePath, 'authorizationCode')),
        authorizationCodeJson,
      );
      OpenApiGraph.i.addOpenApiNode(authorizationCodeNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, authorizationCodeNode!.$id.absolutePath, 'authorizationCode'));
      authorizationCodeNode!.create();
    }
  }

  void _createContent() {
    content = OAuthFlows._($node: this, extensions: extractExtensions(json));
    _contentCreated = true;
  }
}

/// Allows configuration of the supported OAuth Flows.
class OAuthFlows {
  final OAuthFlowsNode $node;
  OAuthFlow? get implicit => $node.implicitNode?.content;
  OAuthFlow? get password => $node.passwordNode?.content;
  OAuthFlow? get clientCredentials => $node.clientCredentialsNode?.content;
  OAuthFlow? get authorizationCode => $node.authorizationCodeNode?.content;
  final Map<String, dynamic>? extensions;

  OAuthFlows._({required this.$node, this.extensions});
}
