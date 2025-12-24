import 'package:openapi_analyzer/v3_0_0/doc_nodes/schema_doc_node.dart';
import '../typed_schema/boolean_typed_schema.dart';
import 'effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/effective_schema/boolean_effective_schema.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/schema.dart';

class BooleanEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<bool, BooleanEffectiveSchemaImpl>
    with BooleanEffectiveSchemaImplVariant
    implements BooleanEffectiveSchema {
  final String? format;

  BooleanEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    bool? defaultValue,
    List<bool>? enumValues,
    this.format,
  }) : super(
         $node,
         SchemaType.boolean,
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

  factory BooleanEffectiveSchemaImpl.fromTyped(SchemaNode node, BooleanTypedSchemaImpl typed) {
    return BooleanEffectiveSchemaImpl(
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
    );
  }
}

class BooleanUnionEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<bool, BooleanEffectiveSchemaImpl>
    with BooleanEffectiveSchemaImplVariant {
  final List<BooleanEffectiveSchemaImplVariant> variants;
  BooleanUnionEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    bool? defaultValue,
    List<bool>? enumValues,
    required this.variants,
  }) : super(
         $node,
         SchemaType.boolean,
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

mixin BooleanEffectiveSchemaImplVariant {}

class BooleanEffectiveSchemaImplUnregistered with BooleanEffectiveSchemaImplVariant {
  final bool? defaultValue;
  final List<bool>? enumValues;
  final String? format;

  BooleanEffectiveSchemaImplUnregistered({this.defaultValue, this.enumValues, this.format});
}
