import 'package:openapi_analyzer/v3_0_0/doc_nodes/schema_doc_node.dart';
import '../typed_schema/number_typed_schema.dart';
import 'effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/effective_schema/number_effective_schema.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/schema.dart';

class NumberEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<double, NumberEffectiveSchemaImpl>
    with NumberEffectiveSchemaImplVariant
    implements NumberEffectiveSchema {
  final double? multipleOf;
  final double? maximum;
  final double? exclusiveMaximum;
  final double? minimum;
  final double? exclusiveMinimum;
  final String? format;

  NumberEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    double? defaultValue,
    List<double>? enumValues,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.format,
  }) : super(
         $node,
         SchemaType.number,
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

  factory NumberEffectiveSchemaImpl.fromTyped(SchemaNode node, NumberTypedSchemaImpl typed) {
    return NumberEffectiveSchemaImpl(
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

class NumberUnionEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<double, NumberEffectiveSchemaImpl>
    with NumberEffectiveSchemaImplVariant {
  final List<NumberEffectiveSchemaImplVariant> variants;
  NumberUnionEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    double? defaultValue,
    List<double>? enumValues,
    required this.variants,
  }) : super(
         $node,
         SchemaType.number,
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

mixin NumberEffectiveSchemaImplVariant {}

class NumberEffectiveSchemaImplUnregistered with NumberEffectiveSchemaImplVariant {
  final double? defaultValue;
  final List<double>? enumValues;
  final double? multipleOf;
  final double? maximum;
  final double? exclusiveMaximum;
  final double? minimum;
  final double? exclusiveMinimum;
  final String? format;

  NumberEffectiveSchemaImplUnregistered({
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
