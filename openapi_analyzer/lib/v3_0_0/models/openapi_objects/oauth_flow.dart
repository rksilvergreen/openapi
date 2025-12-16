import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class OAuthFlowNode extends OpenApiNode {
  OAuthFlowNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final OAuthFlow content;

  void create() {
    _validateStructure();
    _createContent();
  }

  void _validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate required: scopes
    final scopes = ValidationUtils.requireField(json, 'scopes', jsonPointer);
    final scopesMap = ValidationUtils.requireMap(scopes, ValidationUtils.buildPath(jsonPointer, 'scopes'));
    
    // Validate scopes values are strings
    for (final entry in scopesMap.entries) {
      ValidationUtils.requireString(
        entry.value,
        ValidationUtils.buildPath(ValidationUtils.buildPath(jsonPointer, 'scopes'), entry.key.toString()),
      );
    }

    // Validate optional fields
    if (json.containsKey('authorizationUrl')) {
      ValidationUtils.requireString(json['authorizationUrl'], ValidationUtils.buildPath(jsonPointer, 'authorizationUrl'));
    }

    if (json.containsKey('tokenUrl')) {
      ValidationUtils.requireString(json['tokenUrl'], ValidationUtils.buildPath(jsonPointer, 'tokenUrl'));
    }

    if (json.containsKey('refreshUrl')) {
      ValidationUtils.requireString(json['refreshUrl'], ValidationUtils.buildPath(jsonPointer, 'refreshUrl'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'authorizationUrl', 'tokenUrl', 'refreshUrl', 'scopes'},
      jsonPointer,
      'OAuth Flow Object',
    );

    _structureValidated = true;
  }

  void _createContent() {
    content = OAuthFlow._(
      $node: this,
      authorizationUrl: json['authorizationUrl'],
      tokenUrl: json['tokenUrl'],
      refreshUrl: json['refreshUrl'],
      scopes: json['scopes'] != null ? Map<String, String>.from(json['scopes']) : {},
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Configuration details for a supported OAuth Flow.
class OAuthFlow {
  final OAuthFlowNode $node;
  final String? authorizationUrl;
  final String? tokenUrl;
  final String? refreshUrl;
  final Map<String, String> scopes;
  final Map<String, dynamic>? extensions;

  OAuthFlow._({
    required this.$node,
    this.authorizationUrl,
    this.tokenUrl,
    this.refreshUrl,
    required this.scopes,
    this.extensions,
  });
}
