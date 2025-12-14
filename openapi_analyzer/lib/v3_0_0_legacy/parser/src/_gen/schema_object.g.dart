// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../schema_object.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SchemaObjectCWProxy {
  SchemaObject ref(String? ref);

  SchemaObject title(String? title);

  SchemaObject description(String? description);

  SchemaObject default_(dynamic default_);

  SchemaObject type(SchemaType? type);

  SchemaObject format(String? format);

  SchemaObject multipleOf(num? multipleOf);

  SchemaObject maximum(num? maximum);

  SchemaObject exclusiveMaximum(num? exclusiveMaximum);

  SchemaObject minimum(num? minimum);

  SchemaObject exclusiveMinimum(num? exclusiveMinimum);

  SchemaObject maxLength(int? maxLength);

  SchemaObject minLength(int? minLength);

  SchemaObject pattern(String? pattern);

  SchemaObject maxItems(int? maxItems);

  SchemaObject minItems(int? minItems);

  SchemaObject uniqueItems(bool uniqueItems);

  SchemaObject items(Referenceable<SchemaObject>? items);

  SchemaObject maxProperties(int? maxProperties);

  SchemaObject minProperties(int? minProperties);

  SchemaObject required_(List<String>? required_);

  SchemaObject properties(Map<String, Referenceable<SchemaObject>>? properties);

  SchemaObject patternProperties(
    Map<String, Referenceable<SchemaObject>>? patternProperties,
  );

  SchemaObject additionalProperties(dynamic additionalProperties);

  SchemaObject allOf(List<Referenceable<SchemaObject>>? allOf);

  SchemaObject oneOf(List<Referenceable<SchemaObject>>? oneOf);

  SchemaObject anyOf(List<Referenceable<SchemaObject>>? anyOf);

  SchemaObject not(Referenceable<SchemaObject>? not);

  SchemaObject if_(Referenceable<SchemaObject>? if_);

  SchemaObject then(Referenceable<SchemaObject>? then);

  SchemaObject else_(Referenceable<SchemaObject>? else_);

  SchemaObject enum_(List<dynamic>? enum_);

  SchemaObject const_(dynamic const_);

  SchemaObject nullable(bool nullable);

  SchemaObject discriminator(Discriminator? discriminator);

  SchemaObject readOnly(bool readOnly);

  SchemaObject writeOnly(bool writeOnly);

  SchemaObject xml(XML? xml);

  SchemaObject externalDocs(ExternalDocumentation? externalDocs);

  SchemaObject example(dynamic example);

  SchemaObject deprecated(bool deprecated);

  SchemaObject extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SchemaObject(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SchemaObject(...).copyWith(id: 12, name: "My name")
  /// ````
  SchemaObject call({
    String? ref,
    String? title,
    String? description,
    dynamic default_,
    SchemaType? type,
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
    Referenceable<SchemaObject>? items,
    int? maxProperties,
    int? minProperties,
    List<String>? required_,
    Map<String, Referenceable<SchemaObject>>? properties,
    Map<String, Referenceable<SchemaObject>>? patternProperties,
    dynamic additionalProperties,
    List<Referenceable<SchemaObject>>? allOf,
    List<Referenceable<SchemaObject>>? oneOf,
    List<Referenceable<SchemaObject>>? anyOf,
    Referenceable<SchemaObject>? not,
    Referenceable<SchemaObject>? if_,
    Referenceable<SchemaObject>? then,
    Referenceable<SchemaObject>? else_,
    List<dynamic>? enum_,
    dynamic const_,
    bool nullable,
    Discriminator? discriminator,
    bool readOnly,
    bool writeOnly,
    XML? xml,
    ExternalDocumentation? externalDocs,
    dynamic example,
    bool deprecated,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSchemaObject.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSchemaObject.copyWith.fieldName(...)`
class _$SchemaObjectCWProxyImpl implements _$SchemaObjectCWProxy {
  const _$SchemaObjectCWProxyImpl(this._value);

  final SchemaObject _value;

  @override
  SchemaObject ref(String? ref) => this(ref: ref);

  @override
  SchemaObject title(String? title) => this(title: title);

  @override
  SchemaObject description(String? description) =>
      this(description: description);

  @override
  SchemaObject default_(dynamic default_) => this(default_: default_);

  @override
  SchemaObject type(SchemaType? type) => this(type: type);

  @override
  SchemaObject format(String? format) => this(format: format);

  @override
  SchemaObject multipleOf(num? multipleOf) => this(multipleOf: multipleOf);

  @override
  SchemaObject maximum(num? maximum) => this(maximum: maximum);

  @override
  SchemaObject exclusiveMaximum(num? exclusiveMaximum) =>
      this(exclusiveMaximum: exclusiveMaximum);

  @override
  SchemaObject minimum(num? minimum) => this(minimum: minimum);

  @override
  SchemaObject exclusiveMinimum(num? exclusiveMinimum) =>
      this(exclusiveMinimum: exclusiveMinimum);

  @override
  SchemaObject maxLength(int? maxLength) => this(maxLength: maxLength);

  @override
  SchemaObject minLength(int? minLength) => this(minLength: minLength);

  @override
  SchemaObject pattern(String? pattern) => this(pattern: pattern);

  @override
  SchemaObject maxItems(int? maxItems) => this(maxItems: maxItems);

  @override
  SchemaObject minItems(int? minItems) => this(minItems: minItems);

  @override
  SchemaObject uniqueItems(bool uniqueItems) => this(uniqueItems: uniqueItems);

  @override
  SchemaObject items(Referenceable<SchemaObject>? items) => this(items: items);

  @override
  SchemaObject maxProperties(int? maxProperties) =>
      this(maxProperties: maxProperties);

  @override
  SchemaObject minProperties(int? minProperties) =>
      this(minProperties: minProperties);

  @override
  SchemaObject required_(List<String>? required_) => this(required_: required_);

  @override
  SchemaObject properties(
    Map<String, Referenceable<SchemaObject>>? properties,
  ) => this(properties: properties);

  @override
  SchemaObject patternProperties(
    Map<String, Referenceable<SchemaObject>>? patternProperties,
  ) => this(patternProperties: patternProperties);

  @override
  SchemaObject additionalProperties(dynamic additionalProperties) =>
      this(additionalProperties: additionalProperties);

  @override
  SchemaObject allOf(List<Referenceable<SchemaObject>>? allOf) =>
      this(allOf: allOf);

  @override
  SchemaObject oneOf(List<Referenceable<SchemaObject>>? oneOf) =>
      this(oneOf: oneOf);

  @override
  SchemaObject anyOf(List<Referenceable<SchemaObject>>? anyOf) =>
      this(anyOf: anyOf);

  @override
  SchemaObject not(Referenceable<SchemaObject>? not) => this(not: not);

  @override
  SchemaObject if_(Referenceable<SchemaObject>? if_) => this(if_: if_);

  @override
  SchemaObject then(Referenceable<SchemaObject>? then) => this(then: then);

  @override
  SchemaObject else_(Referenceable<SchemaObject>? else_) => this(else_: else_);

  @override
  SchemaObject enum_(List<dynamic>? enum_) => this(enum_: enum_);

  @override
  SchemaObject const_(dynamic const_) => this(const_: const_);

  @override
  SchemaObject nullable(bool nullable) => this(nullable: nullable);

  @override
  SchemaObject discriminator(Discriminator? discriminator) =>
      this(discriminator: discriminator);

  @override
  SchemaObject readOnly(bool readOnly) => this(readOnly: readOnly);

  @override
  SchemaObject writeOnly(bool writeOnly) => this(writeOnly: writeOnly);

  @override
  SchemaObject xml(XML? xml) => this(xml: xml);

  @override
  SchemaObject externalDocs(ExternalDocumentation? externalDocs) =>
      this(externalDocs: externalDocs);

  @override
  SchemaObject example(dynamic example) => this(example: example);

  @override
  SchemaObject deprecated(bool deprecated) => this(deprecated: deprecated);

  @override
  SchemaObject extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SchemaObject(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SchemaObject(...).copyWith(id: 12, name: "My name")
  /// ````
  SchemaObject call({
    Object? ref = const $CopyWithPlaceholder(),
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
    Object? if_ = const $CopyWithPlaceholder(),
    Object? then = const $CopyWithPlaceholder(),
    Object? else_ = const $CopyWithPlaceholder(),
    Object? enum_ = const $CopyWithPlaceholder(),
    Object? const_ = const $CopyWithPlaceholder(),
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
    return SchemaObject(
      ref: ref == const $CopyWithPlaceholder()
          ? _value.ref
          // ignore: cast_nullable_to_non_nullable
          : ref as String?,
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
          : type as SchemaType?,
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
          : items as Referenceable<SchemaObject>?,
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
          : properties as Map<String, Referenceable<SchemaObject>>?,
      patternProperties: patternProperties == const $CopyWithPlaceholder()
          ? _value.patternProperties
          // ignore: cast_nullable_to_non_nullable
          : patternProperties as Map<String, Referenceable<SchemaObject>>?,
      additionalProperties: additionalProperties == const $CopyWithPlaceholder()
          ? _value.additionalProperties
          // ignore: cast_nullable_to_non_nullable
          : additionalProperties as dynamic,
      allOf: allOf == const $CopyWithPlaceholder()
          ? _value.allOf
          // ignore: cast_nullable_to_non_nullable
          : allOf as List<Referenceable<SchemaObject>>?,
      oneOf: oneOf == const $CopyWithPlaceholder()
          ? _value.oneOf
          // ignore: cast_nullable_to_non_nullable
          : oneOf as List<Referenceable<SchemaObject>>?,
      anyOf: anyOf == const $CopyWithPlaceholder()
          ? _value.anyOf
          // ignore: cast_nullable_to_non_nullable
          : anyOf as List<Referenceable<SchemaObject>>?,
      not: not == const $CopyWithPlaceholder()
          ? _value.not
          // ignore: cast_nullable_to_non_nullable
          : not as Referenceable<SchemaObject>?,
      if_: if_ == const $CopyWithPlaceholder()
          ? _value.if_
          // ignore: cast_nullable_to_non_nullable
          : if_ as Referenceable<SchemaObject>?,
      then: then == const $CopyWithPlaceholder()
          ? _value.then
          // ignore: cast_nullable_to_non_nullable
          : then as Referenceable<SchemaObject>?,
      else_: else_ == const $CopyWithPlaceholder()
          ? _value.else_
          // ignore: cast_nullable_to_non_nullable
          : else_ as Referenceable<SchemaObject>?,
      enum_: enum_ == const $CopyWithPlaceholder()
          ? _value.enum_
          // ignore: cast_nullable_to_non_nullable
          : enum_ as List<dynamic>?,
      const_: const_ == const $CopyWithPlaceholder()
          ? _value.const_
          // ignore: cast_nullable_to_non_nullable
          : const_ as dynamic,
      nullable: nullable == const $CopyWithPlaceholder()
          ? _value.nullable
          // ignore: cast_nullable_to_non_nullable
          : nullable as bool,
      discriminator: discriminator == const $CopyWithPlaceholder()
          ? _value.discriminator
          // ignore: cast_nullable_to_non_nullable
          : discriminator as Discriminator?,
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
          : xml as XML?,
      externalDocs: externalDocs == const $CopyWithPlaceholder()
          ? _value.externalDocs
          // ignore: cast_nullable_to_non_nullable
          : externalDocs as ExternalDocumentation?,
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

extension $SchemaObjectCopyWith on SchemaObject {
  /// Returns a callable class that can be used as follows: `instanceOfSchemaObject.copyWith(...)` or like so:`instanceOfSchemaObject.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SchemaObjectCWProxy get copyWith => _$SchemaObjectCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemaObject _$SchemaObjectFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'SchemaObject',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        r'$ref',
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
        'if',
        'then',
        'else',
        'enum',
        'const',
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
    final val = SchemaObject(
      ref: $checkedConvert(r'$ref', (v) => v as String?),
      title: $checkedConvert('title', (v) => v as String?),
      description: $checkedConvert('description', (v) => v as String?),
      default_: $checkedConvert('default', (v) => v),
      type: $checkedConvert(
        'type',
        (v) => $enumDecodeNullable(_$SchemaTypeEnumMap, v),
      ),
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
      items: $checkedConvert(
        'items',
        (v) => v == null ? null : Referenceable<SchemaObject>.fromJson(v),
      ),
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
        (v) => (v as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, Referenceable<SchemaObject>.fromJson(e)),
        ),
      ),
      patternProperties: $checkedConvert(
        'patternProperties',
        (v) => (v as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, Referenceable<SchemaObject>.fromJson(e)),
        ),
      ),
      additionalProperties: $checkedConvert('additionalProperties', (v) => v),
      allOf: $checkedConvert(
        'allOf',
        (v) => (v as List<dynamic>?)
            ?.map(Referenceable<SchemaObject>.fromJson)
            .toList(),
      ),
      oneOf: $checkedConvert(
        'oneOf',
        (v) => (v as List<dynamic>?)
            ?.map(Referenceable<SchemaObject>.fromJson)
            .toList(),
      ),
      anyOf: $checkedConvert(
        'anyOf',
        (v) => (v as List<dynamic>?)
            ?.map(Referenceable<SchemaObject>.fromJson)
            .toList(),
      ),
      not: $checkedConvert(
        'not',
        (v) => v == null ? null : Referenceable<SchemaObject>.fromJson(v),
      ),
      if_: $checkedConvert(
        'if',
        (v) => v == null ? null : Referenceable<SchemaObject>.fromJson(v),
      ),
      then: $checkedConvert(
        'then',
        (v) => v == null ? null : Referenceable<SchemaObject>.fromJson(v),
      ),
      else_: $checkedConvert(
        'else',
        (v) => v == null ? null : Referenceable<SchemaObject>.fromJson(v),
      ),
      enum_: $checkedConvert('enum', (v) => v as List<dynamic>?),
      const_: $checkedConvert('const', (v) => v),
      nullable: $checkedConvert('nullable', (v) => v as bool? ?? false),
      discriminator: $checkedConvert(
        'discriminator',
        (v) => v == null
            ? null
            : Discriminator.fromJson(v as Map<String, dynamic>),
      ),
      readOnly: $checkedConvert('readOnly', (v) => v as bool? ?? false),
      writeOnly: $checkedConvert('writeOnly', (v) => v as bool? ?? false),
      xml: $checkedConvert(
        'xml',
        (v) => v == null ? null : XML.fromJson(v as Map<String, dynamic>),
      ),
      externalDocs: $checkedConvert(
        'externalDocs',
        (v) => v == null
            ? null
            : ExternalDocumentation.fromJson(v as Map<String, dynamic>),
      ),
      example: $checkedConvert('example', (v) => v),
      deprecated: $checkedConvert('deprecated', (v) => v as bool? ?? false),
    );
    return val;
  },
  fieldKeyMap: const {
    'ref': r'$ref',
    'default_': 'default',
    'required_': 'required',
    'if_': 'if',
    'else_': 'else',
    'enum_': 'enum',
    'const_': 'const',
  },
);

Map<String, dynamic> _$SchemaObjectToJson(
  SchemaObject instance,
) => <String, dynamic>{
  r'$ref': ?instance.ref,
  'title': ?instance.title,
  'description': ?instance.description,
  'default': ?instance.default_,
  'type': ?_$SchemaTypeEnumMap[instance.type],
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
  'items': ?instance.items?.toJson(),
  'maxProperties': ?instance.maxProperties,
  'minProperties': ?instance.minProperties,
  'required': ?instance.required_,
  'properties': ?instance.properties?.map((k, e) => MapEntry(k, e.toJson())),
  'patternProperties': ?instance.patternProperties?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'additionalProperties': ?instance.additionalProperties,
  'allOf': ?instance.allOf?.map((e) => e.toJson()).toList(),
  'oneOf': ?instance.oneOf?.map((e) => e.toJson()).toList(),
  'anyOf': ?instance.anyOf?.map((e) => e.toJson()).toList(),
  'not': ?instance.not?.toJson(),
  'if': ?instance.if_?.toJson(),
  'then': ?instance.then?.toJson(),
  'else': ?instance.else_?.toJson(),
  'enum': ?instance.enum_,
  'const': ?instance.const_,
  'nullable': instance.nullable,
  'discriminator': ?instance.discriminator?.toJson(),
  'readOnly': instance.readOnly,
  'writeOnly': instance.writeOnly,
  'xml': ?instance.xml?.toJson(),
  'externalDocs': ?instance.externalDocs?.toJson(),
  'example': ?instance.example,
  'deprecated': instance.deprecated,
};

const _$SchemaTypeEnumMap = {
  SchemaType.string: 'string',
  SchemaType.number: 'number',
  SchemaType.integer: 'integer',
  SchemaType.boolean: 'boolean',
  SchemaType.array: 'array',
  SchemaType.object: 'object',
  SchemaType.null_: 'null',
};
