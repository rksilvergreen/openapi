import 'package:openapi_analyzer/v3_0_0/doc_nodes/schema.dart';
import '../typed_schema/integer_typed_schema.dart';
import 'effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/effective_schema/integer_effective_schema.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/schema.dart';

class IntegerEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<int, IntegerEffectiveSchemaImpl>
    with IntegerEffectiveSchemaImplVariant
    implements IntegerEffectiveSchema {
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;
  final String? format;

  IntegerEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    int? defaultValue,
    List<int>? enumValues,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.format,
  }) : super(
         $node,
         SchemaType.integer,
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

  factory IntegerEffectiveSchemaImpl.fromTyped(SchemaNode node, IntegerTypedSchemaImpl typed) {
    return IntegerEffectiveSchemaImpl(
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
      multipleOf: typed.multipleOf,
      maximum: typed.maximum,
      exclusiveMaximum: typed.exclusiveMaximum,
      minimum: typed.minimum,
      exclusiveMinimum: typed.exclusiveMinimum,
      format: typed.format,
    );
  }
}

class IntegerUnionEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<int, IntegerEffectiveSchemaImpl>
    with IntegerEffectiveSchemaImplVariant {
  final List<IntegerEffectiveSchemaImplVariant> variants;
  IntegerUnionEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    int? defaultValue,
    List<int>? enumValues,
    required this.variants,
  }) : super(
         $node,
         SchemaType.integer,
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

mixin IntegerEffectiveSchemaImplVariant {}

class IntegerEffectiveSchemaImplUnregistered with IntegerEffectiveSchemaImplVariant {
  final int? defaultValue;
  final List<int>? enumValues;
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;
  final String? format;

  IntegerEffectiveSchemaImplUnregistered({
    this.defaultValue,
    this.enumValues,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.format,
  });
}
