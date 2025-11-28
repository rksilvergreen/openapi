import 'schema.dart';

class IntegerSchema extends SingleTypeSchema<int, IntegerSchema> {
  final SchemaType type = SchemaType.integer;
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;
  final String? format;

  IntegerSchema({
    required super.name,
    super.description,
    super.nullable,
    super.readOnly,
    super.writeOnly,
    super.example,
    super.deprecated,
    super.xml,
    super.externalDocs,
    super.isBaseFor,
    super.variants,
    super.inheritsFrom,
    super.isVariantOf,
    super.enumValues,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.format,
  }) : assert(
         _ifIsVariantSchemaThenNoTypeFields(variants, multipleOf, maximum, exclusiveMaximum, minimum, exclusiveMinimum),
       );

  static bool _ifIsVariantSchemaThenNoTypeFields(
    List<IntegerSchema> variants,
    double? multipleOf,
    int? maximum,
    int? exclusiveMaximum,
    int? minimum,
    int? exclusiveMinimum,
  ) {
    if (variants.isNotEmpty) {
      return multipleOf == null &&
          maximum == null &&
          exclusiveMaximum == null &&
          minimum == null &&
          exclusiveMinimum == null;
    }
    return true;
  }

  bool isSubSchemeOf(IntegerSchema schema) {
    if (schema is IntegerStandardSchema) {
      if ((schema.multipleOf != null && schema.multipleOf == multipleOf) &&
          (schema.maximum != null && schema.maximum == maximum) &&
          (schema.exclusiveMaximum != null && schema.exclusiveMaximum == exclusiveMaximum) &&
          (schema.minimum != null && schema.minimum == minimum) &&
          (schema.exclusiveMinimum != null && schema.exclusiveMinimum == exclusiveMinimum) &&
          (schema.enumValues.isEmpty || schema.enumValues.every(enumValues.contains))) {
        return true;
      }
      return false;
    }
    if (schema is IntegerVariantSchema) {
      return schema.variants.any(isSubSchemeOf);
    }
    return false;
  }
}