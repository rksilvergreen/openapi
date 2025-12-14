import '../../../validation/validation_context.dart';
import '../../../../validation_exception.dart';
import 'schema_node.dart';
import 'raw_schema.dart';
import 'schema_type.dart';
import 'typed_schema/typed_schema.dart';
import 'typed_schema/integer_typed_schema.dart';
import 'typed_schema/number_typed_schema.dart';
import 'typed_schema/string_typed_schema.dart';
import 'typed_schema/boolean_typed_schema.dart';
import 'typed_schema/array_typed_schema.dart';
import 'typed_schema/object_typed_schema.dart';

/// Factory for creating TypedSchema instances from RawSchema.
///
/// Handles type determination and atomic constraint validation.
class TypedSchemaFactory {
  /// Creates a TypedSchema from a SchemaNode and its RawSchema.
  static TypedSchema createTypedSchema(SchemaNode node, RawSchema raw, ValidationContext ctx) {
    // 1. Determine type
    final schemaType = _determineType(raw, node, ctx);

    // 2. Validate atomic constraints (no composition resolution)
    _validateAtomicConstraints(raw, schemaType, node, ctx);

    // 3. Create appropriate TypedSchema subclass
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
        // ignore: type_parameter_bound_extends_type_parameter
        return UnknownTypedSchema(
              $node: node,
              description: raw.description,
              readOnly: raw.readOnly,
              writeOnly: raw.writeOnly,
              example: raw.example,
              deprecated: raw.deprecated,
              nullable: raw.nullable,
            )
            as TypedSchema;
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
          return SchemaType.unknown;
      }
    }

    // Infer type from type-specific keywords
    if (raw.properties != null || raw.required_ != null || raw.minProperties != null || raw.maxProperties != null) {
      return SchemaType.object;
    }
    if (raw.items != null || raw.minItems != null || raw.maxItems != null || raw.uniqueItems) {
      return SchemaType.array;
    }
    if (raw.minLength != null || raw.maxLength != null || raw.pattern != null) {
      return SchemaType.string;
    }
    if (raw.minimum != null || raw.maximum != null || raw.multipleOf != null) {
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
        node.$id.relativePath,
        'Schema has no explicit type and cannot be inferred',
        specReference: 'OpenAPI 3.0.0 - Schema Object',
        severity: ValidationSeverity.low,
      ),
    );
    return SchemaType.unknown;
  }

  /// Validates atomic constraints for the determined type.
  static void _validateAtomicConstraints(RawSchema raw, SchemaType type, SchemaNode node, ValidationContext ctx) {
    final path = node.$id.relativePath;

    // Numeric constraints
    if (type == SchemaType.integer || type == SchemaType.number) {
      if (raw.minimum != null && raw.maximum != null) {
        if (raw.minimum! > raw.maximum!) {
          ctx.addException(
            OpenApiValidationException(
              path,
              'minimum (${raw.minimum}) cannot be greater than maximum (${raw.maximum})',
              specReference: 'JSON Schema Validation',
              severity: ValidationSeverity.critical,
            ),
          );
        }
      }
      if (raw.multipleOf != null && raw.multipleOf! <= 0) {
        ctx.addException(
          OpenApiValidationException(
            path,
            'multipleOf must be greater than 0',
            specReference: 'JSON Schema Validation',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }

    // String constraints
    if (type == SchemaType.string) {
      if (raw.minLength != null && raw.maxLength != null) {
        if (raw.minLength! > raw.maxLength!) {
          ctx.addException(
            OpenApiValidationException(
              path,
              'minLength (${raw.minLength}) cannot be greater than maxLength (${raw.maxLength})',
              specReference: 'JSON Schema Validation',
              severity: ValidationSeverity.critical,
            ),
          );
        }
      }
    }

    // Array constraints
    if (type == SchemaType.array) {
      if (raw.minItems != null && raw.maxItems != null) {
        if (raw.minItems! > raw.maxItems!) {
          ctx.addException(
            OpenApiValidationException(
              path,
              'minItems (${raw.minItems}) cannot be greater than maxItems (${raw.maxItems})',
              specReference: 'JSON Schema Validation',
              severity: ValidationSeverity.critical,
            ),
          );
        }
      }
    }

    // Object constraints
    if (type == SchemaType.object) {
      if (raw.minProperties != null && raw.maxProperties != null) {
        if (raw.minProperties! > raw.maxProperties!) {
          ctx.addException(
            OpenApiValidationException(
              path,
              'minProperties (${raw.minProperties}) cannot be greater than maxProperties (${raw.maxProperties})',
              specReference: 'JSON Schema Validation',
              severity: ValidationSeverity.critical,
            ),
          );
        }
      }

      // Validate required properties exist in properties
      if (raw.required_ != null && raw.properties != null) {
        for (final requiredProp in raw.required_!) {
          if (!raw.properties!.containsKey(requiredProp)) {
            ctx.addException(
              OpenApiValidationException(
                path,
                'Required property "$requiredProp" not found in properties',
                specReference: 'JSON Schema Validation',
                severity: ValidationSeverity.low, // Not critical - could be in allOf
              ),
            );
          }
        }
      }
    }
  }
}
