import '../validation/validation_utils.dart';
import 'oauth_flow.dart';
import '../node.dart';
import '../edge.dart';
import 'package:openapi_analyzer/v3_0_0/objects/oauth_flow.dart';

class OAuthFlowsNode extends Node with InternalNode implements OAuthFlows {
  OAuthFlowsNode(super.json, super.document, super.jsonPointer);

  late final OAuthFlowNode? implicit;
  late final OAuthFlowNode? password;
  late final OAuthFlowNode? clientCredentials;
  late final OAuthFlowNode? authorizationCode;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateImplicit(jsonPointer);
    _validatePassword(jsonPointer);
    _validateClientCredentials(jsonPointer);
    _validateAuthorizationCode(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateImplicit(String jsonPointer) {
    if (json.containsKey('implicit')) {
      ValidationUtils.requireMap(json['implicit'], ValidationUtils.buildPointer([jsonPointer, 'implicit']));
    }
  }

  void _validatePassword(String jsonPointer) {
    if (json.containsKey('password')) {
      ValidationUtils.requireMap(json['password'], ValidationUtils.buildPointer([jsonPointer, 'password']));
    }
  }

  void _validateClientCredentials(String jsonPointer) {
    if (json.containsKey('clientCredentials')) {
      ValidationUtils.requireMap(
        json['clientCredentials'],
        ValidationUtils.buildPointer([jsonPointer, 'clientCredentials']),
      );
    }
  }

  void _validateAuthorizationCode(String jsonPointer) {
    if (json.containsKey('authorizationCode')) {
      ValidationUtils.requireMap(
        json['authorizationCode'],
        ValidationUtils.buildPointer([jsonPointer, 'authorizationCode']),
      );
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
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
