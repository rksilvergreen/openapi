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

@CopyWith(skipFields: true)
@JsonSerializable()
class Schema {
  final String? title;
  final String? description;
  @JsonKey(name: 'default')
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
  @JsonKey(required: true, disallowNullValue: true)
  final bool uniqueItems;
  final Ref<Schema>? items;
  final int? maxProperties;
  final int? minProperties;
  @JsonKey(name: 'required')
  final List<String>? required_;
  final Map<String, Ref<Schema>>? properties;
  final bool? additionalPropertiesAllowed;
  final Ref<Schema>? additionalProperties;
  final List<Ref<Schema>>? allOf;
  final List<Ref<Schema>>? oneOf;
  final List<Ref<Schema>>? anyOf;
  @JsonKey(name: 'enum')
  final List<dynamic>? enum_;
  @JsonKey(required: true, disallowNullValue: true)
  final bool nullable;
  final Discriminator? discriminator;
  @JsonKey(required: true, disallowNullValue: true)
  final bool readOnly;
  @JsonKey(required: true, disallowNullValue: true)
  final bool writeOnly;
  final XML? xml;
  final ExternalDocumentation? externalDocs;
  final dynamic example;
  @JsonKey(required: true, disallowNullValue: true)
  final bool deprecated;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

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
    this.extensions = const {},
  });

  factory Schema.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final schema = _$SchemaFromJson(_jsonWithoutExtensions(json));
    return schema.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$SchemaToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class SchemaNode extends NodeReferencable {
  String? title;
  String? description;
  @JsonKey(name: 'default')
  dynamic default_;
  SchemaType? type;
  String? format;
  num? multipleOf;
  num? maximum;
  num? exclusiveMaximum;
  num? minimum;
  num? exclusiveMinimum;
  int? maxLength;
  int? minLength;
  String? pattern;
  int? maxItems;
  int? minItems;
  bool uniqueItems;
  RefNode<SchemaNode>? get items => $children?['items'] as RefNode<SchemaNode>?;
  int? maxProperties;
  int? minProperties;
  @JsonKey(name: 'required')
  List<String>? required_;
  SchemasMapNode? get properties => $children?['properties'] as SchemasMapNode?;
  bool? additionalPropertiesAllowed;
  RefNode<SchemaNode>? get additionalProperties => $children?['additionalProperties'] as RefNode<SchemaNode>?;
  SchemasListNode? get allOf => $children?['allOf'] as SchemasListNode?;
  SchemasListNode? get oneOf => $children?['oneOf'] as SchemasListNode?;
  SchemasListNode? get anyOf => $children?['anyOf'] as SchemasListNode?;
  @JsonKey(name: 'enum')
  List<dynamic>? enum_;
  bool nullable;
  DiscriminatorNode? get discriminator => $children?['discriminator'] as DiscriminatorNode?;
  bool readOnly;
  bool writeOnly;
  XMLNode? get xml => $children?['xml'] as XMLNode?;
  ExternalDocumentationNode? get externalDocs => $children?['externalDocs'] as ExternalDocumentationNode?;
  dynamic example;
  bool deprecated;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  SchemaNode({
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
    this.maxProperties,
    this.minProperties,
    this.required_,
    this.additionalPropertiesAllowed,
    required this.nullable,
    required this.readOnly,
    required this.writeOnly,
    this.example,
    required this.deprecated,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$SchemaNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class SchemasMapNode extends MapTreeNode<RefNode<SchemaNode>> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = entry.value.toJson();
    }
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class SchemasListNode extends ListTreeNode<RefNode<SchemaNode>> {
  List<dynamic> toJson() {
    return map((item) => item.toJson()).toList();
  }
}
