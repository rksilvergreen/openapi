part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class OAuthFlow {
  final String? authorizationUrl;
  final String? tokenUrl;
  final String? refreshUrl;
  @JsonKey(required: true, disallowNullValue: true)
  final Map<String, String> scopes;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  OAuthFlow({
    this.authorizationUrl,
    this.tokenUrl,
    this.refreshUrl,
    required this.scopes,
    this.extensions = const {},
  });

  factory OAuthFlow.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final oauthFlow = _$OAuthFlowFromJson(_jsonWithoutExtensions(json));
    return oauthFlow.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$OAuthFlowToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class OAuthFlowNode extends TreeNode {
  String? authorizationUrl;
  String? tokenUrl;
  String? refreshUrl;
  Map<String, String> scopes;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  OAuthFlowNode({
    this.authorizationUrl,
    this.tokenUrl,
    this.refreshUrl,
    required this.scopes,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$OAuthFlowNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable()
class OAuthFlows {
  final OAuthFlow? implicit;
  final OAuthFlow? password;
  final OAuthFlow? clientCredentials;
  final OAuthFlow? authorizationCode;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  OAuthFlows({
    this.implicit,
    this.password,
    this.clientCredentials,
    this.authorizationCode,
    this.extensions = const {},
  });

  factory OAuthFlows.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final oauthFlows = _$OAuthFlowsFromJson(_jsonWithoutExtensions(json));
    return oauthFlows.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$OAuthFlowsToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class OAuthFlowsNode extends TreeNode {
  OAuthFlowNode? get implicit => $children?['implicit'] as OAuthFlowNode?;
  OAuthFlowNode? get password => $children?['password'] as OAuthFlowNode?;
  OAuthFlowNode? get clientCredentials => $children?['clientCredentials'] as OAuthFlowNode?;
  OAuthFlowNode? get authorizationCode => $children?['authorizationCode'] as OAuthFlowNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  OAuthFlowsNode({
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$OAuthFlowsNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}


