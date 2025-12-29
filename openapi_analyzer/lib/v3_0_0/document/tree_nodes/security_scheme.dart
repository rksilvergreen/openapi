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
  });

  factory SecurityScheme.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final securityScheme = _$SecuritySchemeFromJson(_jsonWithoutExtensions(json));
    return securityScheme.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable(createFactory: false, createToJson: false)
class SecuritySchemesMap extends MapTreeNode<SecurityScheme> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  SecuritySchemesMap(Map<String, SecurityScheme> securitySchemes, {this.extensions}) : super(securitySchemes);

  factory SecuritySchemesMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return SecuritySchemesMap(
      map.map((key, value) => MapEntry(key, SecurityScheme.fromJson(value))),
      extensions: extensions,
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$SecuritySchemeToJson(entry.value);
    }
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}
