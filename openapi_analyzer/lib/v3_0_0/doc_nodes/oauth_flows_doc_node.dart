import '../validation/validation_utils.dart';
import 'oauth_flow_doc_node.dart';
import '../doc_node.dart';
import '../edge.dart';

class OAuthFlowsDocNode extends DocNode with DocInternalNode {
  OAuthFlowsDocNode(super.json);

  late final OAuthFlowDocNode? implicit;
  late final OAuthFlowDocNode? password;
  late final OAuthFlowDocNode? clientCredentials;
  late final OAuthFlowDocNode? authorizationCode;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;

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
    createNode<OAuthFlowDocNode>(jsonKey: 'implicit');
    createNode<OAuthFlowDocNode>(jsonKey: 'password');
    createNode<OAuthFlowDocNode>(jsonKey: 'clientCredentials');
    createNode<OAuthFlowDocNode>(jsonKey: 'authorizationCode');
  }

  @override
  void createContent() {
    implicit = $to.to<OAuthFlowDocNode>('implicit');
    password = $to.to<OAuthFlowDocNode>('password');
    clientCredentials = $to.to<OAuthFlowDocNode>('clientCredentials');
    authorizationCode = $to.to<OAuthFlowDocNode>('authorizationCode');
    extensions = extractExtensions(json);
  }
}
