part of '../document.dart';

enum SecuritySchemeType {
  apiKey('apiKey'),
  http('http'),
  oauth2('oauth2'),
  openIdConnect('openIdConnect');

  const SecuritySchemeType(this.value);
  final String value;
}

enum SecuritySchemeIn {
  query('query'),
  header('header'),
  cookie('cookie');

  const SecuritySchemeIn(this.value);
  final String value;
}

@CopyWith(skipFields: true)
@JsonSerializable()
class SecurityScheme {
  @JsonKey(required: true, disallowNullValue: true)
  final SecuritySchemeType type;
  final String? description;
  final String? name;
  @JsonKey(name: 'in')
  final SecuritySchemeIn? in_;
  final String? scheme;
  final String? bearerFormat;
  final OAuthFlows? flows;
  final String? openIdConnectUrl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  SecurityScheme({
    required this.type,
    this.description,
    this.name,
    this.in_,
    this.scheme,
    this.bearerFormat,
    this.flows,
    this.openIdConnectUrl,
    this.extensions = const {},
  });

  factory SecurityScheme.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final securityScheme = _$SecuritySchemeFromJson(_jsonWithoutExtensions(json));
    return securityScheme.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$SecuritySchemeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class SecuritySchemeNode extends TreeNode {
  SecuritySchemeType type;
  String? description;
  String? name;
  @JsonKey(name: 'in')
  SecuritySchemeIn? in_;
  String? scheme;
  String? bearerFormat;
  OAuthFlowsNode? get flows => $children?['flows'] as OAuthFlowsNode?;
  String? openIdConnectUrl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  SecuritySchemeNode({
    required this.type,
    this.description,
    this.name,
    this.in_,
    this.scheme,
    this.bearerFormat,
    this.openIdConnectUrl,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$SecuritySchemeNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class SecuritySchemesMapNode extends MapTreeNode<SecuritySchemeNode> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$SecuritySchemeNodeToJson(entry.value);
    }
    return json;
  }
}
