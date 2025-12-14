import 'schema.dart';

class ArraySchema<T> extends SingleTypeSchema<List<T>, ArraySchema<T>> {
  final SchemaType type = SchemaType.array;
  final Schema? items;
  final int? maxItems;
  final int? minItems;
  final bool? uniqueItems;

  ArraySchema({
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
    this.items,
    this.maxItems,
    this.minItems,
    this.uniqueItems,
  });
}