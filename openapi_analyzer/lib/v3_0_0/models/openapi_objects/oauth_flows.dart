import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'oauth_flow.dart';
import '../node_creation_helpers.dart';

abstract class OAuthFlows {
  OAuthFlow? get implicit;
  OAuthFlow? get password;
  OAuthFlow? get clientCredentials;
  OAuthFlow? get authorizationCode;
  Map<String, dynamic>? get extensions;
}

class OAuthFlowsNode extends OpenApiNode with InternalNode implements OAuthFlows {
  OAuthFlowsNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final OAuthFlowNode? implicit;
  late final OAuthFlowNode? password;
  late final OAuthFlowNode? clientCredentials;
  late final OAuthFlowNode? authorizationCode;
  late final Map<String, dynamic>? extensions;

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
    createNode<OAuthFlowNode>(jsonKey: 'implicit');
    createNode<OAuthFlowNode>(jsonKey: 'password');
    createNode<OAuthFlowNode>(jsonKey: 'clientCredentials');
    createNode<OAuthFlowNode>(jsonKey: 'authorizationCode');
  }

  @override
  void createContent() {
    implicit = $to.to<OAuthFlowNode>('implicit');
    password = $to.to<OAuthFlowNode>('password');
    clientCredentials = $to.to<OAuthFlowNode>('clientCredentials');
    authorizationCode = $to.to<OAuthFlowNode>('authorizationCode');
    extensions = extractExtensions(json);
  }
}
