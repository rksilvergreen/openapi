import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';
import 'effective_schema.dart';

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
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );
}

class ObjectUnionEffectiveSchema extends SingleTypeEffectiveSchema<Map<String, dynamic>, ObjectEffectiveSchema>
    with ObjectEffectiveSchemaVariant {
  final List<ObjectEffectiveSchemaVariant> variants;
  ObjectUnionEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
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
