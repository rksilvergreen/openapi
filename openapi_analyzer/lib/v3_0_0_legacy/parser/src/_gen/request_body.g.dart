// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../request_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RequestBodyCWProxy {
  RequestBody description(String? description);

  RequestBody content(Map<String, MediaType> content);

  RequestBody required_(bool required_);

  RequestBody extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestBody call({
    String? description,
    Map<String, MediaType> content,
    bool required_,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRequestBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRequestBody.copyWith.fieldName(...)`
class _$RequestBodyCWProxyImpl implements _$RequestBodyCWProxy {
  const _$RequestBodyCWProxyImpl(this._value);

  final RequestBody _value;

  @override
  RequestBody description(String? description) =>
      this(description: description);

  @override
  RequestBody content(Map<String, MediaType> content) => this(content: content);

  @override
  RequestBody required_(bool required_) => this(required_: required_);

  @override
  RequestBody extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestBody call({
    Object? description = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return RequestBody(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as Map<String, MediaType>,
      required_: required_ == const $CopyWithPlaceholder()
          ? _value.required_
          // ignore: cast_nullable_to_non_nullable
          : required_ as bool,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $RequestBodyCopyWith on RequestBody {
  /// Returns a callable class that can be used as follows: `instanceOfRequestBody.copyWith(...)` or like so:`instanceOfRequestBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RequestBodyCWProxy get copyWith => _$RequestBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestBody _$RequestBodyFromJson(Map<String, dynamic> json) => $checkedCreate(
  'RequestBody',
  json,
  ($checkedConvert) {
    $checkKeys(json, allowedKeys: const ['description', 'content', 'required']);
    final val = RequestBody(
      description: $checkedConvert('description', (v) => v as String?),
      content: $checkedConvert(
        'content',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(k, MediaType.fromJson(e as Map<String, dynamic>)),
        ),
      ),
      required_: $checkedConvert('required', (v) => v as bool? ?? false),
    );
    return val;
  },
  fieldKeyMap: const {'required_': 'required'},
);

Map<String, dynamic> _$RequestBodyToJson(RequestBody instance) =>
    <String, dynamic>{
      'description': ?instance.description,
      'content': instance.content.map((k, e) => MapEntry(k, e.toJson())),
      'required': instance.required_,
    };
