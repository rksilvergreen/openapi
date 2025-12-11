import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';
import 'effective_schema.dart';

class ArrayEffectiveSchema extends SingleTypeEffectiveSchema<List<dynamic>, ArrayEffectiveSchema>
    with ArrayEffectiveSchemaVariant {
  final SchemaNode? items;
  final int? maxItems;
  final int? minItems;
  final bool? uniqueItems;

  ArrayEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
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
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );
}

class ArrayUnionEffectiveSchema extends SingleTypeEffectiveSchema<List<dynamic>, ArrayEffectiveSchema>
    with ArrayEffectiveSchemaVariant {
  final List<ArrayEffectiveSchemaVariant> variants;
  ArrayUnionEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
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
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );
}

mixin ArrayEffectiveSchemaVariant {}

class ArrayEffectiveSchemaUnregistered with ArrayEffectiveSchemaVariant {
  final List<dynamic>? defaultValue;
  final List<List<dynamic>>? enumValues;
  final SchemaNode? items;
  final int? maxItems;
  final int? minItems;
  final bool? uniqueItems;

  ArrayEffectiveSchemaUnregistered({
    this.defaultValue,
    this.enumValues,
    this.items,
    this.maxItems,
    this.minItems,
    this.uniqueItems,
  });
}

