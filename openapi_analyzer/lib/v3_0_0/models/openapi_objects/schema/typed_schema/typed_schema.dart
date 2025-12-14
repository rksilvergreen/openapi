import '../schema_node.dart';
import '../schema_type.dart';
import '../../xml.dart';
import '../../external_documentation.dart';

abstract class TypedSchema<T extends TypedSchema<T>> {
  final SchemaNode $node;
  final SchemaType type;
  final String? description;
  final bool readOnly;
  final bool writeOnly;
  XML? get xml => $node.xmlNode?.content;
  ExternalDocumentation? get externalDocs => $node.externalDocsNode?.content;
  final Map<String, dynamic>? example;
  final bool deprecated;
  final bool nullable;

  TypedSchema(
    this.$node,
    this.type,
    this.description,
    this.readOnly,
    this.writeOnly,
    this.example,
    this.deprecated,
    this.nullable,
  );

  List<T>? get allOf => $node.allOfNodes?.map((node) => node.typed as T).toList();
  List<T>? get oneOf => $node.oneOfNodes?.map((node) => node.typed as T).toList();
  List<T>? get anyOf => $node.anyOfNodes?.map((node) => node.typed as T).toList();
}

abstract class SingleTypeTypedSchema<T, S extends SingleTypeTypedSchema<T, S>> extends TypedSchema<S> {
  final T? defaultValue;
  final List<T>? enumValues;

  SingleTypeTypedSchema(
    super.$node,
    super.type,
    super.description,
    super.readOnly,
    super.writeOnly,
    super.example,
    super.deprecated,
    super.nullable,
    this.defaultValue,
    this.enumValues,
  );
}

class MultiTypeTypedSchema<T, S extends MultiTypeTypedSchema<T, S>> extends TypedSchema<S> {
  final List<S> variants;
  MultiTypeTypedSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    required this.variants,
  }) : super($node, SchemaType.multiType, description, readOnly, writeOnly, example, deprecated, nullable);
}

class UnknownTypedSchema<T, S extends UnknownTypedSchema<T, S>> extends TypedSchema<S> {
  UnknownTypedSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
  }) : super($node, SchemaType.unknown, description, readOnly, writeOnly, example, deprecated, nullable);
}
