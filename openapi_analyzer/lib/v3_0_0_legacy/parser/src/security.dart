import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'enums.dart';
import 'json_helpers.dart';

part '_gen/security.g.dart';

/// Lists the required security schemes to execute an operation.
@CopyWith()
@JsonSerializable(createFactory: false)
class SecurityRequirement implements OpenapiObject {
  final Map<String, List<String>> requirements;

  SecurityRequirement({
    required this.requirements,
  });

  factory SecurityRequirement.fromJson(Map<String, dynamic> json) {
    final requirements = <String, List<String>>{};
    for (final entry in json.entries) {
      final key = entry.key.toString();
      if (entry.value is List) {
        requirements[key] = (entry.value as List).map((e) => e.toString()).toList();
      } else {
        requirements[key] = [];
      }
    }
    return SecurityRequirement(requirements: requirements);
  }

  @override
  Map<String, dynamic> toJson() => _$SecurityRequirementToJson(this);
}

/// Configuration details for a supported OAuth Flow.
@CopyWith()
@JsonSerializable()
class OAuthFlow implements OpenapiObject {
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
    final extensions = extractExtensions(json);
    final oauthFlow = _$OAuthFlowFromJson(jsonWithoutExtensions(json));
    return oauthFlow.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$OAuthFlowToJson(this);
}

/// Allows configuration of the supported OAuth Flows.
@CopyWith()
@JsonSerializable()
class OAuthFlows implements OpenapiObject {
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
    final extensions = extractExtensions(json);
    final oauthFlows = _$OAuthFlowsFromJson(jsonWithoutExtensions(json));
    return oauthFlows.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$OAuthFlowsToJson(this);
}

/// Defines a security scheme that can be used by the operations.
@CopyWith()
@JsonSerializable()
class SecurityScheme implements OpenapiObject {
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
    final extensions = extractExtensions(json);
    final securityScheme = _$SecuritySchemeFromJson(jsonWithoutExtensions(json));
    return securityScheme.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$SecuritySchemeToJson(this);
}
