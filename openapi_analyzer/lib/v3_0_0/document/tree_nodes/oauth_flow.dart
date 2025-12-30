part of '../document.dart';

@CopyWith()
@JsonSerializable()
class OAuthFlow extends TreeNode {
  final String? authorizationUrl;
  final String? tokenUrl;
  final String? refreshUrl;
  final Map<String, String> scopes;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  OAuthFlow({
    this.authorizationUrl,
    this.tokenUrl,
    this.refreshUrl,
    required this.scopes,
    this.extensions,
  });

  factory OAuthFlow.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final oauthFlow = _$OAuthFlowFromJson(_jsonWithoutExtensions(json));
    return oauthFlow.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$OAuthFlowToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

@CopyWith()
@JsonSerializable()
class OAuthFlows extends TreeNode {
  final OAuthFlow? implicit;
  final OAuthFlow? password;
  final OAuthFlow? clientCredentials;
  final OAuthFlow? authorizationCode;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  OAuthFlows({
    this.implicit,
    this.password,
    this.clientCredentials,
    this.authorizationCode,
    this.extensions,
  });

  factory OAuthFlows.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final oauthFlows = _$OAuthFlowsFromJson(_jsonWithoutExtensions(json));
    return oauthFlows.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$OAuthFlowsToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

