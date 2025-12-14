// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../openapi_document.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OpenApiDocumentCWProxy {
  OpenApiDocument openapi(String openapi);

  OpenApiDocument info(Info info);

  OpenApiDocument servers(List<Server>? servers);

  OpenApiDocument paths(Paths paths);

  OpenApiDocument components(Components? components);

  OpenApiDocument security(List<SecurityRequirement>? security);

  OpenApiDocument tags(List<Tag>? tags);

  OpenApiDocument externalDocs(ExternalDocumentation? externalDocs);

  OpenApiDocument extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OpenApiDocument(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OpenApiDocument(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenApiDocument call({
    String openapi,
    Info info,
    List<Server>? servers,
    Paths paths,
    Components? components,
    List<SecurityRequirement>? security,
    List<Tag>? tags,
    ExternalDocumentation? externalDocs,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOpenApiDocument.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOpenApiDocument.copyWith.fieldName(...)`
class _$OpenApiDocumentCWProxyImpl implements _$OpenApiDocumentCWProxy {
  const _$OpenApiDocumentCWProxyImpl(this._value);

  final OpenApiDocument _value;

  @override
  OpenApiDocument openapi(String openapi) => this(openapi: openapi);

  @override
  OpenApiDocument info(Info info) => this(info: info);

  @override
  OpenApiDocument servers(List<Server>? servers) => this(servers: servers);

  @override
  OpenApiDocument paths(Paths paths) => this(paths: paths);

  @override
  OpenApiDocument components(Components? components) =>
      this(components: components);

  @override
  OpenApiDocument security(List<SecurityRequirement>? security) =>
      this(security: security);

  @override
  OpenApiDocument tags(List<Tag>? tags) => this(tags: tags);

  @override
  OpenApiDocument externalDocs(ExternalDocumentation? externalDocs) =>
      this(externalDocs: externalDocs);

  @override
  OpenApiDocument extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OpenApiDocument(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OpenApiDocument(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenApiDocument call({
    Object? openapi = const $CopyWithPlaceholder(),
    Object? info = const $CopyWithPlaceholder(),
    Object? servers = const $CopyWithPlaceholder(),
    Object? paths = const $CopyWithPlaceholder(),
    Object? components = const $CopyWithPlaceholder(),
    Object? security = const $CopyWithPlaceholder(),
    Object? tags = const $CopyWithPlaceholder(),
    Object? externalDocs = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return OpenApiDocument(
      openapi: openapi == const $CopyWithPlaceholder()
          ? _value.openapi
          // ignore: cast_nullable_to_non_nullable
          : openapi as String,
      info: info == const $CopyWithPlaceholder()
          ? _value.info
          // ignore: cast_nullable_to_non_nullable
          : info as Info,
      servers: servers == const $CopyWithPlaceholder()
          ? _value.servers
          // ignore: cast_nullable_to_non_nullable
          : servers as List<Server>?,
      paths: paths == const $CopyWithPlaceholder()
          ? _value.paths
          // ignore: cast_nullable_to_non_nullable
          : paths as Paths,
      components: components == const $CopyWithPlaceholder()
          ? _value.components
          // ignore: cast_nullable_to_non_nullable
          : components as Components?,
      security: security == const $CopyWithPlaceholder()
          ? _value.security
          // ignore: cast_nullable_to_non_nullable
          : security as List<SecurityRequirement>?,
      tags: tags == const $CopyWithPlaceholder()
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as List<Tag>?,
      externalDocs: externalDocs == const $CopyWithPlaceholder()
          ? _value.externalDocs
          // ignore: cast_nullable_to_non_nullable
          : externalDocs as ExternalDocumentation?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $OpenApiDocumentCopyWith on OpenApiDocument {
  /// Returns a callable class that can be used as follows: `instanceOfOpenApiDocument.copyWith(...)` or like so:`instanceOfOpenApiDocument.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OpenApiDocumentCWProxy get copyWith => _$OpenApiDocumentCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenApiDocument _$OpenApiDocumentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OpenApiDocument', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'openapi',
          'info',
          'servers',
          'paths',
          'components',
          'security',
          'tags',
          'externalDocs',
        ],
      );
      final val = OpenApiDocument(
        openapi: $checkedConvert('openapi', (v) => v as String),
        info: $checkedConvert(
          'info',
          (v) => Info.fromJson(v as Map<String, dynamic>),
        ),
        servers: $checkedConvert(
          'servers',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Server.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        paths: $checkedConvert(
          'paths',
          (v) => Paths.fromJson(v as Map<String, dynamic>),
        ),
        components: $checkedConvert(
          'components',
          (v) =>
              v == null ? null : Components.fromJson(v as Map<String, dynamic>),
        ),
        security: $checkedConvert(
          'security',
          (v) => (v as List<dynamic>?)
              ?.map(
                (e) => SecurityRequirement.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        tags: $checkedConvert(
          'tags',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        externalDocs: $checkedConvert(
          'externalDocs',
          (v) => v == null
              ? null
              : ExternalDocumentation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OpenApiDocumentToJson(OpenApiDocument instance) =>
    <String, dynamic>{
      'openapi': instance.openapi,
      'info': instance.info.toJson(),
      'servers': ?instance.servers?.map((e) => e.toJson()).toList(),
      'paths': instance.paths.toJson(),
      'components': ?instance.components?.toJson(),
      'security': ?instance.security?.map((e) => e.toJson()).toList(),
      'tags': ?instance.tags?.map((e) => e.toJson()).toList(),
      'externalDocs': ?instance.externalDocs?.toJson(),
    };
