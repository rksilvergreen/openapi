import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'raw_schema/_gen/raw_schema.g.dart';

/// Schema Object - an extended subset of JSON Schema.
@CopyWith()
@JsonSerializable()
class RawSchema {
  // JSON Schema Core keywords
  final String? title;
  final String? description;
  @JsonKey(name: 'default')
  final dynamic default_;

  // Type and format
  final String? type;
  final String? format;

  // Numeric validations
  final num? multipleOf;
  final num? maximum;
  final num? exclusiveMaximum;
  final num? minimum;
  final num? exclusiveMinimum;

  // String validations
  final int? maxLength;
  final int? minLength;
  final String? pattern;

  // Array validations
  final int? maxItems;
  final int? minItems;
  final bool uniqueItems;
  final Map<String, dynamic>? items;

  // Object validations
  final int? maxProperties;
  final int? minProperties;
  @JsonKey(name: 'required')
  final List<String>? required_;
  final Map<String, dynamic>? properties;
  final Map<String, dynamic>? patternProperties;
  final dynamic additionalProperties; // bool or SchemaObject

  // Composition
  final List<Map<String, dynamic>>? allOf;
  final List<Map<String, dynamic>>? oneOf;
  final List<Map<String, dynamic>>? anyOf;
  final Map<String, dynamic>? not;
  // Generic
  @JsonKey(name: 'enum')
  final List<dynamic>? enum_;

  // OpenAPI-specific
  final bool nullable;
  final Map<String, dynamic>? discriminator;
  final bool readOnly;
  final bool writeOnly;
  final Map<String, dynamic>? xml;
  final Map<String, dynamic>? externalDocs;
  final dynamic example;
  final bool deprecated;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  RawSchema({
    this.title,
    this.description,
    this.default_,
    this.type,
    this.format,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.maxItems,
    this.minItems,
    this.uniqueItems = false,
    this.items,
    this.maxProperties,
    this.minProperties,
    this.required_,
    this.properties,
    this.patternProperties,
    this.additionalProperties,
    this.allOf,
    this.oneOf,
    this.anyOf,
    this.not,
    this.enum_,
    this.nullable = false,
    this.discriminator,
    this.readOnly = false,
    this.writeOnly = false,
    this.xml,
    this.externalDocs,
    this.example,
    this.deprecated = false,
    this.extensions,
  });

  factory RawSchema.fromJson(Map<String, dynamic> json) {
    final extensions = OpenapiObject.extractExtensions(json);
    final schema = _$RawSchemaFromJson(OpenapiObject.jsonWithoutExtensions(json));
    return schema.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() => _$RawSchemaToJson(this);
}