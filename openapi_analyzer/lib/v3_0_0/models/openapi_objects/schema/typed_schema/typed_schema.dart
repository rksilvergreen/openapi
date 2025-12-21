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

abstract class TypedSchema<T> {
  final SchemaNode $node;
  final SchemaType type;
  final String? description;
  final bool readOnly;
  final bool writeOnly;
  final XML? xml;
  final ExternalDocumentation? externalDocs;
  final Map<String, dynamic>? example;
  final bool deprecated;
  final bool nullable;
  final T? defaultValue;
  final List<T>? enumValues;

  TypedSchema(
    this.$node,
    this.type,
    this.description,
    this.readOnly,
    this.writeOnly,
    this.xml,
    this.externalDocs,
    this.example,
    this.deprecated,
    this.nullable,
    this.defaultValue,
    this.enumValues,
  );

  List<TypedSchema>? get allOf => $node.allOf?.map((node) => node.$typed).toList();
  List<TypedSchema>? get oneOf => $node.oneOf?.map((node) => node.$typed).toList();
  List<TypedSchema>? get anyOf => $node.anyOf?.map((node) => node.$typed).toList();

  /// Creates a TypedSchema from a SchemaNode and its RawSchema.
  static TypedSchema of(SchemaNode node, ValidationContext ctx) {
    final schemaType = _determineType(node, ctx);

    switch (schemaType) {
      case SchemaType.integer:
        return IntegerTypedSchema.of(node);
      case SchemaType.number:
        return NumberTypedSchema.of(node);
      case SchemaType.string:
        return StringTypedSchema.of(node);
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
  static SchemaType _determineType(SchemaNode node, ValidationContext ctx) {
    // If type keyword is present, use it
    if (node.type != null) {
      return node.type!;
    }

    // Infer type from type-specific keywords
    // Check which type-specific keywords are present
    final hasObjectKeywords =
        node.properties != null || node.required_ != null || node.minProperties != null || node.maxProperties != null;
    final hasArrayKeywords = node.items != null || node.minItems != null || node.maxItems != null || node.uniqueItems;
    final hasStringKeywords = node.minLength != null || node.maxLength != null || node.pattern != null;
    final hasNumericKeywords = node.minimum != null || node.maximum != null || node.multipleOf != null;

    // Count how many types are indicated
    int typeCount = 0;
    if (hasObjectKeywords) typeCount++;
    if (hasArrayKeywords) typeCount++;
    if (hasStringKeywords) typeCount++;
    if (hasNumericKeywords) typeCount++;

    // If no types are indicated, return unknown
    if (typeCount == 0) {
      return SchemaType.unknown;
    }

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

  static void validateConstraints<T>(
    SchemaNode node,
    ValidationContext ctx,
    void Function(SchemaNode, ValidationContext) typeValidator,
  ) {
    final jsonPointer = node.$id.jsonPointer;

    if (node.default_ != null && node.default_! is T) {
      ctx.addException(
        OpenApiValidationException(
          jsonPointer,
          'defaultValue must be a ${T.runtimeType}',
          specReference: 'JSON Schema Validation',
          severity: ValidationSeverity.critical,
        ),
      );
    }

    if (node.enum_ != null && node.enum_!.any((e) => e! is T)) {
      ctx.addException(
        OpenApiValidationException(
          jsonPointer,
          'enumValues must be a ${T.runtimeType}',
          specReference: 'JSON Schema Validation',
          severity: ValidationSeverity.critical,
        ),
      );
    }

    typeValidator(node, ctx);
  }
}
