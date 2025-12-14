import 'schema.dart';

class BooleanSchema extends SingleTypeSchema<bool, BooleanSchema> {
  final SchemaType type = SchemaType.boolean;

  BooleanSchema({
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
  });
}