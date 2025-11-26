// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../operation.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OperationCWProxy {
  Operation tags(List<String>? tags);

  Operation summary(String? summary);

  Operation description(String? description);

  Operation externalDocs(ExternalDocumentation? externalDocs);

  Operation operationId(String? operationId);

  Operation parameters(List<Referenceable<Parameter>>? parameters);

  Operation requestBody(Referenceable<RequestBody>? requestBody);

  Operation responses(Map<String, Referenceable<Response>> responses);

  Operation callbacks(Map<String, Referenceable<Callback>>? callbacks);

  Operation deprecated(bool deprecated);

  Operation security(List<SecurityRequirement>? security);

  Operation servers(List<Server>? servers);

  Operation extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Operation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Operation(...).copyWith(id: 12, name: "My name")
  /// ````
  Operation call({
    List<String>? tags,
    String? summary,
    String? description,
    ExternalDocumentation? externalDocs,
    String? operationId,
    List<Referenceable<Parameter>>? parameters,
    Referenceable<RequestBody>? requestBody,
    Map<String, Referenceable<Response>> responses,
    Map<String, Referenceable<Callback>>? callbacks,
    bool deprecated,
    List<SecurityRequirement>? security,
    List<Server>? servers,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOperation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOperation.copyWith.fieldName(...)`
class _$OperationCWProxyImpl implements _$OperationCWProxy {
  const _$OperationCWProxyImpl(this._value);

  final Operation _value;

  @override
  Operation tags(List<String>? tags) => this(tags: tags);

  @override
  Operation summary(String? summary) => this(summary: summary);

  @override
  Operation description(String? description) => this(description: description);

  @override
  Operation externalDocs(ExternalDocumentation? externalDocs) =>
      this(externalDocs: externalDocs);

  @override
  Operation operationId(String? operationId) => this(operationId: operationId);

  @override
  Operation parameters(List<Referenceable<Parameter>>? parameters) =>
      this(parameters: parameters);

  @override
  Operation requestBody(Referenceable<RequestBody>? requestBody) =>
      this(requestBody: requestBody);

  @override
  Operation responses(Map<String, Referenceable<Response>> responses) =>
      this(responses: responses);

  @override
  Operation callbacks(Map<String, Referenceable<Callback>>? callbacks) =>
      this(callbacks: callbacks);

  @override
  Operation deprecated(bool deprecated) => this(deprecated: deprecated);

  @override
  Operation security(List<SecurityRequirement>? security) =>
      this(security: security);

  @override
  Operation servers(List<Server>? servers) => this(servers: servers);

  @override
  Operation extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Operation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Operation(...).copyWith(id: 12, name: "My name")
  /// ````
  Operation call({
    Object? tags = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? externalDocs = const $CopyWithPlaceholder(),
    Object? operationId = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
    Object? requestBody = const $CopyWithPlaceholder(),
    Object? responses = const $CopyWithPlaceholder(),
    Object? callbacks = const $CopyWithPlaceholder(),
    Object? deprecated = const $CopyWithPlaceholder(),
    Object? security = const $CopyWithPlaceholder(),
    Object? servers = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Operation(
      tags: tags == const $CopyWithPlaceholder()
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as List<String>?,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      externalDocs: externalDocs == const $CopyWithPlaceholder()
          ? _value.externalDocs
          // ignore: cast_nullable_to_non_nullable
          : externalDocs as ExternalDocumentation?,
      operationId: operationId == const $CopyWithPlaceholder()
          ? _value.operationId
          // ignore: cast_nullable_to_non_nullable
          : operationId as String?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as List<Referenceable<Parameter>>?,
      requestBody: requestBody == const $CopyWithPlaceholder()
          ? _value.requestBody
          // ignore: cast_nullable_to_non_nullable
          : requestBody as Referenceable<RequestBody>?,
      responses: responses == const $CopyWithPlaceholder()
          ? _value.responses
          // ignore: cast_nullable_to_non_nullable
          : responses as Map<String, Referenceable<Response>>,
      callbacks: callbacks == const $CopyWithPlaceholder()
          ? _value.callbacks
          // ignore: cast_nullable_to_non_nullable
          : callbacks as Map<String, Referenceable<Callback>>?,
      deprecated: deprecated == const $CopyWithPlaceholder()
          ? _value.deprecated
          // ignore: cast_nullable_to_non_nullable
          : deprecated as bool,
      security: security == const $CopyWithPlaceholder()
          ? _value.security
          // ignore: cast_nullable_to_non_nullable
          : security as List<SecurityRequirement>?,
      servers: servers == const $CopyWithPlaceholder()
          ? _value.servers
          // ignore: cast_nullable_to_non_nullable
          : servers as List<Server>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $OperationCopyWith on Operation {
  /// Returns a callable class that can be used as follows: `instanceOfOperation.copyWith(...)` or like so:`instanceOfOperation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OperationCWProxy get copyWith => _$OperationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Operation _$OperationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Operation', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'tags',
          'summary',
          'description',
          'externalDocs',
          'operationId',
          'parameters',
          'requestBody',
          'responses',
          'callbacks',
          'deprecated',
          'security',
          'servers',
        ],
      );
      final val = Operation(
        tags: $checkedConvert(
          'tags',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        summary: $checkedConvert('summary', (v) => v as String?),
        description: $checkedConvert('description', (v) => v as String?),
        externalDocs: $checkedConvert(
          'externalDocs',
          (v) => v == null
              ? null
              : ExternalDocumentation.fromJson(v as Map<String, dynamic>),
        ),
        operationId: $checkedConvert('operationId', (v) => v as String?),
        parameters: $checkedConvert(
          'parameters',
          (v) => (v as List<dynamic>?)
              ?.map(Referenceable<Parameter>.fromJson)
              .toList(),
        ),
        requestBody: $checkedConvert(
          'requestBody',
          (v) => v == null ? null : Referenceable<RequestBody>.fromJson(v),
        ),
        responses: $checkedConvert(
          'responses',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, Referenceable<Response>.fromJson(e)),
          ),
        ),
        callbacks: $checkedConvert(
          'callbacks',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Callback>.fromJson(e)),
          ),
        ),
        deprecated: $checkedConvert('deprecated', (v) => v as bool? ?? false),
        security: $checkedConvert(
          'security',
          (v) => (v as List<dynamic>?)
              ?.map(
                (e) => SecurityRequirement.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        servers: $checkedConvert(
          'servers',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Server.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OperationToJson(Operation instance) => <String, dynamic>{
  'tags': ?instance.tags,
  'summary': ?instance.summary,
  'description': ?instance.description,
  'externalDocs': ?instance.externalDocs?.toJson(),
  'operationId': ?instance.operationId,
  'parameters': ?instance.parameters?.map((e) => e.toJson()).toList(),
  'requestBody': ?instance.requestBody?.toJson(),
  'responses': instance.responses.map((k, e) => MapEntry(k, e.toJson())),
  'callbacks': ?instance.callbacks?.map((k, e) => MapEntry(k, e.toJson())),
  'deprecated': instance.deprecated,
  'security': ?instance.security?.map((e) => e.toJson()).toList(),
  'servers': ?instance.servers?.map((e) => e.toJson()).toList(),
};
