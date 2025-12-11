import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../schema_node.dart';
import '../schema_type.dart';
import '../../xml.dart';
import '../../external_documentation.dart';

@CopyWith()
@JsonSerializable()
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
