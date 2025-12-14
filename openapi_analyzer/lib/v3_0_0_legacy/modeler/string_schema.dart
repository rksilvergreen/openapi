import 'schema.dart';

class StringSchema extends SingleTypeSchema<String, StringSchema> {
  final SchemaType type = SchemaType.string;
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final String? format;

  StringSchema({
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
    this.maxLength,
    this.minLength,
    this.pattern,
    this.format,
  });
}