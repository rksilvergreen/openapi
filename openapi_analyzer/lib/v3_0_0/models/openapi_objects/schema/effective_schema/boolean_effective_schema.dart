import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import '../typed_schema/boolean_typed_schema.dart';
import 'effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';

class BooleanEffectiveSchema extends SingleTypeEffectiveSchema<bool, BooleanEffectiveSchema>
    with BooleanEffectiveSchemaVariant {
  final String? format;

  BooleanEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
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

  factory BooleanEffectiveSchema.fromTyped(SchemaNode node, BooleanTypedSchema typed) {
    return BooleanEffectiveSchema(
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

class BooleanUnionEffectiveSchema extends SingleTypeEffectiveSchema<bool, BooleanEffectiveSchema>
    with BooleanEffectiveSchemaVariant {
  final List<BooleanEffectiveSchemaVariant> variants;
  BooleanUnionEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
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

mixin BooleanEffectiveSchemaVariant {}

class BooleanEffectiveSchemaUnregistered with BooleanEffectiveSchemaVariant {
  final bool? defaultValue;
  final List<bool>? enumValues;
  final String? format;

  BooleanEffectiveSchemaUnregistered({
    this.defaultValue,
    this.enumValues,
    this.format,
  });
}


