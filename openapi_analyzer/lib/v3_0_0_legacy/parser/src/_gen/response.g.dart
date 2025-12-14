// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResponseCWProxy {
  Response description(String description);

  Response headers(Map<String, Referenceable<Header>>? headers);

  Response content(Map<String, MediaType>? content);

  Response links(Map<String, Referenceable<Link>>? links);

  Response extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Response(...).copyWith(id: 12, name: "My name")
  /// ````
  Response call({
    String description,
    Map<String, Referenceable<Header>>? headers,
    Map<String, MediaType>? content,
    Map<String, Referenceable<Link>>? links,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResponse.copyWith.fieldName(...)`
class _$ResponseCWProxyImpl implements _$ResponseCWProxy {
  const _$ResponseCWProxyImpl(this._value);

  final Response _value;

  @override
  Response description(String description) => this(description: description);

  @override
  Response headers(Map<String, Referenceable<Header>>? headers) =>
      this(headers: headers);

  @override
  Response content(Map<String, MediaType>? content) => this(content: content);

  @override
  Response links(Map<String, Referenceable<Link>>? links) => this(links: links);

  @override
  Response extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Response(...).copyWith(id: 12, name: "My name")
  /// ````
  Response call({
    Object? description = const $CopyWithPlaceholder(),
    Object? headers = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? links = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Response(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as Map<String, Referenceable<Header>>?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as Map<String, MediaType>?,
      links: links == const $CopyWithPlaceholder()
          ? _value.links
          // ignore: cast_nullable_to_non_nullable
          : links as Map<String, Referenceable<Link>>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ResponseCopyWith on Response {
  /// Returns a callable class that can be used as follows: `instanceOfResponse.copyWith(...)` or like so:`instanceOfResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResponseCWProxy get copyWith => _$ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Response', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['description', 'headers', 'content', 'links'],
      );
      final val = Response(
        description: $checkedConvert('description', (v) => v as String),
        headers: $checkedConvert(
          'headers',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Header>.fromJson(e)),
          ),
        ),
        content: $checkedConvert(
          'content',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, MediaType.fromJson(e as Map<String, dynamic>)),
          ),
        ),
        links: $checkedConvert(
          'links',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Link>.fromJson(e)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
  'description': instance.description,
  'headers': ?instance.headers?.map((k, e) => MapEntry(k, e.toJson())),
  'content': ?instance.content?.map((k, e) => MapEntry(k, e.toJson())),
  'links': ?instance.links?.map((k, e) => MapEntry(k, e.toJson())),
};
