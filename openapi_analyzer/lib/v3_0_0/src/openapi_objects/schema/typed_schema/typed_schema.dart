import '../schema.dart';
import '../schema_type.dart';
import '../../../validation/validation_context.dart';
import '../../../validation/validation_utils.dart';
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
import '../effective_schema/effective_schema.dart';

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

  SchemaNode get raw => $node;
  EffectiveSchema get effective => $node.$effective;

  /// Creates a TypedSchema from a SchemaNode.
  static TypedSchema of(SchemaNode node, ValidationContext ctx) {
    final schemaType = _inferType(node, ctx);
    switch (schemaType) {
      case SchemaType.integer:
        return IntegerTypedSchema.of(node);
      case SchemaType.number:
        return NumberTypedSchema.of(node);
      case SchemaType.string:
        return StringTypedSchema.of(node);
      case SchemaType.boolean:
        return BooleanTypedSchema.of(node);
      case SchemaType.array:
        return ArrayTypedSchema.of(node);
      case SchemaType.object:
        return ObjectTypedSchema.of(node);
      default:
        return UnknownTypedSchema.of(node);
    }
  }

  /// Determines the schema type based on the type keyword and type-specific keywords.
  static SchemaType _inferType(SchemaNode node, ValidationContext ctx) {
    // If type keyword is present, use it
    final explicitType = _inferTypeFromExplicit(node);
    if (explicitType != null) {
      return explicitType;
    }

    // Infer type from type-specific keywords
    final keywordType = _inferTypeFromKeywords(node, ctx);
    if (keywordType != null) {
      return keywordType;
    }

    // Try to infer type from defaultValue and enumValues
    final inferredTypeFromValues = _inferTypeFromValues(node, ctx);
    if (inferredTypeFromValues != null) {
      return inferredTypeFromValues;
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

  /// Infers schema type from the explicit type keyword.
  /// Returns the type if present, or null if not specified.
  static SchemaType? _inferTypeFromExplicit(SchemaNode node) {
    if (node.type != null) {
      return node.type!;
    }
    return null;
  }

  /// Infers schema type from type-specific keywords.
  /// Returns the inferred type, or null if type cannot be determined from keywords.
  static SchemaType? _inferTypeFromKeywords(SchemaNode node, ValidationContext ctx) {
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

    // If no types are indicated, return null to try other inference methods
    if (typeCount == 0) {
      return null;
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

    return null;
  }

  /// Infers schema type from defaultValue and enumValues, and validates their consistency.
  /// Returns the inferred SchemaType, or null if type cannot be determined from values.
  static SchemaType? _inferTypeFromValues(SchemaNode node, ValidationContext ctx) {
    final jsonPointer = node.$id.jsonPointer;
    final defaultValue = node.default_;
    final enumValues = node.enum_;

    SchemaType? defaultType;
    SchemaType? enumType;

    // Determine type from defaultValue
    if (defaultValue != null) {
      defaultType = _getTypeFromValue(defaultValue);
    }

    // Determine type from enumValues and validate they're all the same type
    if (enumValues != null && enumValues.isNotEmpty) {
      final firstEnumType = _getTypeFromValue(enumValues.first);

      // Check that all enum values are of the same type
      for (var i = 0; i < enumValues.length; i++) {
        final enumValue = enumValues[i];
        final valueType = _getTypeFromValue(enumValue);

        if (valueType != firstEnumType) {
          ctx.addException(
            OpenApiValidationException(
              ValidationUtils.buildPointer([jsonPointer, 'enum', '[$i]']),
              'Enum values must all be of the same type. Found ${firstEnumType?.name} and ${valueType?.name}',
              specReference: 'JSON Schema Validation',
              severity: ValidationSeverity.critical,
            ),
          );
          return null; // Can't determine type if enum values are inconsistent
        }
      }

      enumType = firstEnumType;
    }

    // If both defaultValue and enumValues exist, validate they're the same type
    if (defaultType != null && enumType != null) {
      if (defaultType != enumType) {
        ctx.addException(
          OpenApiValidationException(
            jsonPointer,
            'defaultValue type (${defaultType.name}) does not match enum values type (${enumType.name})',
            specReference: 'JSON Schema Validation',
            severity: ValidationSeverity.critical,
          ),
        );
        return null; // Can't determine type if they conflict
      }
    }

    // Return the determined type (prefer enumType if both exist, since it's more specific)
    return enumType ?? defaultType;
  }

  /// Determines the SchemaType from a runtime value.
  static SchemaType? _getTypeFromValue(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is int) {
      return SchemaType.integer;
    } else if (value is num) {
      return SchemaType.number;
    } else if (value is String) {
      return SchemaType.string;
    } else if (value is bool) {
      return SchemaType.boolean;
    } else if (value is List) {
      return SchemaType.array;
    } else if (value is Map) {
      return SchemaType.object;
    }

    return null;
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
