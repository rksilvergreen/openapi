import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';
import 'effective_schema.dart';

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
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );
}

class IntegerUnionEffectiveSchema extends SingleTypeEffectiveSchema<int, IntegerEffectiveSchema>
    with IntegerEffectiveSchemaVariant {
  final List<IntegerEffectiveSchemaVariant> variants;
  IntegerUnionEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
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
