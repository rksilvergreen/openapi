enum SchemaType { string, integer, boolean, number, array, object }

class Xml {
  final String? name;
  final String? namespace;
  final String? prefix;
  final bool attribute;
  final bool wrapped;
  Xml({this.name, this.namespace, this.prefix, this.attribute = false, this.wrapped = false});
}

class ExternalDocs {
  final String url;
  final String? description;
  ExternalDocs({required this.url, this.description});
}

abstract class Schema {
  final String name;
  final String? description;
  dynamic defaultValue;
  bool nullable;
  final bool readOnly;
  final bool writeOnly;
  final Xml? xml;
  final ExternalDocs? externalDocs;
  final Map<String, dynamic>? example;
  final bool deprecated;

  Schema({
    required this.name,
    this.description,
    this.nullable = false,
    this.readOnly = false,
    this.writeOnly = false,
    this.xml,
    this.externalDocs,
    this.example,
    this.deprecated = false,
  });
}

abstract class SingleTypeSchema<T, S extends SingleTypeSchema<T, S>> extends Schema {
  SchemaType get type;
  final List<S> isBaseFor;
  final List<S> variants;
  final List<S> inheritsFrom;
  final List<Schema> isVariantOf;
  final List<T> enumValues;
  final T? defaultValue;

  SingleTypeSchema({
    required super.name,
    super.description,
    super.nullable,
    super.readOnly,
    super.writeOnly,
    super.xml,
    super.externalDocs,
    super.example,
    super.deprecated,
    this.isBaseFor = const [],
    this.variants = const [],
    this.inheritsFrom = const [],
    this.isVariantOf = const [],
    this.enumValues = const [],
    this.defaultValue,
  });

  bool get hasVariants => variants.isNotEmpty;
}