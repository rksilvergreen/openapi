// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../raw_schema.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RawSchemaCWProxy {
  RawSchema title(String? title);

  RawSchema description(String? description);

  RawSchema default_(dynamic default_);

  RawSchema type(String? type);

  RawSchema format(String? format);

  RawSchema multipleOf(num? multipleOf);

  RawSchema maximum(num? maximum);

  RawSchema exclusiveMaximum(num? exclusiveMaximum);

  RawSchema minimum(num? minimum);

  RawSchema exclusiveMinimum(num? exclusiveMinimum);

  RawSchema maxLength(int? maxLength);

  RawSchema minLength(int? minLength);

  RawSchema pattern(String? pattern);

  RawSchema maxItems(int? maxItems);

  RawSchema minItems(int? minItems);

  RawSchema uniqueItems(bool uniqueItems);

  RawSchema items(Map<String, dynamic>? items);

  RawSchema maxProperties(int? maxProperties);

  RawSchema minProperties(int? minProperties);

  RawSchema required_(List<String>? required_);

  RawSchema properties(Map<String, dynamic>? properties);

  RawSchema patternProperties(Map<String, dynamic>? patternProperties);

  RawSchema additionalProperties(dynamic additionalProperties);

  RawSchema allOf(List<Map<String, dynamic>>? allOf);

  RawSchema oneOf(List<Map<String, dynamic>>? oneOf);

  RawSchema anyOf(List<Map<String, dynamic>>? anyOf);

  RawSchema not(Map<String, dynamic>? not);

  RawSchema enum_(List<dynamic>? enum_);

  RawSchema nullable(bool nullable);

  RawSchema discriminator(Map<String, dynamic>? discriminator);

  RawSchema readOnly(bool readOnly);

  RawSchema writeOnly(bool writeOnly);

  RawSchema xml(Map<String, dynamic>? xml);

  RawSchema externalDocs(Map<String, dynamic>? externalDocs);

  RawSchema example(dynamic example);

  RawSchema deprecated(bool deprecated);

  RawSchema extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RawSchema(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RawSchema(...).copyWith(id: 12, name: "My name")
  /// ````
  RawSchema call({
    String? title,
    String? description,
    dynamic default_,
    String? type,
    String? format,
    num? multipleOf,
    num? maximum,
    num? exclusiveMaximum,
    num? minimum,
    num? exclusiveMinimum,
    int? maxLength,
    int? minLength,
    String? pattern,
    int? maxItems,
    int? minItems,
    bool uniqueItems,
    Map<String, dynamic>? items,
    int? maxProperties,
    int? minProperties,
    List<String>? required_,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? patternProperties,
    dynamic additionalProperties,
    List<Map<String, dynamic>>? allOf,
    List<Map<String, dynamic>>? oneOf,
    List<Map<String, dynamic>>? anyOf,
    Map<String, dynamic>? not,
    List<dynamic>? enum_,
    bool nullable,
    Map<String, dynamic>? discriminator,
    bool readOnly,
    bool writeOnly,
    Map<String, dynamic>? xml,
    Map<String, dynamic>? externalDocs,
    dynamic example,
    bool deprecated,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRawSchema.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRawSchema.copyWith.fieldName(...)`
class _$RawSchemaCWProxyImpl implements _$RawSchemaCWProxy {
  const _$RawSchemaCWProxyImpl(this._value);

  final RawSchema _value;

  @override
  RawSchema title(String? title) => this(title: title);

  @override
  RawSchema description(String? description) => this(description: description);

  @override
  RawSchema default_(dynamic default_) => this(default_: default_);

  @override
  RawSchema type(String? type) => this(type: type);

  @override
  RawSchema format(String? format) => this(format: format);

  @override
  RawSchema multipleOf(num? multipleOf) => this(multipleOf: multipleOf);

  @override
  RawSchema maximum(num? maximum) => this(maximum: maximum);

  @override
  RawSchema exclusiveMaximum(num? exclusiveMaximum) =>
      this(exclusiveMaximum: exclusiveMaximum);

  @override
  RawSchema minimum(num? minimum) => this(minimum: minimum);

  @override
  RawSchema exclusiveMinimum(num? exclusiveMinimum) =>
      this(exclusiveMinimum: exclusiveMinimum);

  @override
  RawSchema maxLength(int? maxLength) => this(maxLength: maxLength);

  @override
  RawSchema minLength(int? minLength) => this(minLength: minLength);

  @override
  RawSchema pattern(String? pattern) => this(pattern: pattern);

  @override
  RawSchema maxItems(int? maxItems) => this(maxItems: maxItems);

  @override
  RawSchema minItems(int? minItems) => this(minItems: minItems);

  @override
  RawSchema uniqueItems(bool uniqueItems) => this(uniqueItems: uniqueItems);

  @override
  RawSchema items(Map<String, dynamic>? items) => this(items: items);

  @override
  RawSchema maxProperties(int? maxProperties) =>
      this(maxProperties: maxProperties);

  @override
  RawSchema minProperties(int? minProperties) =>
      this(minProperties: minProperties);

  @override
  RawSchema required_(List<String>? required_) => this(required_: required_);

  @override
  RawSchema properties(Map<String, dynamic>? properties) =>
      this(properties: properties);

  @override
  RawSchema patternProperties(Map<String, dynamic>? patternProperties) =>
      this(patternProperties: patternProperties);

  @override
  RawSchema additionalProperties(dynamic additionalProperties) =>
      this(additionalProperties: additionalProperties);

  @override
  RawSchema allOf(List<Map<String, dynamic>>? allOf) => this(allOf: allOf);

  @override
  RawSchema oneOf(List<Map<String, dynamic>>? oneOf) => this(oneOf: oneOf);

  @override
  RawSchema anyOf(List<Map<String, dynamic>>? anyOf) => this(anyOf: anyOf);

  @override
  RawSchema not(Map<String, dynamic>? not) => this(not: not);

  @override
  RawSchema enum_(List<dynamic>? enum_) => this(enum_: enum_);

  @override
  RawSchema nullable(bool nullable) => this(nullable: nullable);

  @override
  RawSchema discriminator(Map<String, dynamic>? discriminator) =>
      this(discriminator: discriminator);

  @override
  RawSchema readOnly(bool readOnly) => this(readOnly: readOnly);

  @override
  RawSchema writeOnly(bool writeOnly) => this(writeOnly: writeOnly);

  @override
  RawSchema xml(Map<String, dynamic>? xml) => this(xml: xml);

  @override
  RawSchema externalDocs(Map<String, dynamic>? externalDocs) =>
      this(externalDocs: externalDocs);

  @override
  RawSchema example(dynamic example) => this(example: example);

  @override
  RawSchema deprecated(bool deprecated) => this(deprecated: deprecated);

  @override
  RawSchema extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RawSchema(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RawSchema(...).copyWith(id: 12, name: "My name")
  /// ````
  RawSchema call({
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? default_ = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? format = const $CopyWithPlaceholder(),
    Object? multipleOf = const $CopyWithPlaceholder(),
    Object? maximum = const $CopyWithPlaceholder(),
    Object? exclusiveMaximum = const $CopyWithPlaceholder(),
    Object? minimum = const $CopyWithPlaceholder(),
    Object? exclusiveMinimum = const $CopyWithPlaceholder(),
    Object? maxLength = const $CopyWithPlaceholder(),
    Object? minLength = const $CopyWithPlaceholder(),
    Object? pattern = const $CopyWithPlaceholder(),
    Object? maxItems = const $CopyWithPlaceholder(),
    Object? minItems = const $CopyWithPlaceholder(),
    Object? uniqueItems = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? maxProperties = const $CopyWithPlaceholder(),
    Object? minProperties = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? properties = const $CopyWithPlaceholder(),
    Object? patternProperties = const $CopyWithPlaceholder(),
    Object? additionalProperties = const $CopyWithPlaceholder(),
    Object? allOf = const $CopyWithPlaceholder(),
    Object? oneOf = const $CopyWithPlaceholder(),
    Object? anyOf = const $CopyWithPlaceholder(),
    Object? not = const $CopyWithPlaceholder(),
    Object? enum_ = const $CopyWithPlaceholder(),
    Object? nullable = const $CopyWithPlaceholder(),
    Object? discriminator = const $CopyWithPlaceholder(),
    Object? readOnly = const $CopyWithPlaceholder(),
    Object? writeOnly = const $CopyWithPlaceholder(),
    Object? xml = const $CopyWithPlaceholder(),
    Object? externalDocs = const $CopyWithPlaceholder(),
    Object? example = const $CopyWithPlaceholder(),
    Object? deprecated = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return RawSchema(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      default_: default_ == const $CopyWithPlaceholder()
          ? _value.default_
          // ignore: cast_nullable_to_non_nullable
          : default_ as dynamic,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String?,
      format: format == const $CopyWithPlaceholder()
          ? _value.format
          // ignore: cast_nullable_to_non_nullable
          : format as String?,
      multipleOf: multipleOf == const $CopyWithPlaceholder()
          ? _value.multipleOf
          // ignore: cast_nullable_to_non_nullable
          : multipleOf as num?,
      maximum: maximum == const $CopyWithPlaceholder()
          ? _value.maximum
          // ignore: cast_nullable_to_non_nullable
          : maximum as num?,
      exclusiveMaximum: exclusiveMaximum == const $CopyWithPlaceholder()
          ? _value.exclusiveMaximum
          // ignore: cast_nullable_to_non_nullable
          : exclusiveMaximum as num?,
      minimum: minimum == const $CopyWithPlaceholder()
          ? _value.minimum
          // ignore: cast_nullable_to_non_nullable
          : minimum as num?,
      exclusiveMinimum: exclusiveMinimum == const $CopyWithPlaceholder()
          ? _value.exclusiveMinimum
          // ignore: cast_nullable_to_non_nullable
          : exclusiveMinimum as num?,
      maxLength: maxLength == const $CopyWithPlaceholder()
          ? _value.maxLength
          // ignore: cast_nullable_to_non_nullable
          : maxLength as int?,
      minLength: minLength == const $CopyWithPlaceholder()
          ? _value.minLength
          // ignore: cast_nullable_to_non_nullable
          : minLength as int?,
      pattern: pattern == const $CopyWithPlaceholder()
          ? _value.pattern
          // ignore: cast_nullable_to_non_nullable
          : pattern as String?,
      maxItems: maxItems == const $CopyWithPlaceholder()
          ? _value.maxItems
          // ignore: cast_nullable_to_non_nullable
          : maxItems as int?,
      minItems: minItems == const $CopyWithPlaceholder()
          ? _value.minItems
          // ignore: cast_nullable_to_non_nullable
          : minItems as int?,
      uniqueItems: uniqueItems == const $CopyWithPlaceholder()
          ? _value.uniqueItems
          // ignore: cast_nullable_to_non_nullable
          : uniqueItems as bool,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as Map<String, dynamic>?,
      maxProperties: maxProperties == const $CopyWithPlaceholder()
          ? _value.maxProperties
          // ignore: cast_nullable_to_non_nullable
          : maxProperties as int?,
      minProperties: minProperties == const $CopyWithPlaceholder()
          ? _value.minProperties
          // ignore: cast_nullable_to_non_nullable
          : minProperties as int?,
      required_: required_ == const $CopyWithPlaceholder()
          ? _value.required_
          // ignore: cast_nullable_to_non_nullable
          : required_ as List<String>?,
      properties: properties == const $CopyWithPlaceholder()
          ? _value.properties
          // ignore: cast_nullable_to_non_nullable
          : properties as Map<String, dynamic>?,
      patternProperties: patternProperties == const $CopyWithPlaceholder()
          ? _value.patternProperties
          // ignore: cast_nullable_to_non_nullable
          : patternProperties as Map<String, dynamic>?,
      additionalProperties: additionalProperties == const $CopyWithPlaceholder()
          ? _value.additionalProperties
          // ignore: cast_nullable_to_non_nullable
          : additionalProperties as dynamic,
      allOf: allOf == const $CopyWithPlaceholder()
          ? _value.allOf
          // ignore: cast_nullable_to_non_nullable
          : allOf as List<Map<String, dynamic>>?,
      oneOf: oneOf == const $CopyWithPlaceholder()
          ? _value.oneOf
          // ignore: cast_nullable_to_non_nullable
          : oneOf as List<Map<String, dynamic>>?,
      anyOf: anyOf == const $CopyWithPlaceholder()
          ? _value.anyOf
          // ignore: cast_nullable_to_non_nullable
          : anyOf as List<Map<String, dynamic>>?,
      not: not == const $CopyWithPlaceholder()
          ? _value.not
          // ignore: cast_nullable_to_non_nullable
          : not as Map<String, dynamic>?,
      enum_: enum_ == const $CopyWithPlaceholder()
          ? _value.enum_
          // ignore: cast_nullable_to_non_nullable
          : enum_ as List<dynamic>?,
      nullable: nullable == const $CopyWithPlaceholder()
          ? _value.nullable
          // ignore: cast_nullable_to_non_nullable
          : nullable as bool,
      discriminator: discriminator == const $CopyWithPlaceholder()
          ? _value.discriminator
          // ignore: cast_nullable_to_non_nullable
          : discriminator as Map<String, dynamic>?,
      readOnly: readOnly == const $CopyWithPlaceholder()
          ? _value.readOnly
          // ignore: cast_nullable_to_non_nullable
          : readOnly as bool,
      writeOnly: writeOnly == const $CopyWithPlaceholder()
          ? _value.writeOnly
          // ignore: cast_nullable_to_non_nullable
          : writeOnly as bool,
      xml: xml == const $CopyWithPlaceholder()
          ? _value.xml
          // ignore: cast_nullable_to_non_nullable
          : xml as Map<String, dynamic>?,
      externalDocs: externalDocs == const $CopyWithPlaceholder()
          ? _value.externalDocs
          // ignore: cast_nullable_to_non_nullable
          : externalDocs as Map<String, dynamic>?,
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      deprecated: deprecated == const $CopyWithPlaceholder()
          ? _value.deprecated
          // ignore: cast_nullable_to_non_nullable
          : deprecated as bool,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $RawSchemaCopyWith on RawSchema {
  /// Returns a callable class that can be used as follows: `instanceOfRawSchema.copyWith(...)` or like so:`instanceOfRawSchema.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RawSchemaCWProxy get copyWith => _$RawSchemaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawSchema _$RawSchemaFromJson(Map<String, dynamic> json) => $checkedCreate(
  'RawSchema',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'title',
        'description',
        'default',
        'type',
        'format',
        'multipleOf',
        'maximum',
        'exclusiveMaximum',
        'minimum',
        'exclusiveMinimum',
        'maxLength',
        'minLength',
        'pattern',
        'maxItems',
        'minItems',
        'uniqueItems',
        'items',
        'maxProperties',
        'minProperties',
        'required',
        'properties',
        'patternProperties',
        'additionalProperties',
        'allOf',
        'oneOf',
        'anyOf',
        'not',
        'enum',
        'nullable',
        'discriminator',
        'readOnly',
        'writeOnly',
        'xml',
        'externalDocs',
        'example',
        'deprecated',
      ],
    );
    final val = RawSchema(
      title: $checkedConvert('title', (v) => v as String?),
      description: $checkedConvert('description', (v) => v as String?),
      default_: $checkedConvert('default', (v) => v),
      type: $checkedConvert('type', (v) => v as String?),
      format: $checkedConvert('format', (v) => v as String?),
      multipleOf: $checkedConvert('multipleOf', (v) => v as num?),
      maximum: $checkedConvert('maximum', (v) => v as num?),
      exclusiveMaximum: $checkedConvert('exclusiveMaximum', (v) => v as num?),
      minimum: $checkedConvert('minimum', (v) => v as num?),
      exclusiveMinimum: $checkedConvert('exclusiveMinimum', (v) => v as num?),
      maxLength: $checkedConvert('maxLength', (v) => (v as num?)?.toInt()),
      minLength: $checkedConvert('minLength', (v) => (v as num?)?.toInt()),
      pattern: $checkedConvert('pattern', (v) => v as String?),
      maxItems: $checkedConvert('maxItems', (v) => (v as num?)?.toInt()),
      minItems: $checkedConvert('minItems', (v) => (v as num?)?.toInt()),
      uniqueItems: $checkedConvert('uniqueItems', (v) => v as bool? ?? false),
      items: $checkedConvert('items', (v) => v as Map<String, dynamic>?),
      maxProperties: $checkedConvert(
        'maxProperties',
        (v) => (v as num?)?.toInt(),
      ),
      minProperties: $checkedConvert(
        'minProperties',
        (v) => (v as num?)?.toInt(),
      ),
      required_: $checkedConvert(
        'required',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      properties: $checkedConvert(
        'properties',
        (v) => v as Map<String, dynamic>?,
      ),
      patternProperties: $checkedConvert(
        'patternProperties',
        (v) => v as Map<String, dynamic>?,
      ),
      additionalProperties: $checkedConvert('additionalProperties', (v) => v),
      allOf: $checkedConvert(
        'allOf',
        (v) => (v as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList(),
      ),
      oneOf: $checkedConvert(
        'oneOf',
        (v) => (v as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList(),
      ),
      anyOf: $checkedConvert(
        'anyOf',
        (v) => (v as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList(),
      ),
      not: $checkedConvert('not', (v) => v as Map<String, dynamic>?),
      enum_: $checkedConvert('enum', (v) => v as List<dynamic>?),
      nullable: $checkedConvert('nullable', (v) => v as bool? ?? false),
      discriminator: $checkedConvert(
        'discriminator',
        (v) => v as Map<String, dynamic>?,
      ),
      readOnly: $checkedConvert('readOnly', (v) => v as bool? ?? false),
      writeOnly: $checkedConvert('writeOnly', (v) => v as bool? ?? false),
      xml: $checkedConvert('xml', (v) => v as Map<String, dynamic>?),
      externalDocs: $checkedConvert(
        'externalDocs',
        (v) => v as Map<String, dynamic>?,
      ),
      example: $checkedConvert('example', (v) => v),
      deprecated: $checkedConvert('deprecated', (v) => v as bool? ?? false),
    );
    return val;
  },
  fieldKeyMap: const {
    'default_': 'default',
    'required_': 'required',
    'enum_': 'enum',
  },
);

Map<String, dynamic> _$RawSchemaToJson(RawSchema instance) => <String, dynamic>{
  'title': ?instance.title,
  'description': ?instance.description,
  'default': ?instance.default_,
  'type': ?instance.type,
  'format': ?instance.format,
  'multipleOf': ?instance.multipleOf,
  'maximum': ?instance.maximum,
  'exclusiveMaximum': ?instance.exclusiveMaximum,
  'minimum': ?instance.minimum,
  'exclusiveMinimum': ?instance.exclusiveMinimum,
  'maxLength': ?instance.maxLength,
  'minLength': ?instance.minLength,
  'pattern': ?instance.pattern,
  'maxItems': ?instance.maxItems,
  'minItems': ?instance.minItems,
  'uniqueItems': instance.uniqueItems,
  'items': ?instance.items,
  'maxProperties': ?instance.maxProperties,
  'minProperties': ?instance.minProperties,
  'required': ?instance.required_,
  'properties': ?instance.properties,
  'patternProperties': ?instance.patternProperties,
  'additionalProperties': ?instance.additionalProperties,
  'allOf': ?instance.allOf,
  'oneOf': ?instance.oneOf,
  'anyOf': ?instance.anyOf,
  'not': ?instance.not,
  'enum': ?instance.enum_,
  'nullable': instance.nullable,
  'discriminator': ?instance.discriminator,
  'readOnly': instance.readOnly,
  'writeOnly': instance.writeOnly,
  'xml': ?instance.xml,
  'externalDocs': ?instance.externalDocs,
  'example': ?instance.example,
  'deprecated': instance.deprecated,
};
