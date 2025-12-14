import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'referenceable.dart';
import 'enums.dart';
import 'discriminator.dart';
import 'xml.dart';
import 'external_documentation.dart';
import 'json_helpers.dart';

part '_gen/schema_object.g.dart';

/// Schema Object - an extended subset of JSON Schema.
@CopyWith()
@JsonSerializable()
class SchemaObject implements OpenapiObject {
  // JSON Schema Core keywords
  @JsonKey(name: r'$ref')
  final String? ref;
  final String? title;
  final String? description;
  @JsonKey(name: 'default')
  final dynamic default_;

  // Type and format
  final SchemaType? type;
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
  final Referenceable<SchemaObject>? items;

  // Object validations
  final int? maxProperties;
  final int? minProperties;
  @JsonKey(name: 'required')
  final List<String>? required_;
  final Map<String, Referenceable<SchemaObject>>? properties;
  final Map<String, Referenceable<SchemaObject>>? patternProperties;
  final dynamic additionalProperties; // bool or SchemaObject

  // Composition
  final List<Referenceable<SchemaObject>>? allOf;
  final List<Referenceable<SchemaObject>>? oneOf;
  final List<Referenceable<SchemaObject>>? anyOf;
  final Referenceable<SchemaObject>? not;

  @JsonKey(name: 'if')
  final Referenceable<SchemaObject>? if_;
  final Referenceable<SchemaObject>? then;
  @JsonKey(name: 'else')
  final Referenceable<SchemaObject>? else_;

  // Generic
  @JsonKey(name: 'enum')
  final List<dynamic>? enum_;
  @JsonKey(name: 'const')
  final dynamic const_;

  // OpenAPI-specific
  final bool nullable;
  final Discriminator? discriminator;
  final bool readOnly;
  final bool writeOnly;
  final XML? xml;
  final ExternalDocumentation? externalDocs;
  final dynamic example;
  final bool deprecated;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  SchemaObject({
    this.ref,
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
    this.if_,
    this.then,
    this.else_,
    this.enum_,
    this.const_,
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

  factory SchemaObject.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final schema = _$SchemaObjectFromJson(jsonWithoutExtensions(json));
    return schema.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$SchemaObjectToJson(this);
}