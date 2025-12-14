// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../media_type.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MediaTypeCWProxy {
  MediaType schema(Referenceable<SchemaObject>? schema);

  MediaType example(dynamic example);

  MediaType examples(Map<String, Referenceable<Example>>? examples);

  MediaType encoding(Map<String, Encoding>? encoding);

  MediaType extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaType(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaType(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaType call({
    Referenceable<SchemaObject>? schema,
    dynamic example,
    Map<String, Referenceable<Example>>? examples,
    Map<String, Encoding>? encoding,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMediaType.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMediaType.copyWith.fieldName(...)`
class _$MediaTypeCWProxyImpl implements _$MediaTypeCWProxy {
  const _$MediaTypeCWProxyImpl(this._value);

  final MediaType _value;

  @override
  MediaType schema(Referenceable<SchemaObject>? schema) => this(schema: schema);

  @override
  MediaType example(dynamic example) => this(example: example);

  @override
  MediaType examples(Map<String, Referenceable<Example>>? examples) =>
      this(examples: examples);

  @override
  MediaType encoding(Map<String, Encoding>? encoding) =>
      this(encoding: encoding);

  @override
  MediaType extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaType(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaType(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaType call({
    Object? schema = const $CopyWithPlaceholder(),
    Object? example = const $CopyWithPlaceholder(),
    Object? examples = const $CopyWithPlaceholder(),
    Object? encoding = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return MediaType(
      schema: schema == const $CopyWithPlaceholder()
          ? _value.schema
          // ignore: cast_nullable_to_non_nullable
          : schema as Referenceable<SchemaObject>?,
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as Map<String, Referenceable<Example>>?,
      encoding: encoding == const $CopyWithPlaceholder()
          ? _value.encoding
          // ignore: cast_nullable_to_non_nullable
          : encoding as Map<String, Encoding>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $MediaTypeCopyWith on MediaType {
  /// Returns a callable class that can be used as follows: `instanceOfMediaType.copyWith(...)` or like so:`instanceOfMediaType.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MediaTypeCWProxy get copyWith => _$MediaTypeCWProxyImpl(this);
}

abstract class _$EncodingCWProxy {
  Encoding contentType(String? contentType);

  Encoding headers(Map<String, Referenceable<Header>>? headers);

  Encoding style(ParameterStyle? style);

  Encoding explode(bool? explode);

  Encoding allowReserved(bool allowReserved);

  Encoding extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Encoding(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Encoding(...).copyWith(id: 12, name: "My name")
  /// ````
  Encoding call({
    String? contentType,
    Map<String, Referenceable<Header>>? headers,
    ParameterStyle? style,
    bool? explode,
    bool allowReserved,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEncoding.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEncoding.copyWith.fieldName(...)`
class _$EncodingCWProxyImpl implements _$EncodingCWProxy {
  const _$EncodingCWProxyImpl(this._value);

  final Encoding _value;

  @override
  Encoding contentType(String? contentType) => this(contentType: contentType);

  @override
  Encoding headers(Map<String, Referenceable<Header>>? headers) =>
      this(headers: headers);

  @override
  Encoding style(ParameterStyle? style) => this(style: style);

  @override
  Encoding explode(bool? explode) => this(explode: explode);

  @override
  Encoding allowReserved(bool allowReserved) =>
      this(allowReserved: allowReserved);

  @override
  Encoding extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Encoding(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Encoding(...).copyWith(id: 12, name: "My name")
  /// ````
  Encoding call({
    Object? contentType = const $CopyWithPlaceholder(),
    Object? headers = const $CopyWithPlaceholder(),
    Object? style = const $CopyWithPlaceholder(),
    Object? explode = const $CopyWithPlaceholder(),
    Object? allowReserved = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Encoding(
      contentType: contentType == const $CopyWithPlaceholder()
          ? _value.contentType
          // ignore: cast_nullable_to_non_nullable
          : contentType as String?,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as Map<String, Referenceable<Header>>?,
      style: style == const $CopyWithPlaceholder()
          ? _value.style
          // ignore: cast_nullable_to_non_nullable
          : style as ParameterStyle?,
      explode: explode == const $CopyWithPlaceholder()
          ? _value.explode
          // ignore: cast_nullable_to_non_nullable
          : explode as bool?,
      allowReserved: allowReserved == const $CopyWithPlaceholder()
          ? _value.allowReserved
          // ignore: cast_nullable_to_non_nullable
          : allowReserved as bool,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $EncodingCopyWith on Encoding {
  /// Returns a callable class that can be used as follows: `instanceOfEncoding.copyWith(...)` or like so:`instanceOfEncoding.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EncodingCWProxy get copyWith => _$EncodingCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaType _$MediaTypeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MediaType', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['schema', 'example', 'examples', 'encoding'],
      );
      final val = MediaType(
        schema: $checkedConvert(
          'schema',
          (v) => v == null ? null : Referenceable<SchemaObject>.fromJson(v),
        ),
        example: $checkedConvert('example', (v) => v),
        examples: $checkedConvert(
          'examples',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Example>.fromJson(e)),
          ),
        ),
        encoding: $checkedConvert(
          'encoding',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Encoding.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MediaTypeToJson(MediaType instance) => <String, dynamic>{
  'schema': ?instance.schema?.toJson(),
  'example': ?instance.example,
  'examples': ?instance.examples?.map((k, e) => MapEntry(k, e.toJson())),
  'encoding': ?instance.encoding?.map((k, e) => MapEntry(k, e.toJson())),
};

Encoding _$EncodingFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Encoding', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'contentType',
          'headers',
          'style',
          'explode',
          'allowReserved',
        ],
      );
      final val = Encoding(
        contentType: $checkedConvert('contentType', (v) => v as String?),
        headers: $checkedConvert(
          'headers',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Header>.fromJson(e)),
          ),
        ),
        style: $checkedConvert(
          'style',
          (v) => $enumDecodeNullable(_$ParameterStyleEnumMap, v),
        ),
        explode: $checkedConvert('explode', (v) => v as bool?),
        allowReserved: $checkedConvert(
          'allowReserved',
          (v) => v as bool? ?? false,
        ),
      );
      return val;
    });

Map<String, dynamic> _$EncodingToJson(Encoding instance) => <String, dynamic>{
  'contentType': ?instance.contentType,
  'headers': ?instance.headers?.map((k, e) => MapEntry(k, e.toJson())),
  'style': ?_$ParameterStyleEnumMap[instance.style],
  'explode': ?instance.explode,
  'allowReserved': instance.allowReserved,
};

const _$ParameterStyleEnumMap = {
  ParameterStyle.matrix: 'matrix',
  ParameterStyle.label: 'label',
  ParameterStyle.form: 'form',
  ParameterStyle.simple: 'simple',
  ParameterStyle.spaceDelimited: 'spaceDelimited',
  ParameterStyle.pipeDelimited: 'pipeDelimited',
  ParameterStyle.deepObject: 'deepObject',
};
