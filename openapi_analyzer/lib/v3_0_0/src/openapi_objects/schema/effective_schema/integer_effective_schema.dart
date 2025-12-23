import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema_type.dart';
import '../typed_schema/integer_typed_schema.dart';
import 'effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';

class IntegerEffectiveSchema extends SingleTypeEffectiveSchema<int, IntegerEffectiveSchema>
    with IntegerEffectiveSchemaVariant {
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;
  final String? format;

  IntegerEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
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

  factory IntegerEffectiveSchema.fromTyped(SchemaNode node, IntegerTypedSchema typed) {
    return IntegerEffectiveSchema(
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

class IntegerUnionEffectiveSchema extends SingleTypeEffectiveSchema<int, IntegerEffectiveSchema>
    with IntegerEffectiveSchemaVariant {
  final List<IntegerEffectiveSchemaVariant> variants;
  IntegerUnionEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
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

mixin IntegerEffectiveSchemaVariant {}

class IntegerEffectiveSchemaUnregistered with IntegerEffectiveSchemaVariant {
  final int? defaultValue;
  final List<int>? enumValues;
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;
  final String? format;

  IntegerEffectiveSchemaUnregistered({
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
