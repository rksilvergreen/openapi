// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../callback.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CallbackCWProxy {
  Callback expressions(Map<String, PathItem> expressions);

  Callback extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Callback(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Callback(...).copyWith(id: 12, name: "My name")
  /// ````
  Callback call({
    Map<String, PathItem> expressions,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCallback.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCallback.copyWith.fieldName(...)`
class _$CallbackCWProxyImpl implements _$CallbackCWProxy {
  const _$CallbackCWProxyImpl(this._value);

  final Callback _value;

  @override
  Callback expressions(Map<String, PathItem> expressions) =>
      this(expressions: expressions);

  @override
  Callback extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Callback(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Callback(...).copyWith(id: 12, name: "My name")
  /// ````
  Callback call({
    Object? expressions = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Callback(
      expressions: expressions == const $CopyWithPlaceholder()
          ? _value.expressions
          // ignore: cast_nullable_to_non_nullable
          : expressions as Map<String, PathItem>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $CallbackCopyWith on Callback {
  /// Returns a callable class that can be used as follows: `instanceOfCallback.copyWith(...)` or like so:`instanceOfCallback.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CallbackCWProxy get copyWith => _$CallbackCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CallbackToJson(Callback instance) => <String, dynamic>{
  'expressions': instance.expressions.map((k, e) => MapEntry(k, e.toJson())),
};
