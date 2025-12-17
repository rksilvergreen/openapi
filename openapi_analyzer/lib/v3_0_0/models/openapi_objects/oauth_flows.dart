import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'oauth_flow.dart';

class OAuthFlowsNode extends OpenApiNode with InternalNode {
  OAuthFlowsNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final OAuthFlowNode? implicitNode;
  late final OAuthFlowNode? passwordNode;
  late final OAuthFlowNode? clientCredentialsNode;
  late final OAuthFlowNode? authorizationCodeNode;

  late final OAuthFlows content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // All flow types are optional
    if (json.containsKey('implicit')) {
      ValidationUtils.requireMap(json['implicit'], ValidationUtils.buildPointer([jsonPointer, 'implicit']));
    }

    if (json.containsKey('password')) {
      ValidationUtils.requireMap(json['password'], ValidationUtils.buildPointer([jsonPointer, 'password']));
    }

    if (json.containsKey('clientCredentials')) {
      ValidationUtils.requireMap(
        json['clientCredentials'],
        ValidationUtils.buildPointer([jsonPointer, 'clientCredentials']),
      );
    }

    if (json.containsKey('authorizationCode')) {
      ValidationUtils.requireMap(
        json['authorizationCode'],
        ValidationUtils.buildPointer([jsonPointer, 'authorizationCode']),
      );
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'implicit', 'password', 'clientCredentials', 'authorizationCode'},
      jsonPointer,
      'OAuth Flows Object',
    );
  }

  @override
  void createChildNodes() {
    // Create implicit flow node
    if (json.containsKey('implicit')) {
      final implicitJson = json['implicit'] as Map<String, dynamic>;
      implicitNode = OAuthFlowNode(
        implicitJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'implicit']),
      );
      OpenApiGraph.i.addOpenApiNode(implicitNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, implicitNode!.$id.absolutePointer, 'implicit'));
      implicitNode!.create();
    }

    // Create password flow node
    if (json.containsKey('password')) {
      final passwordJson = json['password'] as Map<String, dynamic>;
      passwordNode = OAuthFlowNode(
        passwordJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'password']),
      );
      OpenApiGraph.i.addOpenApiNode(passwordNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, passwordNode!.$id.absolutePointer, 'password'));
      passwordNode!.create();
    }

    // Create clientCredentials flow node
    if (json.containsKey('clientCredentials')) {
      final clientCredentialsJson = json['clientCredentials'] as Map<String, dynamic>;
      clientCredentialsNode = OAuthFlowNode(
        clientCredentialsJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'clientCredentials']),
      );
      OpenApiGraph.i.addOpenApiNode(clientCredentialsNode!);
      OpenApiGraph.i.addOpenApiEdge(
        OpenApiEdge($id.absolutePointer, clientCredentialsNode!.$id.absolutePointer, 'clientCredentials'),
      );
      clientCredentialsNode!.create();
    }

    // Create authorizationCode flow node
    if (json.containsKey('authorizationCode')) {
      final authorizationCodeJson = json['authorizationCode'] as Map<String, dynamic>;
      authorizationCodeNode = OAuthFlowNode(
        authorizationCodeJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'authorizationCode']),
      );
      OpenApiGraph.i.addOpenApiNode(authorizationCodeNode!);
      OpenApiGraph.i.addOpenApiEdge(
        OpenApiEdge($id.absolutePointer, authorizationCodeNode!.$id.absolutePointer, 'authorizationCode'),
      );
      authorizationCodeNode!.create();
    }
  }

  @override
  void createContent() {
    content = OAuthFlows._($node: this, extensions: extractExtensions(json));
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
