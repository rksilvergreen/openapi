import 'schema.dart';

class NumberSchema extends SingleTypeSchema<double, NumberSchema> {
  final SchemaType type = SchemaType.number;
  final double? multipleOf;
  final double? maximum;
  final double? exclusiveMaximum;
  final double? minimum;
  final double? exclusiveMinimum;
  final String? format;

  NumberSchema({
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
  });
}