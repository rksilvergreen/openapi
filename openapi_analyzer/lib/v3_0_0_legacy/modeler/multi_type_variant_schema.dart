import 'schema.dart';

class MultiTypeVariantSchema extends Schema {
  final List<Schema> variants;
  final List<Schema> isVariantOf;
  dynamic defaultValue;
  MultiTypeVariantSchema({
    required super.name,
    super.description,
    super.nullable,
    super.readOnly,
    super.writeOnly,
    super.xml,
    super.externalDocs,
    super.example,
    super.deprecated,
    required this.variants,
    required this.isVariantOf,
    this.defaultValue,
  });
}
