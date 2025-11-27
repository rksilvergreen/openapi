enum SchemaType { string, integer, boolean, number, array, object }

abstract interface class Schema {
  String get name;
}

abstract interface class SingleTypeSchema<T, S extends SingleTypeSchema<T, S>> implements Schema {
  SchemaType get type;
  List<S> get isBaseFor;
  List<S> get inheritsFrom;
  List<Schema> get isVariantOf;
  List<T> get enumValues;
}

abstract interface class SingleTypeVariantSchema<T, S extends SingleTypeSchema<T, S>>
    implements SingleTypeSchema<T, S> {
  List<S> get variants;
}

class MultiTypeVariantSchema implements Schema {
  final String name;
  final List<Schema> variants;
  MultiTypeVariantSchema(this.name, this.variants);
}

/// #########################################################
/// ################## Integer Schema #######################
/// #########################################################

abstract class IntegerSchema implements SingleTypeSchema<int, IntegerSchema> {
  final String name;
  final SchemaType type = SchemaType.integer;
  final List<IntegerSchema> isBaseFor;
  final List<IntegerSchema> inheritsFrom;
  final List<Schema> isVariantOf;
  final List<int> enumValues;
  IntegerSchema({
    required this.name,
    this.isBaseFor = const [],
    this.inheritsFrom = const [],
    this.isVariantOf = const [],
    this.enumValues = const [],
  });
}

class IntegerStandardSchema extends IntegerSchema {
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;

  IntegerStandardSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
  });
}

class IntegerVariantSchema extends IntegerSchema implements SingleTypeVariantSchema<int, IntegerSchema> {
  final List<IntegerSchema> variants;
  IntegerVariantSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.variants = const [],
  });
}

/// #########################################################
/// ################### Number Schema #######################
/// #########################################################

abstract class NumberSchema implements SingleTypeSchema<double, NumberSchema> {
  final String name;
  final SchemaType type = SchemaType.number;
  final List<NumberSchema> isBaseFor;
  final List<NumberSchema> inheritsFrom;
  final List<Schema> isVariantOf;
  final List<double> enumValues;
  NumberSchema({
    required this.name,
    this.isBaseFor = const [],
    this.inheritsFrom = const [],
    this.isVariantOf = const [],
    this.enumValues = const [],
  });
}

class NumberStandardSchema extends NumberSchema {
  final double? multipleOf;
  final double? maximum;
  final double? exclusiveMaximum;
  final double? minimum;
  final double? exclusiveMinimum;

  NumberStandardSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
  });
}

class NumberVariantSchema extends NumberSchema implements SingleTypeVariantSchema<double, NumberSchema> {
  final List<NumberSchema> variants;
  NumberVariantSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.variants = const [],
  });
}

/// #########################################################
/// ################### String Schema #######################
/// #########################################################

abstract class StringSchema implements SingleTypeSchema<String, StringSchema> {
  final String name;
  final SchemaType type = SchemaType.string;
  final List<StringSchema> isBaseFor;
  final List<StringSchema> inheritsFrom;
  final List<Schema> isVariantOf;
  final List<String> enumValues;
  StringSchema({
    required this.name,
    this.isBaseFor = const [],
    this.inheritsFrom = const [],
    this.isVariantOf = const [],
    this.enumValues = const [],
  });
}

class StringStandardSchema extends StringSchema {
  final int? maxLength;
  final int? minLength;
  final String? pattern;

  StringStandardSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.maxLength,
    this.minLength,
    this.pattern,
  });
}

class StringVariantSchema extends StringSchema implements SingleTypeVariantSchema<String, StringSchema> {
  final List<StringSchema> variants;
  StringVariantSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.variants = const [],
  });
}

/// #########################################################
/// ################### Boolean Schema #######################
/// #########################################################

abstract class BooleanSchema implements SingleTypeSchema<bool, BooleanSchema> {
  final String name;
  final SchemaType type = SchemaType.boolean;
  final List<BooleanSchema> isBaseFor;
  final List<BooleanSchema> inheritsFrom;
  final List<Schema> isVariantOf;
  final List<bool> enumValues;
  BooleanSchema({
    required this.name,
    this.isBaseFor = const [],
    this.inheritsFrom = const [],
    this.isVariantOf = const [],
    this.enumValues = const [],
  });
}

class BooleanStandardSchema extends BooleanSchema {
  BooleanStandardSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
  });
}

class BooleanVariantSchema extends BooleanSchema implements SingleTypeVariantSchema<bool, BooleanSchema> {
  final List<BooleanSchema> variants;
  BooleanVariantSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.variants = const [],
  });
}

/// #########################################################
/// #################### Array Schema #######################
/// #########################################################

abstract class ArraySchema<T> implements SingleTypeSchema<List<T>, ArraySchema<T>> {
  final String name;
  final SchemaType type = SchemaType.array;
  final List<ArraySchema<T>> isBaseFor;
  final List<ArraySchema<T>> inheritsFrom;
  final List<Schema> isVariantOf;
  final List<List<T>> enumValues;
  ArraySchema({
    required this.name,
    this.isBaseFor = const [],
    this.inheritsFrom = const [],
    this.isVariantOf = const [],
    this.enumValues = const [],
  });
}

class ArrayStandardSchema<T> extends ArraySchema<T> {
  final Schema? items;
  final int? maxItems;
  final int? minItems;
  final bool? uniqueItems;

  ArrayStandardSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.items,
    this.maxItems,
    this.minItems,
    this.uniqueItems,
  });
}

class ArrayVariantSchema<T> extends ArraySchema<T> implements SingleTypeVariantSchema<List<T>, ArraySchema<T>> {
  final List<ArraySchema<T>> variants;
  ArrayVariantSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.variants = const [],
  });
}

/// #########################################################
/// #################### Object Schema ######################
/// #########################################################

abstract class ObjectSchema implements SingleTypeSchema<Map<String, dynamic>, ObjectSchema> {
  final String name;
  final SchemaType type = SchemaType.object;
  final List<ObjectSchema> isBaseFor;
  final List<ObjectSchema> inheritsFrom;
  final List<Schema> isVariantOf;
  final List<Map<String, dynamic>> enumValues;
  ObjectSchema({
    required this.name,
    this.isBaseFor = const [],
    this.inheritsFrom = const [],
    this.isVariantOf = const [],
    this.enumValues = const [],
  });
}

class ObjectStandardSchema extends ObjectSchema {
  final List<Schema> requiredProperties;
  final List<Schema> properties;
  final bool? additionalPropertiesAllowed;
  final List<Schema> additionalProperties;
  final int? maxProperties;
  final int? minProperties;

  ObjectStandardSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.requiredProperties = const [],
    this.properties = const [],
    this.additionalPropertiesAllowed = true,
    this.additionalProperties = const [],
    this.maxProperties,
    this.minProperties,
  });
}

class ObjectVariantSchema extends ObjectSchema implements SingleTypeVariantSchema<Map<String, dynamic>, ObjectSchema> {
  final List<ObjectSchema> variants;
  ObjectVariantSchema({
    required super.name,
    required super.isBaseFor,
    required super.inheritsFrom,
    required super.isVariantOf,
    required super.enumValues,
    this.variants = const [],
  });
}
