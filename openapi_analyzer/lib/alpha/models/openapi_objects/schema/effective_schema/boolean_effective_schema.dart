import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';
import 'effective_schema.dart';

class BooleanEffectiveSchema extends SingleTypeEffectiveSchema<bool, BooleanEffectiveSchema>
    with BooleanEffectiveSchemaVariant {
  final String? format;

  BooleanEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
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
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );
}

class BooleanUnionEffectiveSchema extends SingleTypeEffectiveSchema<bool, BooleanEffectiveSchema>
    with BooleanEffectiveSchemaVariant {
  final List<BooleanEffectiveSchemaVariant> variants;
  BooleanUnionEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
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


