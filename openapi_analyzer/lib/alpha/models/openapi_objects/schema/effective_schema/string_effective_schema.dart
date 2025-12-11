import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';
import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_type.dart';
import 'effective_schema.dart';

class StringEffectiveSchema extends SingleTypeEffectiveSchema<String, StringEffectiveSchema>
    with StringEffectiveSchemaVariant {
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final String? format;

  StringEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    String? defaultValue,
    List<String>? enumValues,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.format,
  }) : super(
         $node,
         SchemaType.string,
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

class StringUnionEffectiveSchema extends SingleTypeEffectiveSchema<String, StringEffectiveSchema>
    with StringEffectiveSchemaVariant {
  final List<StringEffectiveSchemaVariant> variants;
  StringUnionEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    String? defaultValue,
    List<String>? enumValues,
    required this.variants,
  }) : super(
         $node,
         SchemaType.string,
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

mixin StringEffectiveSchemaVariant {}

class StringEffectiveSchemaUnregistered with StringEffectiveSchemaVariant {
  final String? defaultValue;
  final List<String>? enumValues;
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final String? format;

  StringEffectiveSchemaUnregistered({
    this.defaultValue,
    this.enumValues,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.format,
  });
}
