import '../validation/validation_utils.dart';
import '../doc_node.dart';

class OAuthFlowDocNode extends DocNode with DocLeafNode {
  OAuthFlowDocNode(super.json);

  late final String? authorizationUrl;
  late final String? tokenUrl;
  late final String? refreshUrl;
  late final Map<String, String> scopes;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;

    _validateScopes(jsonPointer);
    _validateAuthorizationUrl(jsonPointer);
    _validateTokenUrl(jsonPointer);
    _validateRefreshUrl(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateScopes(String jsonPointer) {
    final scopes = ValidationUtils.requireField(json, 'scopes', jsonPointer);
    final scopesMap = ValidationUtils.requireMap(scopes, ValidationUtils.buildPointer([jsonPointer, 'scopes']));

    for (final entry in scopesMap.entries) {
      ValidationUtils.requireString(
        entry.value,
        ValidationUtils.buildPointer([jsonPointer, 'scopes', entry.key.toString()]),
      );
    }
  }

  void _validateAuthorizationUrl(String jsonPointer) {
    if (json.containsKey('authorizationUrl')) {
      ValidationUtils.requireString(
        json['authorizationUrl'],
        ValidationUtils.buildPointer([jsonPointer, 'authorizationUrl']),
      );
    }
  }

  void _validateTokenUrl(String jsonPointer) {
    if (json.containsKey('tokenUrl')) {
      ValidationUtils.requireString(json['tokenUrl'], ValidationUtils.buildPointer([jsonPointer, 'tokenUrl']));
    }
  }

  void _validateRefreshUrl(String jsonPointer) {
    if (json.containsKey('refreshUrl')) {
      ValidationUtils.requireString(json['refreshUrl'], ValidationUtils.buildPointer([jsonPointer, 'refreshUrl']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'authorizationUrl', 'tokenUrl', 'refreshUrl', 'scopes'},
      jsonPointer,
      'OAuth Flow Object',
    );
  }

  @override
  void createContent() {
    authorizationUrl = json['authorizationUrl'];
    tokenUrl = json['tokenUrl'];
    refreshUrl = json['refreshUrl'];
    scopes = json['scopes'] != null ? Map<String, String>.from(json['scopes']) : {};
    extensions = extractExtensions(json);
  }
}
