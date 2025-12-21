import '../schema.dart';
import '../raw_schema.dart';
import '../schema_type.dart';
import '../../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'integer_typed_schema.dart';
import 'number_typed_schema.dart';
import 'string_typed_schema.dart';
import 'boolean_typed_schema.dart';
import 'array_typed_schema.dart';
import 'object_typed_schema.dart';
import 'unknown_typed_schema.dart';

abstract class TypedSchema<T extends TypedSchema<T>> {
  final SchemaNode $node;
  final SchemaType type;
  final String? description;
  final bool readOnly;
  final bool writeOnly;
  XML? get xml => $node.xmlNode?.content;
  ExternalDocumentation? get externalDocs => $node.externalDocsNode?.content;
  final Map<String, dynamic>? example;
  final bool deprecated;
  final bool nullable;

  TypedSchema(
    this.$node,
    this.type,
    this.description,
    this.readOnly,
    this.writeOnly,
    this.example,
    this.deprecated,
    this.nullable,
  );

  List<T>? get allOf => $node.allOfNodes?.map((node) => node.typed as T).toList();
  List<T>? get oneOf => $node.oneOfNodes?.map((node) => node.typed as T).toList();
  List<T>? get anyOf => $node.anyOfNodes?.map((node) => node.typed as T).toList();

  /// Creates a TypedSchema from a SchemaNode and its RawSchema.
  static TypedSchema fromRaw(SchemaNode node, RawSchema raw, ValidationContext ctx) {
    final schemaType = _determineType(raw, node, ctx);

    switch (schemaType) {
      case SchemaType.integer:
        return IntegerTypedSchema.fromRaw(node, raw);
      case SchemaType.number:
        return NumberTypedSchema.fromRaw(node, raw);
      case SchemaType.string:
        return StringTypedSchema.fromRaw(node, raw);
      case SchemaType.boolean:
        return BooleanTypedSchema.fromRaw(node, raw);
      case SchemaType.array:
        return ArrayTypedSchema.fromRaw(node, raw);
      case SchemaType.object:
        return ObjectTypedSchema.fromRaw(node, raw);
      default:
        return UnknownTypedSchema.fromRaw(node, raw);
    }
  }

  /// Determines the schema type based on the type keyword and type-specific keywords.
  static SchemaType _determineType(RawSchema raw, SchemaNode node, ValidationContext ctx) {
    // If type keyword is present, use it
    if (raw.type != null) {
      switch (raw.type) {
        case 'integer':
          return SchemaType.integer;
        case 'number':
          return SchemaType.number;
        case 'string':
          return SchemaType.string;
        case 'boolean':
          return SchemaType.boolean;
        case 'array':
          return SchemaType.array;
        case 'object':
          return SchemaType.object;
        case 'null':
          return SchemaType.unknown; // Handle null type
        default:
          ctx.addException(
            OpenApiValidationException(
              node.$id.jsonPointer,
              'Invalid type value: "${raw.type}". Must be one of: integer, number, string, boolean, array, object, null',
              specReference: 'OpenAPI 3.0.0 - Schema Object',
              severity: ValidationSeverity.critical,
            ),
          );
          return SchemaType.unknown;
      }
    }

    // Infer type from type-specific keywords
    // Check which type-specific keywords are present
    final hasObjectKeywords =
        raw.properties != null || raw.required_ != null || raw.minProperties != null || raw.maxProperties != null;
    final hasArrayKeywords = raw.items != null || raw.minItems != null || raw.maxItems != null || raw.uniqueItems;
    final hasStringKeywords = raw.minLength != null || raw.maxLength != null || raw.pattern != null;
    final hasNumericKeywords = raw.minimum != null || raw.maximum != null || raw.multipleOf != null;

    // Count how many types are indicated
    int typeCount = 0;
    if (hasObjectKeywords) typeCount++;
    if (hasArrayKeywords) typeCount++;
    if (hasStringKeywords) typeCount++;
    if (hasNumericKeywords) typeCount++;

    // If multiple types are indicated, that's a conflict
    if (typeCount > 1) {
      final conflictingTypes = <String>[];
      if (hasObjectKeywords) conflictingTypes.add('object');
      if (hasArrayKeywords) conflictingTypes.add('array');
      if (hasStringKeywords) conflictingTypes.add('string');
      if (hasNumericKeywords) conflictingTypes.add('number/integer');
      ctx.addException(
        OpenApiValidationException(
          node.$id.jsonPointer,
          'Schema has conflicting type-specific keywords indicating multiple types: ${conflictingTypes.join(", ")}. '
          'Please specify an explicit type or remove conflicting keywords.',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
          severity: ValidationSeverity.moderate,
        ),
      );
      // Return unknown type when there's a conflict
      return SchemaType.unknown;
    }

    // Return the inferred type
    if (hasObjectKeywords) {
      return SchemaType.object;
    }
    if (hasArrayKeywords) {
      return SchemaType.array;
    }
    if (hasStringKeywords) {
      return SchemaType.string;
    }
    if (hasNumericKeywords) {
      // Could be integer or number - default to number
      return SchemaType.number;
    }

    // If oneOf/anyOf present, may be multi-type (determined later in Effective stage)
    if (raw.oneOf != null || raw.anyOf != null) {
      return SchemaType.unknown; // Will be resolved in effective schema
    }

    // No type information available
    ctx.addException(
      OpenApiValidationException(
        node.$id.jsonPointer,
        'Schema has no explicit type and cannot be inferred',
        specReference: 'OpenAPI 3.0.0 - Schema Object',
        severity: ValidationSeverity.low,
      ),
    );
    return SchemaType.unknown;
  }
}

abstract class SingleTypeTypedSchema<T, S extends SingleTypeTypedSchema<T, S>> extends TypedSchema<S> {
  final T? defaultValue;
  final List<T>? enumValues;

  SingleTypeTypedSchema(
    super.$node,
    super.type,
    super.description,
    super.readOnly,
    super.writeOnly,
    super.example,
    super.deprecated,
    super.nullable,
    this.defaultValue,
    this.enumValues,
  );
}

class MultiTypeTypedSchema<T, S extends MultiTypeTypedSchema<T, S>> extends TypedSchema<S> {
  final List<S> variants;
  MultiTypeTypedSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    required this.variants,
  }) : super($node, SchemaType.multiType, description, readOnly, writeOnly, example, deprecated, nullable);
}
