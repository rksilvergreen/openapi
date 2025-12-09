// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../paths.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PathsCWProxy {
  Paths paths(Map<String, PathItem> paths);

  Paths extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Paths(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Paths(...).copyWith(id: 12, name: "My name")
  /// ````
  Paths call({Map<String, PathItem> paths, Map<String, dynamic>? extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaths.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaths.copyWith.fieldName(...)`
class _$PathsCWProxyImpl implements _$PathsCWProxy {
  const _$PathsCWProxyImpl(this._value);

  final Paths _value;

  @override
  Paths paths(Map<String, PathItem> paths) => this(paths: paths);

  @override
  Paths extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Paths(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Paths(...).copyWith(id: 12, name: "My name")
  /// ````
  Paths call({
    Object? paths = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Paths(
      paths: paths == const $CopyWithPlaceholder()
          ? _value.paths
          // ignore: cast_nullable_to_non_nullable
          : paths as Map<String, PathItem>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $PathsCopyWith on Paths {
  /// Returns a callable class that can be used as follows: `instanceOfPaths.copyWith(...)` or like so:`instanceOfPaths.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PathsCWProxy get copyWith => _$PathsCWProxyImpl(this);
}

abstract class _$PathItemCWProxy {
  PathItem ref(String? ref);

  PathItem summary(String? summary);

  PathItem description(String? description);

  PathItem get_(Operation? get_);

  PathItem put(Operation? put);

  PathItem post(Operation? post);

  PathItem delete(Operation? delete);

  PathItem options(Operation? options);

  PathItem head(Operation? head);

  PathItem patch(Operation? patch);

  PathItem trace(Operation? trace);

  PathItem servers(List<Server>? servers);

  PathItem parameters(List<Referenceable<Parameter>>? parameters);

  PathItem extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PathItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PathItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PathItem call({
    String? ref,
    String? summary,
    String? description,
    Operation? get_,
    Operation? put,
    Operation? post,
    Operation? delete,
    Operation? options,
    Operation? head,
    Operation? patch,
    Operation? trace,
    List<Server>? servers,
    List<Referenceable<Parameter>>? parameters,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPathItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPathItem.copyWith.fieldName(...)`
class _$PathItemCWProxyImpl implements _$PathItemCWProxy {
  const _$PathItemCWProxyImpl(this._value);

  final PathItem _value;

  @override
  PathItem ref(String? ref) => this(ref: ref);

  @override
  PathItem summary(String? summary) => this(summary: summary);

  @override
  PathItem description(String? description) => this(description: description);

  @override
  PathItem get_(Operation? get_) => this(get_: get_);

  @override
  PathItem put(Operation? put) => this(put: put);

  @override
  PathItem post(Operation? post) => this(post: post);

  @override
  PathItem delete(Operation? delete) => this(delete: delete);

  @override
  PathItem options(Operation? options) => this(options: options);

  @override
  PathItem head(Operation? head) => this(head: head);

  @override
  PathItem patch(Operation? patch) => this(patch: patch);

  @override
  PathItem trace(Operation? trace) => this(trace: trace);

  @override
  PathItem servers(List<Server>? servers) => this(servers: servers);

  @override
  PathItem parameters(List<Referenceable<Parameter>>? parameters) =>
      this(parameters: parameters);

  @override
  PathItem extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PathItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PathItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PathItem call({
    Object? ref = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? get_ = const $CopyWithPlaceholder(),
    Object? put = const $CopyWithPlaceholder(),
    Object? post = const $CopyWithPlaceholder(),
    Object? delete = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
    Object? head = const $CopyWithPlaceholder(),
    Object? patch = const $CopyWithPlaceholder(),
    Object? trace = const $CopyWithPlaceholder(),
    Object? servers = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return PathItem(
      ref: ref == const $CopyWithPlaceholder()
          ? _value.ref
          // ignore: cast_nullable_to_non_nullable
          : ref as String?,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      get_: get_ == const $CopyWithPlaceholder()
          ? _value.get_
          // ignore: cast_nullable_to_non_nullable
          : get_ as Operation?,
      put: put == const $CopyWithPlaceholder()
          ? _value.put
          // ignore: cast_nullable_to_non_nullable
          : put as Operation?,
      post: post == const $CopyWithPlaceholder()
          ? _value.post
          // ignore: cast_nullable_to_non_nullable
          : post as Operation?,
      delete: delete == const $CopyWithPlaceholder()
          ? _value.delete
          // ignore: cast_nullable_to_non_nullable
          : delete as Operation?,
      options: options == const $CopyWithPlaceholder()
          ? _value.options
          // ignore: cast_nullable_to_non_nullable
          : options as Operation?,
      head: head == const $CopyWithPlaceholder()
          ? _value.head
          // ignore: cast_nullable_to_non_nullable
          : head as Operation?,
      patch: patch == const $CopyWithPlaceholder()
          ? _value.patch
          // ignore: cast_nullable_to_non_nullable
          : patch as Operation?,
      trace: trace == const $CopyWithPlaceholder()
          ? _value.trace
          // ignore: cast_nullable_to_non_nullable
          : trace as Operation?,
      servers: servers == const $CopyWithPlaceholder()
          ? _value.servers
          // ignore: cast_nullable_to_non_nullable
          : servers as List<Server>?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as List<Referenceable<Parameter>>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $PathItemCopyWith on PathItem {
  /// Returns a callable class that can be used as follows: `instanceOfPathItem.copyWith(...)` or like so:`instanceOfPathItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PathItemCWProxy get copyWith => _$PathItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PathsToJson(Paths instance) => <String, dynamic>{
  'paths': instance.paths.map((k, e) => MapEntry(k, e.toJson())),
};

PathItem _$PathItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PathItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          r'$ref',
          'summary',
          'description',
          'get',
          'put',
          'post',
          'delete',
          'options',
          'head',
          'patch',
          'trace',
          'servers',
          'parameters',
        ],
      );
      final val = PathItem(
        ref: $checkedConvert(r'$ref', (v) => v as String?),
        summary: $checkedConvert('summary', (v) => v as String?),
        description: $checkedConvert('description', (v) => v as String?),
        get_: $checkedConvert(
          'get',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        put: $checkedConvert(
          'put',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        post: $checkedConvert(
          'post',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        delete: $checkedConvert(
          'delete',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        options: $checkedConvert(
          'options',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        head: $checkedConvert(
          'head',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        patch: $checkedConvert(
          'patch',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        trace: $checkedConvert(
          'trace',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        servers: $checkedConvert(
          'servers',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Server.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        parameters: $checkedConvert(
          'parameters',
          (v) => (v as List<dynamic>?)
              ?.map(Referenceable<Parameter>.fromJson)
              .toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'ref': r'$ref', 'get_': 'get'});

Map<String, dynamic> _$PathItemToJson(PathItem instance) => <String, dynamic>{
  r'$ref': ?instance.ref,
  'summary': ?instance.summary,
  'description': ?instance.description,
  'get': ?instance.get_?.toJson(),
  'put': ?instance.put?.toJson(),
  'post': ?instance.post?.toJson(),
  'delete': ?instance.delete?.toJson(),
  'options': ?instance.options?.toJson(),
  'head': ?instance.head?.toJson(),
  'patch': ?instance.patch?.toJson(),
  'trace': ?instance.trace?.toJson(),
  'servers': ?instance.servers?.map((e) => e.toJson()).toList(),
  'parameters': ?instance.parameters?.map((e) => e.toJson()).toList(),
};
