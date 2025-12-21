import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import '../typed_schema/object_typed_schema.dart';
import 'effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';

class ObjectEffectiveSchema extends SingleTypeEffectiveSchema<Map<String, dynamic>, ObjectEffectiveSchema>
    with ObjectEffectiveSchemaVariant {
  final Map<String, EffectiveSchema>? properties;
  final bool additionalPropertiesAllowed;
  final EffectiveSchema? additionalProperties;
  final int? maxProperties;
  final int? minProperties;
  final List<String>? required;

  ObjectEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    Map<String, dynamic>? defaultValue,
    List<Map<String, dynamic>>? enumValues,
    this.properties,
    this.additionalPropertiesAllowed = true,
    this.additionalProperties,
    this.maxProperties,
    this.minProperties,
    this.required,
  }) : super(
         $node,
         SchemaType.object,
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

  factory ObjectEffectiveSchema.fromTyped(SchemaNode node, ObjectTypedSchema typed) {
    return ObjectEffectiveSchema(
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
      minProperties: typed.minProperties,
      maxProperties: typed.maxProperties,
      required: typed.required,
    );
  }
}

class ObjectUnionEffectiveSchema extends SingleTypeEffectiveSchema<Map<String, dynamic>, ObjectEffectiveSchema>
    with ObjectEffectiveSchemaVariant {
  final List<ObjectEffectiveSchemaVariant> variants;
  ObjectUnionEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    Map<String, dynamic>? defaultValue,
    List<Map<String, dynamic>>? enumValues,
    required this.variants,
  }) : super(
         $node,
         SchemaType.object,
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

mixin ObjectEffectiveSchemaVariant {}

class ObjectEffectiveSchemaUnregistered with ObjectEffectiveSchemaVariant {
  final Map<String, dynamic>? defaultValue;
  final List<Map<String, dynamic>>? enumValues;
  final Map<String, EffectiveSchema>? properties;
  final bool additionalPropertiesAllowed;
  final EffectiveSchema? additionalProperties;
  final int? maxProperties;
  final int? minProperties;
  final List<String>? required;

  ObjectEffectiveSchemaUnregistered({
    this.defaultValue,
    this.enumValues,
    this.properties,
    this.additionalPropertiesAllowed = true,
    this.additionalProperties,
    this.maxProperties,
    this.minProperties,
    this.required,
  });
}
