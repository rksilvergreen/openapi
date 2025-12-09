// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../link.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LinkCWProxy {
  Link operationRef(String? operationRef);

  Link operationId(String? operationId);

  Link parameters(Map<String, dynamic>? parameters);

  Link requestBody(dynamic requestBody);

  Link description(String? description);

  Link server(Server? server);

  Link extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Link(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Link(...).copyWith(id: 12, name: "My name")
  /// ````
  Link call({
    String? operationRef,
    String? operationId,
    Map<String, dynamic>? parameters,
    dynamic requestBody,
    String? description,
    Server? server,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLink.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLink.copyWith.fieldName(...)`
class _$LinkCWProxyImpl implements _$LinkCWProxy {
  const _$LinkCWProxyImpl(this._value);

  final Link _value;

  @override
  Link operationRef(String? operationRef) => this(operationRef: operationRef);

  @override
  Link operationId(String? operationId) => this(operationId: operationId);

  @override
  Link parameters(Map<String, dynamic>? parameters) =>
      this(parameters: parameters);

  @override
  Link requestBody(dynamic requestBody) => this(requestBody: requestBody);

  @override
  Link description(String? description) => this(description: description);

  @override
  Link server(Server? server) => this(server: server);

  @override
  Link extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Link(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Link(...).copyWith(id: 12, name: "My name")
  /// ````
  Link call({
    Object? operationRef = const $CopyWithPlaceholder(),
    Object? operationId = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
    Object? requestBody = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? server = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Link(
      operationRef: operationRef == const $CopyWithPlaceholder()
          ? _value.operationRef
          // ignore: cast_nullable_to_non_nullable
          : operationRef as String?,
      operationId: operationId == const $CopyWithPlaceholder()
          ? _value.operationId
          // ignore: cast_nullable_to_non_nullable
          : operationId as String?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as Map<String, dynamic>?,
      requestBody: requestBody == const $CopyWithPlaceholder()
          ? _value.requestBody
          // ignore: cast_nullable_to_non_nullable
          : requestBody as dynamic,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      server: server == const $CopyWithPlaceholder()
          ? _value.server
          // ignore: cast_nullable_to_non_nullable
          : server as Server?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $LinkCopyWith on Link {
  /// Returns a callable class that can be used as follows: `instanceOfLink.copyWith(...)` or like so:`instanceOfLink.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LinkCWProxy get copyWith => _$LinkCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Link', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'operationRef',
          'operationId',
          'parameters',
          'requestBody',
          'description',
          'server',
        ],
      );
      final val = Link(
        operationRef: $checkedConvert('operationRef', (v) => v as String?),
        operationId: $checkedConvert('operationId', (v) => v as String?),
        parameters: $checkedConvert(
          'parameters',
          (v) => v as Map<String, dynamic>?,
        ),
        requestBody: $checkedConvert('requestBody', (v) => v),
        description: $checkedConvert('description', (v) => v as String?),
        server: $checkedConvert(
          'server',
          (v) => v == null ? null : Server.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
  'operationRef': ?instance.operationRef,
  'operationId': ?instance.operationId,
  'parameters': ?instance.parameters,
  'requestBody': ?instance.requestBody,
  'description': ?instance.description,
  'server': ?instance.server?.toJson(),
};
