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

@CopyWith()
@JsonSerializable()
class SecurityScheme extends TreeNode {
  final SecuritySchemeType type;
  final String? description;
  final String? name;
  final SecuritySchemeIn? in_;
  final String? scheme;
  final String? bearerFormat;
  final OAuthFlows? flows;
  final String? openIdConnectUrl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;
  final String $name;

  SecurityScheme({
    required this.type,
    this.description,
    this.name,
    this.in_,
    this.scheme,
    this.bearerFormat,
    this.flows,
    this.openIdConnectUrl,
    this.extensions,
    required this.$name,
  });

  factory SecurityScheme.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final securityScheme = _$SecuritySchemeFromJson(_jsonWithoutExtensions(json));
    return securityScheme.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable()
class SecuritySchemesMap extends MapTreeNode<SecurityScheme> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  SecuritySchemesMap(Map<String, SecurityScheme> securitySchemes, {this.extensions}) : super(securitySchemes);

  factory SecuritySchemesMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return SecuritySchemesMap(map.map((key, value) => MapEntry(key, SecurityScheme.fromJson(value))), extensions: extensions);
  }
}

