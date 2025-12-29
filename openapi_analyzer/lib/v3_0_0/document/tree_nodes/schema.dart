part of '../document.dart';

/// JSON Schema type values for Schema Objects.
enum SchemaType {
  string('string'),
  number('number'),
  integer('integer'),
  boolean('boolean'),
  array('array'),
  object('object'),
  null_('null'),
  unknown('unknown'),
  multiType('multiType');

  const SchemaType(this.value);
  final String value;
}

@CopyWith()
@JsonSerializable()
class Schema extends TreeNode {
  final String? title;
  final String? description;
  final dynamic default_;
  final SchemaType? type;
  final String? format;
  final num? multipleOf;
  final num? maximum;
  final num? exclusiveMaximum;
  final num? minimum;
  final num? exclusiveMinimum;
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final int? maxItems;
  final int? minItems;
  final bool uniqueItems;
  final Schema? items;
  final int? maxProperties;
  final int? minProperties;
  final List<String>? required_;
  final SchemasMap? properties;
  final bool? additionalPropertiesAllowed;
  final Schema? additionalProperties;
  final SchemasList? allOf;
  final SchemasList? oneOf;
  final SchemasList? anyOf;
  final List<dynamic>? enum_;
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

  Schema({
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
    required this.uniqueItems,
    this.items,
    this.maxProperties,
    this.minProperties,
    this.required_,
    this.properties,
    this.additionalPropertiesAllowed,
    this.additionalProperties,
    this.allOf,
    this.oneOf,
    this.anyOf,
    this.enum_,
    required this.nullable,
    this.discriminator,
    required this.readOnly,
    required this.writeOnly,
    this.xml,
    this.externalDocs,
    this.example,
    required this.deprecated,
    this.extensions,
  });

  factory Schema.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final schema = _$SchemaFromJson(_jsonWithoutExtensions(json));
    return schema.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable(createFactory: false, createToJson: false)
class SchemasMap extends MapTreeNode<Schema> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  SchemasMap(Map<String, Schema> schemas, {this.extensions}) : super(schemas);

  factory SchemasMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return SchemasMap(map.map((key, value) => MapEntry(key, Schema.fromJson(value))), extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$SchemaToJson(entry.value);
    }
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

@CopyWith()
@JsonSerializable(createFactory: false, createToJson: false)
class SchemasList extends ListTreeNode<Schema> {
  SchemasList(List<Schema> schemas) : super(schemas);

  factory SchemasList.fromJson(List<dynamic> json) {
    return SchemasList(json.map((i) => Schema.fromJson(i)).toList());
  }

  List<dynamic> toJson() {
    return map((item) => _$SchemaToJson(item)).toList();
  }
}
