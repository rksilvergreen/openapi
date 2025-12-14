// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../server.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ServerVariableCWProxy {
  ServerVariable enum_(List<String>? enum_);

  ServerVariable default_(String default_);

  ServerVariable description(String? description);

  ServerVariable extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ServerVariable(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ServerVariable(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerVariable call({
    List<String>? enum_,
    String default_,
    String? description,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServerVariable.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfServerVariable.copyWith.fieldName(...)`
class _$ServerVariableCWProxyImpl implements _$ServerVariableCWProxy {
  const _$ServerVariableCWProxyImpl(this._value);

  final ServerVariable _value;

  @override
  ServerVariable enum_(List<String>? enum_) => this(enum_: enum_);

  @override
  ServerVariable default_(String default_) => this(default_: default_);

  @override
  ServerVariable description(String? description) =>
      this(description: description);

  @override
  ServerVariable extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ServerVariable(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ServerVariable(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerVariable call({
    Object? enum_ = const $CopyWithPlaceholder(),
    Object? default_ = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ServerVariable(
      enum_: enum_ == const $CopyWithPlaceholder()
          ? _value.enum_
          // ignore: cast_nullable_to_non_nullable
          : enum_ as List<String>?,
      default_: default_ == const $CopyWithPlaceholder()
          ? _value.default_
          // ignore: cast_nullable_to_non_nullable
          : default_ as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ServerVariableCopyWith on ServerVariable {
  /// Returns a callable class that can be used as follows: `instanceOfServerVariable.copyWith(...)` or like so:`instanceOfServerVariable.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerVariableCWProxy get copyWith => _$ServerVariableCWProxyImpl(this);
}

abstract class _$ServerCWProxy {
  Server url(String url);

  Server description(String? description);

  Server variables(Map<String, ServerVariable>? variables);

  Server extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Server(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Server(...).copyWith(id: 12, name: "My name")
  /// ````
  Server call({
    String url,
    String? description,
    Map<String, ServerVariable>? variables,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServer.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfServer.copyWith.fieldName(...)`
class _$ServerCWProxyImpl implements _$ServerCWProxy {
  const _$ServerCWProxyImpl(this._value);

  final Server _value;

  @override
  Server url(String url) => this(url: url);

  @override
  Server description(String? description) => this(description: description);

  @override
  Server variables(Map<String, ServerVariable>? variables) =>
      this(variables: variables);

  @override
  Server extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Server(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Server(...).copyWith(id: 12, name: "My name")
  /// ````
  Server call({
    Object? url = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? variables = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Server(
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      variables: variables == const $CopyWithPlaceholder()
          ? _value.variables
          // ignore: cast_nullable_to_non_nullable
          : variables as Map<String, ServerVariable>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ServerCopyWith on Server {
  /// Returns a callable class that can be used as follows: `instanceOfServer.copyWith(...)` or like so:`instanceOfServer.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerCWProxy get copyWith => _$ServerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerVariable _$ServerVariableFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ServerVariable', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['enum', 'default', 'description']);
      final val = ServerVariable(
        enum_: $checkedConvert(
          'enum',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        default_: $checkedConvert('default', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'enum_': 'enum', 'default_': 'default'});

Map<String, dynamic> _$ServerVariableToJson(ServerVariable instance) =>
    <String, dynamic>{
      'enum': ?instance.enum_,
      'default': instance.default_,
      'description': ?instance.description,
    };

Server _$ServerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Server', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['url', 'description', 'variables']);
      final val = Server(
        url: $checkedConvert('url', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        variables: $checkedConvert(
          'variables',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, ServerVariable.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
  'url': instance.url,
  'description': ?instance.description,
  'variables': ?instance.variables?.map((k, e) => MapEntry(k, e.toJson())),
};
