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

abstract class Schema<T, S extends Schema<T, S>> {
  final String name;
  final String? description;
  final bool readOnly;
  final bool writeOnly;
  final Xml? xml;
  final ExternalDocs? externalDocs;
  final Map<String, dynamic>? example;
  final bool deprecated;
  final bool nullable;
  SchemaType get type;
  final List<T> enumValues;
  final T? defaultValue;

  Schema({
    required this.name,
    this.description,
    this.readOnly = false,
    this.writeOnly = false,
    this.xml,
    this.externalDocs,
    this.example,
    this.deprecated = false,
    this.nullable = false,
    this.enumValues = const [],
    this.defaultValue,
  });
}
