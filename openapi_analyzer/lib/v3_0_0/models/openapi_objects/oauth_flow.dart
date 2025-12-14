import '../openapi_graph.dart';

class OAuthFlowNode extends OpenApiNode {
  OAuthFlowNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final OAuthFlow content;

  void _validateStructure() {}
  void _createContent() {
    content = OAuthFlow._(
      $node: this,
      authorizationUrl: json['authorizationUrl'],
      tokenUrl: json['tokenUrl'],
      refreshUrl: json['refreshUrl'],
      scopes: json['scopes'] != null ? Map<String, String>.from(json['scopes']) : {},
      extensions: extractExtensions(json),
    );
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
