import 'schema.dart';

abstract class IntegerSchema extends Schema<int, IntegerSchema> {
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
    super.xml,
    super.externalDocs,
    super.example,
    super.deprecated,
    super.enumValues,
    super.defaultValue,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.format,
  });
}


