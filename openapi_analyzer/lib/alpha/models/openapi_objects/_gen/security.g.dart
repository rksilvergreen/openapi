// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../security.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SecurityRequirementCWProxy {
  SecurityRequirement requirements(Map<String, List<String>> requirements);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityRequirement(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityRequirement(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityRequirement call({Map<String, List<String>> requirements});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecurityRequirement.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSecurityRequirement.copyWith.fieldName(...)`
class _$SecurityRequirementCWProxyImpl implements _$SecurityRequirementCWProxy {
  const _$SecurityRequirementCWProxyImpl(this._value);

  final SecurityRequirement _value;

  @override
  SecurityRequirement requirements(Map<String, List<String>> requirements) =>
      this(requirements: requirements);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityRequirement(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityRequirement(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityRequirement call({
    Object? requirements = const $CopyWithPlaceholder(),
  }) {
    return SecurityRequirement(
      requirements: requirements == const $CopyWithPlaceholder()
          ? _value.requirements
          // ignore: cast_nullable_to_non_nullable
          : requirements as Map<String, List<String>>,
    );
  }
}

extension $SecurityRequirementCopyWith on SecurityRequirement {
  /// Returns a callable class that can be used as follows: `instanceOfSecurityRequirement.copyWith(...)` or like so:`instanceOfSecurityRequirement.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SecurityRequirementCWProxy get copyWith =>
      _$SecurityRequirementCWProxyImpl(this);
}

abstract class _$OAuthFlowCWProxy {
  OAuthFlow authorizationUrl(String? authorizationUrl);

  OAuthFlow tokenUrl(String? tokenUrl);

  OAuthFlow refreshUrl(String? refreshUrl);

  OAuthFlow scopes(Map<String, String> scopes);

  OAuthFlow extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OAuthFlow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlow(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlow call({
    String? authorizationUrl,
    String? tokenUrl,
    String? refreshUrl,
    Map<String, String> scopes,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOAuthFlow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOAuthFlow.copyWith.fieldName(...)`
class _$OAuthFlowCWProxyImpl implements _$OAuthFlowCWProxy {
  const _$OAuthFlowCWProxyImpl(this._value);

  final OAuthFlow _value;

  @override
  OAuthFlow authorizationUrl(String? authorizationUrl) =>
      this(authorizationUrl: authorizationUrl);

  @override
  OAuthFlow tokenUrl(String? tokenUrl) => this(tokenUrl: tokenUrl);

  @override
  OAuthFlow refreshUrl(String? refreshUrl) => this(refreshUrl: refreshUrl);

  @override
  OAuthFlow scopes(Map<String, String> scopes) => this(scopes: scopes);

  @override
  OAuthFlow extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OAuthFlow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlow(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlow call({
    Object? authorizationUrl = const $CopyWithPlaceholder(),
    Object? tokenUrl = const $CopyWithPlaceholder(),
    Object? refreshUrl = const $CopyWithPlaceholder(),
    Object? scopes = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return OAuthFlow(
      authorizationUrl: authorizationUrl == const $CopyWithPlaceholder()
          ? _value.authorizationUrl
          // ignore: cast_nullable_to_non_nullable
          : authorizationUrl as String?,
      tokenUrl: tokenUrl == const $CopyWithPlaceholder()
          ? _value.tokenUrl
          // ignore: cast_nullable_to_non_nullable
          : tokenUrl as String?,
      refreshUrl: refreshUrl == const $CopyWithPlaceholder()
          ? _value.refreshUrl
          // ignore: cast_nullable_to_non_nullable
          : refreshUrl as String?,
      scopes: scopes == const $CopyWithPlaceholder()
          ? _value.scopes
          // ignore: cast_nullable_to_non_nullable
          : scopes as Map<String, String>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $OAuthFlowCopyWith on OAuthFlow {
  /// Returns a callable class that can be used as follows: `instanceOfOAuthFlow.copyWith(...)` or like so:`instanceOfOAuthFlow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OAuthFlowCWProxy get copyWith => _$OAuthFlowCWProxyImpl(this);
}

abstract class _$OAuthFlowsCWProxy {
  OAuthFlows implicit(OAuthFlow? implicit);

  OAuthFlows password(OAuthFlow? password);

  OAuthFlows clientCredentials(OAuthFlow? clientCredentials);

  OAuthFlows authorizationCode(OAuthFlow? authorizationCode);

  OAuthFlows extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OAuthFlows(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlows(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlows call({
    OAuthFlow? implicit,
    OAuthFlow? password,
    OAuthFlow? clientCredentials,
    OAuthFlow? authorizationCode,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOAuthFlows.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOAuthFlows.copyWith.fieldName(...)`
class _$OAuthFlowsCWProxyImpl implements _$OAuthFlowsCWProxy {
  const _$OAuthFlowsCWProxyImpl(this._value);

  final OAuthFlows _value;

  @override
  OAuthFlows implicit(OAuthFlow? implicit) => this(implicit: implicit);

  @override
  OAuthFlows password(OAuthFlow? password) => this(password: password);

  @override
  OAuthFlows clientCredentials(OAuthFlow? clientCredentials) =>
      this(clientCredentials: clientCredentials);

  @override
  OAuthFlows authorizationCode(OAuthFlow? authorizationCode) =>
      this(authorizationCode: authorizationCode);

  @override
  OAuthFlows extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OAuthFlows(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlows(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlows call({
    Object? implicit = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? clientCredentials = const $CopyWithPlaceholder(),
    Object? authorizationCode = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return OAuthFlows(
      implicit: implicit == const $CopyWithPlaceholder()
          ? _value.implicit
          // ignore: cast_nullable_to_non_nullable
          : implicit as OAuthFlow?,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as OAuthFlow?,
      clientCredentials: clientCredentials == const $CopyWithPlaceholder()
          ? _value.clientCredentials
          // ignore: cast_nullable_to_non_nullable
          : clientCredentials as OAuthFlow?,
      authorizationCode: authorizationCode == const $CopyWithPlaceholder()
          ? _value.authorizationCode
          // ignore: cast_nullable_to_non_nullable
          : authorizationCode as OAuthFlow?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $OAuthFlowsCopyWith on OAuthFlows {
  /// Returns a callable class that can be used as follows: `instanceOfOAuthFlows.copyWith(...)` or like so:`instanceOfOAuthFlows.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OAuthFlowsCWProxy get copyWith => _$OAuthFlowsCWProxyImpl(this);
}

abstract class _$SecuritySchemeCWProxy {
  SecurityScheme type(SecuritySchemeType type);

  SecurityScheme description(String? description);

  SecurityScheme name(String? name);

  SecurityScheme in_(SecuritySchemeIn? in_);

  SecurityScheme scheme(String? scheme);

  SecurityScheme bearerFormat(String? bearerFormat);

  SecurityScheme flows(OAuthFlows? flows);

  SecurityScheme openIdConnectUrl(String? openIdConnectUrl);

  SecurityScheme extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityScheme(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityScheme(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityScheme call({
    SecuritySchemeType type,
    String? description,
    String? name,
    SecuritySchemeIn? in_,
    String? scheme,
    String? bearerFormat,
    OAuthFlows? flows,
    String? openIdConnectUrl,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecurityScheme.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSecurityScheme.copyWith.fieldName(...)`
class _$SecuritySchemeCWProxyImpl implements _$SecuritySchemeCWProxy {
  const _$SecuritySchemeCWProxyImpl(this._value);

  final SecurityScheme _value;

  @override
  SecurityScheme type(SecuritySchemeType type) => this(type: type);

  @override
  SecurityScheme description(String? description) =>
      this(description: description);

  @override
  SecurityScheme name(String? name) => this(name: name);

  @override
  SecurityScheme in_(SecuritySchemeIn? in_) => this(in_: in_);

  @override
  SecurityScheme scheme(String? scheme) => this(scheme: scheme);

  @override
  SecurityScheme bearerFormat(String? bearerFormat) =>
      this(bearerFormat: bearerFormat);

  @override
  SecurityScheme flows(OAuthFlows? flows) => this(flows: flows);

  @override
  SecurityScheme openIdConnectUrl(String? openIdConnectUrl) =>
      this(openIdConnectUrl: openIdConnectUrl);

  @override
  SecurityScheme extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityScheme(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityScheme(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityScheme call({
    Object? type = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? in_ = const $CopyWithPlaceholder(),
    Object? scheme = const $CopyWithPlaceholder(),
    Object? bearerFormat = const $CopyWithPlaceholder(),
    Object? flows = const $CopyWithPlaceholder(),
    Object? openIdConnectUrl = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return SecurityScheme(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as SecuritySchemeType,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      in_: in_ == const $CopyWithPlaceholder()
          ? _value.in_
          // ignore: cast_nullable_to_non_nullable
          : in_ as SecuritySchemeIn?,
      scheme: scheme == const $CopyWithPlaceholder()
          ? _value.scheme
          // ignore: cast_nullable_to_non_nullable
          : scheme as String?,
      bearerFormat: bearerFormat == const $CopyWithPlaceholder()
          ? _value.bearerFormat
          // ignore: cast_nullable_to_non_nullable
          : bearerFormat as String?,
      flows: flows == const $CopyWithPlaceholder()
          ? _value.flows
          // ignore: cast_nullable_to_non_nullable
          : flows as OAuthFlows?,
      openIdConnectUrl: openIdConnectUrl == const $CopyWithPlaceholder()
          ? _value.openIdConnectUrl
          // ignore: cast_nullable_to_non_nullable
          : openIdConnectUrl as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $SecuritySchemeCopyWith on SecurityScheme {
  /// Returns a callable class that can be used as follows: `instanceOfSecurityScheme.copyWith(...)` or like so:`instanceOfSecurityScheme.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SecuritySchemeCWProxy get copyWith => _$SecuritySchemeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SecurityRequirementToJson(
  SecurityRequirement instance,
) => <String, dynamic>{'requirements': instance.requirements};

OAuthFlow _$OAuthFlowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OAuthFlow', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['authorizationUrl', 'tokenUrl', 'refreshUrl', 'scopes'],
  );
  final val = OAuthFlow(
    authorizationUrl: $checkedConvert('authorizationUrl', (v) => v as String?),
    tokenUrl: $checkedConvert('tokenUrl', (v) => v as String?),
    refreshUrl: $checkedConvert('refreshUrl', (v) => v as String?),
    scopes: $checkedConvert(
      'scopes',
      (v) => Map<String, String>.from(v as Map),
    ),
  );
  return val;
});

Map<String, dynamic> _$OAuthFlowToJson(OAuthFlow instance) => <String, dynamic>{
  'authorizationUrl': ?instance.authorizationUrl,
  'tokenUrl': ?instance.tokenUrl,
  'refreshUrl': ?instance.refreshUrl,
  'scopes': instance.scopes,
};

OAuthFlows _$OAuthFlowsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OAuthFlows', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'implicit',
          'password',
          'clientCredentials',
          'authorizationCode',
        ],
      );
      final val = OAuthFlows(
        implicit: $checkedConvert(
          'implicit',
          (v) =>
              v == null ? null : OAuthFlow.fromJson(v as Map<String, dynamic>),
        ),
        password: $checkedConvert(
          'password',
          (v) =>
              v == null ? null : OAuthFlow.fromJson(v as Map<String, dynamic>),
        ),
        clientCredentials: $checkedConvert(
          'clientCredentials',
          (v) =>
              v == null ? null : OAuthFlow.fromJson(v as Map<String, dynamic>),
        ),
        authorizationCode: $checkedConvert(
          'authorizationCode',
          (v) =>
              v == null ? null : OAuthFlow.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OAuthFlowsToJson(OAuthFlows instance) =>
    <String, dynamic>{
      'implicit': ?instance.implicit?.toJson(),
      'password': ?instance.password?.toJson(),
      'clientCredentials': ?instance.clientCredentials?.toJson(),
      'authorizationCode': ?instance.authorizationCode?.toJson(),
    };

SecurityScheme _$SecuritySchemeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SecurityScheme', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'type',
          'description',
          'name',
          'in',
          'scheme',
          'bearerFormat',
          'flows',
          'openIdConnectUrl',
        ],
      );
      final val = SecurityScheme(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$SecuritySchemeTypeEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        in_: $checkedConvert(
          'in',
          (v) => $enumDecodeNullable(_$SecuritySchemeInEnumMap, v),
        ),
        scheme: $checkedConvert('scheme', (v) => v as String?),
        bearerFormat: $checkedConvert('bearerFormat', (v) => v as String?),
        flows: $checkedConvert(
          'flows',
          (v) =>
              v == null ? null : OAuthFlows.fromJson(v as Map<String, dynamic>),
        ),
        openIdConnectUrl: $checkedConvert(
          'openIdConnectUrl',
          (v) => v as String?,
        ),
      );
      return val;
    }, fieldKeyMap: const {'in_': 'in'});

Map<String, dynamic> _$SecuritySchemeToJson(SecurityScheme instance) =>
    <String, dynamic>{
      'type': _$SecuritySchemeTypeEnumMap[instance.type]!,
      'description': ?instance.description,
      'name': ?instance.name,
      'in': ?_$SecuritySchemeInEnumMap[instance.in_],
      'scheme': ?instance.scheme,
      'bearerFormat': ?instance.bearerFormat,
      'flows': ?instance.flows?.toJson(),
      'openIdConnectUrl': ?instance.openIdConnectUrl,
    };

const _$SecuritySchemeTypeEnumMap = {
  SecuritySchemeType.apiKey: 'apiKey',
  SecuritySchemeType.http: 'http',
  SecuritySchemeType.oauth2: 'oauth2',
  SecuritySchemeType.openIdConnect: 'openIdConnect',
};

const _$SecuritySchemeInEnumMap = {
  SecuritySchemeIn.query: 'query',
  SecuritySchemeIn.header: 'header',
  SecuritySchemeIn.cookie: 'cookie',
};
