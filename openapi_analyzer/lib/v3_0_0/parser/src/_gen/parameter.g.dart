// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../parameter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ParameterCWProxy {
  Parameter name(String name);

  Parameter in_(ParameterLocation in_);

  Parameter description(String? description);

  Parameter required_(bool required_);

  Parameter deprecated(bool deprecated);

  Parameter allowEmptyValue(bool allowEmptyValue);

  Parameter style(ParameterStyle? style);

  Parameter explode(bool? explode);

  Parameter allowReserved(bool allowReserved);

  Parameter schema(Referenceable<SchemaObject>? schema);

  Parameter example(dynamic example);

  Parameter examples(Map<String, Referenceable<Example>>? examples);

  Parameter content(Map<String, MediaType>? content);

  Parameter extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Parameter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Parameter(...).copyWith(id: 12, name: "My name")
  /// ````
  Parameter call({
    String name,
    ParameterLocation in_,
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfParameter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfParameter.copyWith.fieldName(...)`
class _$ParameterCWProxyImpl implements _$ParameterCWProxy {
  const _$ParameterCWProxyImpl(this._value);

  final Parameter _value;

  @override
  Parameter name(String name) => this(name: name);

  @override
  Parameter in_(ParameterLocation in_) => this(in_: in_);

  @override
  Parameter description(String? description) => this(description: description);

  @override
  Parameter required_(bool required_) => this(required_: required_);

  @override
  Parameter deprecated(bool deprecated) => this(deprecated: deprecated);

  @override
  Parameter allowEmptyValue(bool allowEmptyValue) =>
      this(allowEmptyValue: allowEmptyValue);

  @override
  Parameter style(ParameterStyle? style) => this(style: style);

  @override
  Parameter explode(bool? explode) => this(explode: explode);

  @override
  Parameter allowReserved(bool allowReserved) =>
      this(allowReserved: allowReserved);

  @override
  Parameter schema(Referenceable<SchemaObject>? schema) => this(schema: schema);

  @override
  Parameter example(dynamic example) => this(example: example);

  @override
  Parameter examples(Map<String, Referenceable<Example>>? examples) =>
      this(examples: examples);

  @override
  Parameter content(Map<String, MediaType>? content) => this(content: content);

  @override
  Parameter extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Parameter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Parameter(...).copyWith(id: 12, name: "My name")
  /// ````
  Parameter call({
    Object? name = const $CopyWithPlaceholder(),
    Object? in_ = const $CopyWithPlaceholder(),
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
    return Parameter(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      in_: in_ == const $CopyWithPlaceholder()
          ? _value.in_
          // ignore: cast_nullable_to_non_nullable
          : in_ as ParameterLocation,
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

extension $ParameterCopyWith on Parameter {
  /// Returns a callable class that can be used as follows: `instanceOfParameter.copyWith(...)` or like so:`instanceOfParameter.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ParameterCWProxy get copyWith => _$ParameterCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parameter _$ParameterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Parameter', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'name',
          'in',
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
      final val = Parameter(
        name: $checkedConvert('name', (v) => v as String),
        in_: $checkedConvert(
          'in',
          (v) => $enumDecode(_$ParameterLocationEnumMap, v),
        ),
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
    }, fieldKeyMap: const {'in_': 'in', 'required_': 'required'});

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
  'name': instance.name,
  'in': _$ParameterLocationEnumMap[instance.in_]!,
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

const _$ParameterLocationEnumMap = {
  ParameterLocation.query: 'query',
  ParameterLocation.header: 'header',
  ParameterLocation.path: 'path',
  ParameterLocation.cookie: 'cookie',
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
