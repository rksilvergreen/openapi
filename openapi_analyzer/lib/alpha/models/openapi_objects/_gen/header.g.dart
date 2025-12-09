// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../header.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HeaderCWProxy {
  Header description(String? description);

  Header required_(bool required_);

  Header deprecated(bool deprecated);

  Header allowEmptyValue(bool allowEmptyValue);

  Header style(ParameterStyle? style);

  Header explode(bool? explode);

  Header allowReserved(bool allowReserved);

  Header schema(Referenceable<SchemaObject>? schema);

  Header example(dynamic example);

  Header examples(Map<String, Referenceable<Example>>? examples);

  Header content(Map<String, MediaType>? content);

  Header extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Header(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Header(...).copyWith(id: 12, name: "My name")
  /// ````
  Header call({
    String? description,
    bool required_,
    bool deprecated,
    bool allowEmptyValue,
    ParameterStyle? style,
    bool? explode,
    bool allowReserved,
    Referenceable<SchemaObject>? schema,
    dynamic example,
    Map<String, Referenceable<Example>>? examples,
    Map<String, MediaType>? content,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHeader.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHeader.copyWith.fieldName(...)`
class _$HeaderCWProxyImpl implements _$HeaderCWProxy {
  const _$HeaderCWProxyImpl(this._value);

  final Header _value;

  @override
  Header description(String? description) => this(description: description);

  @override
  Header required_(bool required_) => this(required_: required_);

  @override
  Header deprecated(bool deprecated) => this(deprecated: deprecated);

  @override
  Header allowEmptyValue(bool allowEmptyValue) =>
      this(allowEmptyValue: allowEmptyValue);

  @override
  Header style(ParameterStyle? style) => this(style: style);

  @override
  Header explode(bool? explode) => this(explode: explode);

  @override
  Header allowReserved(bool allowReserved) =>
      this(allowReserved: allowReserved);

  @override
  Header schema(Referenceable<SchemaObject>? schema) => this(schema: schema);

  @override
  Header example(dynamic example) => this(example: example);

  @override
  Header examples(Map<String, Referenceable<Example>>? examples) =>
      this(examples: examples);

  @override
  Header content(Map<String, MediaType>? content) => this(content: content);

  @override
  Header extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Header(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Header(...).copyWith(id: 12, name: "My name")
  /// ````
  Header call({
    Object? description = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? deprecated = const $CopyWithPlaceholder(),
    Object? allowEmptyValue = const $CopyWithPlaceholder(),
    Object? style = const $CopyWithPlaceholder(),
    Object? explode = const $CopyWithPlaceholder(),
    Object? allowReserved = const $CopyWithPlaceholder(),
    Object? schema = const $CopyWithPlaceholder(),
    Object? example = const $CopyWithPlaceholder(),
    Object? examples = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Header(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      required_: required_ == const $CopyWithPlaceholder()
          ? _value.required_
          // ignore: cast_nullable_to_non_nullable
          : required_ as bool,
      deprecated: deprecated == const $CopyWithPlaceholder()
          ? _value.deprecated
          // ignore: cast_nullable_to_non_nullable
          : deprecated as bool,
      allowEmptyValue: allowEmptyValue == const $CopyWithPlaceholder()
          ? _value.allowEmptyValue
          // ignore: cast_nullable_to_non_nullable
          : allowEmptyValue as bool,
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
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as Map<String, MediaType>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $HeaderCopyWith on Header {
  /// Returns a callable class that can be used as follows: `instanceOfHeader.copyWith(...)` or like so:`instanceOfHeader.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HeaderCWProxy get copyWith => _$HeaderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Header _$HeaderFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Header', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'description',
          'required',
          'deprecated',
          'allowEmptyValue',
          'style',
          'explode',
          'allowReserved',
          'schema',
          'example',
          'examples',
          'content',
        ],
      );
      final val = Header(
        description: $checkedConvert('description', (v) => v as String?),
        required_: $checkedConvert('required', (v) => v as bool? ?? false),
        deprecated: $checkedConvert('deprecated', (v) => v as bool? ?? false),
        allowEmptyValue: $checkedConvert(
          'allowEmptyValue',
          (v) => v as bool? ?? false,
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
        content: $checkedConvert(
          'content',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, MediaType.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      );
      return val;
    }, fieldKeyMap: const {'required_': 'required'});

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
  'description': ?instance.description,
  'required': instance.required_,
  'deprecated': instance.deprecated,
  'allowEmptyValue': instance.allowEmptyValue,
  'style': ?_$ParameterStyleEnumMap[instance.style],
  'explode': ?instance.explode,
  'allowReserved': instance.allowReserved,
  'schema': ?instance.schema?.toJson(),
  'example': ?instance.example,
  'examples': ?instance.examples?.map((k, e) => MapEntry(k, e.toJson())),
  'content': ?instance.content?.map((k, e) => MapEntry(k, e.toJson())),
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
