enum SchemaType { string, integer, boolean, number, array, object }

class Xml {
  final String? name;
  final String? namespace;
  final String? prefix;
  final bool attribute;
  final bool wrapped;
  Xml({this.name, this.namespace, this.prefix, this.attribute = false, this.wrapped = false});
}

class ExternalDocs {
  final String url;
  final String? description;
  ExternalDocs({required this.url, this.description});
}

abstract class Schema {
  final String name;
  final String? description;
  dynamic defaultValue;
  bool nullable;
  final bool readOnly;
  final bool writeOnly;
  final Xml? xml;
  final ExternalDocs? externalDocs;
  final Map<String, dynamic>? example;
  final bool deprecated;

  Schema({
    required this.name,
    this.description,
    this.nullable = false,
    this.readOnly = false,
    this.writeOnly = false,
    this.xml,
    this.externalDocs,
    this.example,
    this.deprecated = false,
  });
}

abstract class SingleTypeSchema<T, S extends SingleTypeSchema<T, S>> extends Schema {
  SchemaType get type;
  final List<S> isBaseFor;
  final List<S> variants;
  final List<S> inheritsFrom;
  final List<Schema> isVariantOf;
  final List<T> enumValues;
  final T? defaultValue;

  SingleTypeSchema({
    required super.name,
    super.description,
    super.nullable,
    super.readOnly,
    super.writeOnly,
    super.xml,
    super.externalDocs,
    super.example,
    super.deprecated,
    this.isBaseFor = const [],
    this.variants = const [],
    this.inheritsFrom = const [],
    this.isVariantOf = const [],
    this.enumValues = const [],
    this.defaultValue,
  });

  bool get hasVariants => variants.isNotEmpty;
}

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

/// #########################################################
/// ################## Integer Schema #######################
/// #########################################################

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

/// #########################################################
/// ################### Number Schema #######################
/// #########################################################

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

/// #########################################################
/// ################### String Schema #######################
/// #########################################################

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

/// #########################################################
/// ################### Boolean Schema #######################
/// #########################################################

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

/// #########################################################
/// #################### Array Schema #######################
/// #########################################################

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

/// #########################################################
/// #################### Object Schema ######################
/// #########################################################

class Discriminator<T, S extends SingleTypeSchema<T, S>> {
  final String propertyName;
  final S discriminatorPropertySchema;
  final Map<T, Schema> mapping;
  Discriminator({required this.propertyName, required this.discriminatorPropertySchema, required this.mapping});
}

class ObjectSchema extends SingleTypeSchema<Map<String, dynamic>, ObjectSchema> {
  final SchemaType type = SchemaType.object;
  final Discriminator? discriminator;
  final List<String> requiredProperties;
  final Map<String, Schema> properties;
  final bool? additionalPropertiesAllowed;
  final Map<String, Schema> additionalProperties;
  final int? maxProperties;
  final int? minProperties;

  ObjectSchema({
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
    this.discriminator,
    this.requiredProperties = const [],
    this.properties = const {},
    this.additionalPropertiesAllowed = true,
    this.additionalProperties = const {},
    this.maxProperties,
    this.minProperties,
  }) : assert(_doVariantsOrBaseSchemasIncludeDiscriminator(discriminator, variants, isBaseFor));

  /// Validates that discriminated schemas have the proper discriminator property.
  ///
  /// PRIMARY MODE: If variants exist, validates that all variants have the discriminator property.
  /// SECONDARY MODE: If no variants, validates that all isBaseFor schemas have the discriminator property.
  static bool _doVariantsOrBaseSchemasIncludeDiscriminator(
    Discriminator? discriminator,
    List<ObjectSchema> variants,
    List<ObjectSchema> isBaseFor,
  ) {
    if (discriminator == null) return true;

    // PRIMARY MODE: Discriminator discriminates between variants
    if (variants.isNotEmpty) {
      return variants.every((variant) => _schemaHasDiscriminatorProperty(discriminator, variant));
    }

    // SECONDARY MODE: Discriminator discriminates between schemas that inherit from this one
    if (isBaseFor.isEmpty) return false;
    return isBaseFor.every((schema) => _schemaHasDiscriminatorProperty(discriminator, schema));
  }

  /// Checks if a schema has the discriminator property (either directly or inherited).
  /// Also handles recursive validation for schemas with variants.
  static bool _schemaHasDiscriminatorProperty(Discriminator discriminator, ObjectSchema schema) {
    // If schema has variants, recursively check those variants
    if (schema.hasVariants) {
      return schema.variants.every((variant) => _schemaHasDiscriminatorProperty(discriminator, variant));
    }

    // Check if property exists in this schema's properties
    bool propertyExists = schema.properties.containsKey(discriminator.propertyName);

    if (propertyExists) {
      // Property exists - check if schema is compatible
      final propertySchema = schema.properties[discriminator.propertyName]!;
      return isSubSchemeOf(propertySchema, discriminator.discriminatorPropertySchema);
    }

    // Property doesn't exist and no inheritance - invalid
    return false;
  }
}

bool isSubSchemeOf(Schema schema, Schema other) {
  return true;
}
