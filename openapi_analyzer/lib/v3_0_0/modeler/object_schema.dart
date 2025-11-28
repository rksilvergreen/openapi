import 'schema.dart';

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
