import '../schema_node.dart';
import '../schema_type.dart';
import '../../xml.dart';
import '../../external_documentation.dart';

abstract class EffectiveSchema<T extends EffectiveSchema<T>> {
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

  EffectiveSchema(
    this.$node,
    this.type,
    this.description,
    this.readOnly,
    this.writeOnly,
    this.example,
    this.deprecated,
    this.nullable,
  );
}

abstract class SingleTypeEffectiveSchema<T, S extends SingleTypeEffectiveSchema<T, S>> extends EffectiveSchema<S> {
  final T? defaultValue;
  final List<T>? enumValues;

  SingleTypeEffectiveSchema(
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

class MultiTypeUnionEffectiveSchema extends EffectiveSchema<MultiTypeUnionEffectiveSchema> {
  final List<EffectiveSchema> variants;
  MultiTypeUnionEffectiveSchema({
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

class UnknownEffectiveSchema extends EffectiveSchema<UnknownEffectiveSchema> {
  UnknownEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
  }) : super($node, SchemaType.unknown, description, readOnly, writeOnly, example, deprecated, nullable);
}
