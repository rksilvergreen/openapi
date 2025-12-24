import 'package:openapi_analyzer/v3_0_0/doc_nodes/schema.dart';
import '../typed_schema/array_typed_schema.dart';
import 'effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/effective_schema/array_effective_schema.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/schema.dart';

class ArrayEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<List<dynamic>, ArrayEffectiveSchemaImpl>
    with ArrayEffectiveSchemaImplVariant
    implements ArrayEffectiveSchema {
  final SchemaNode? items;
  final int? maxItems;
  final int? minItems;
  final bool? uniqueItems;

  ArrayEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    List<dynamic>? defaultValue,
    List<List<dynamic>>? enumValues,
    this.items,
    this.maxItems,
    this.minItems,
    this.uniqueItems,
  }) : super(
         $node,
         SchemaType.array,
         description,
         readOnly,
         writeOnly,
         xml,
         externalDocs,
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );

  factory ArrayEffectiveSchemaImpl.fromTyped(SchemaNode node, ArrayTypedSchemaImpl typed) {
    return ArrayEffectiveSchemaImpl(
      $node: node,
      description: typed.description,
      readOnly: typed.readOnly,
      writeOnly: typed.writeOnly,
      xml: node.xml,
      externalDocs: node.externalDocs,
      example: typed.example,
      deprecated: typed.deprecated,
      nullable: typed.nullable,
      defaultValue: typed.defaultValue,
      enumValues: typed.enumValues,
      minItems: typed.minItems,
      maxItems: typed.maxItems,
      uniqueItems: typed.uniqueItems,
    );
  }
}

class ArrayUnionEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<List<dynamic>, ArrayEffectiveSchemaImpl>
    with ArrayEffectiveSchemaImplVariant {
  final List<ArrayEffectiveSchemaImplVariant> variants;
  ArrayUnionEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    List<dynamic>? defaultValue,
    List<List<dynamic>>? enumValues,
    required this.variants,
  }) : super(
         $node,
         SchemaType.array,
         description,
         readOnly,
         writeOnly,
         xml,
         externalDocs,
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );
}

mixin ArrayEffectiveSchemaImplVariant {}

class ArrayEffectiveSchemaImplUnregistered with ArrayEffectiveSchemaImplVariant {
  final List<dynamic>? defaultValue;
  final List<List<dynamic>>? enumValues;
  final SchemaNode? items;
  final int? maxItems;
  final int? minItems;
  final bool? uniqueItems;

  ArrayEffectiveSchemaImplUnregistered({
    this.defaultValue,
    this.enumValues,
    this.items,
    this.maxItems,
    this.minItems,
    this.uniqueItems,
  });
}
