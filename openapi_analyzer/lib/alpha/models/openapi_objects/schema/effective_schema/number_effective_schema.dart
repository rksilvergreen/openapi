import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';
import 'effective_schema.dart';

class NumberEffectiveSchema extends SingleTypeEffectiveSchema<double, NumberEffectiveSchema>
    with NumberEffectiveSchemaVariant {
  final double? multipleOf;
  final double? maximum;
  final double? exclusiveMaximum;
  final double? minimum;
  final double? exclusiveMinimum;
  final String? format;

  NumberEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
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
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );
}

class NumberUnionEffectiveSchema extends SingleTypeEffectiveSchema<double, NumberEffectiveSchema>
    with NumberEffectiveSchemaVariant {
  final List<NumberEffectiveSchemaVariant> variants;
  NumberUnionEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
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
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );
}

mixin NumberEffectiveSchemaVariant {}

class NumberEffectiveSchemaUnregistered with NumberEffectiveSchemaVariant {
  final double? defaultValue;
  final List<double>? enumValues;
  final double? multipleOf;
  final double? maximum;
  final double? exclusiveMaximum;
  final double? minimum;
  final double? exclusiveMinimum;
  final String? format;

  NumberEffectiveSchemaUnregistered({
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


