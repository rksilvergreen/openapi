import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

abstract class OAuthFlow {
  String? get authorizationUrl;
  String? get tokenUrl;
  String? get refreshUrl;
  Map<String, String> get scopes;
  Map<String, dynamic>? get extensions;
}
class OAuthFlowNode extends OpenApiNode with LeafNode implements OAuthFlow {
  OAuthFlowNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String? authorizationUrl;
  late final String? tokenUrl;
  late final String? refreshUrl;
  late final Map<String, String> scopes;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate required: scopes
    final scopes = ValidationUtils.requireField(json, 'scopes', jsonPointer);
    final scopesMap = ValidationUtils.requireMap(scopes, ValidationUtils.buildPointer([jsonPointer, 'scopes']));

    // Validate scopes values are strings
    for (final entry in scopesMap.entries) {
      ValidationUtils.requireString(
        entry.value,
        ValidationUtils.buildPointer([jsonPointer, 'scopes', entry.key.toString()]),
      );
    }

    // Validate optional fields
    if (json.containsKey('authorizationUrl')) {
      ValidationUtils.requireString(
        json['authorizationUrl'],
        ValidationUtils.buildPointer([jsonPointer, 'authorizationUrl']),
      );
    }

    if (json.containsKey('tokenUrl')) {
      ValidationUtils.requireString(json['tokenUrl'], ValidationUtils.buildPointer([jsonPointer, 'tokenUrl']));
    }

    if (json.containsKey('refreshUrl')) {
      ValidationUtils.requireString(json['refreshUrl'], ValidationUtils.buildPointer([jsonPointer, 'refreshUrl']));
    }

    // Validate no unknown fields
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