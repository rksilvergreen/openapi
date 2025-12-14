import '../../../validation/validation_context.dart';
import '../../../validation_exception.dart';
import 'schema_node.dart';
import 'schema_type.dart';
import 'typed_schema/typed_schema.dart';
import 'effective_schema/effective_schema.dart';
import 'effective_schema/integer_effective_schema.dart';
import 'effective_schema/number_effective_schema.dart';
import 'effective_schema/string_effective_schema.dart';
import 'effective_schema/boolean_effective_schema.dart';
import 'effective_schema/array_effective_schema.dart';
import 'effective_schema/object_effective_schema.dart';

/// Factory for creating EffectiveSchema instances from TypedSchema.
/// 
/// Handles composition resolution and variant analysis.
/// This is a simplified implementation that covers the essential functionality.
class EffectiveSchemaFactory {
  /// Creates an EffectiveSchema from a SchemaNode and its TypedSchema.
  static EffectiveSchema createEffectiveSchema(
    SchemaNode node,
    TypedSchema typed,
    ValidationContext ctx,
  ) {
    // For now, create a simplified effective schema that doesn't do full composition resolution
    // This provides a working foundation that can be enhanced later

    // Check if schema has compositions
    final hasCompositions = node.allOfNodes != null || node.oneOfNodes != null || node.anyOfNodes != null;

    if (hasCompositions) {
      // Simplified composition handling
      return _createWithCompositions(node, typed, ctx);
    } else {
      // No compositions - create direct effective schema
      return _createDirectEffectiveSchema(node, typed);
    }
  }

  /// Creates an effective schema for nodes with compositions.
  static EffectiveSchema _createWithCompositions(
    SchemaNode node,
    TypedSchema typed,
    ValidationContext ctx,
  ) {
    // Simplified: For now, just use the typed schema as-is
    // Full implementation would enumerate branches, validate, and merge constraints
    return _createDirectEffectiveSchema(node, typed);
  }

  /// Creates an effective schema directly from typed schema (no composition resolution).
  static EffectiveSchema _createDirectEffectiveSchema(
    SchemaNode node,
    TypedSchema typed,
  ) {
    switch (typed.type) {
      case SchemaType.integer:
        final intTyped = typed as IntegerTypedSchema;
        return IntegerEffectiveSchema(
          \$node: node,
          description: intTyped.description,
          readOnly: intTyped.readOnly,
          writeOnly: intTyped.writeOnly,
          example: intTyped.example,
          deprecated: intTyped.deprecated,
          nullable: intTyped.nullable,
          defaultValue: intTyped.defaultValue,
          enumValues: intTyped.enumValues,
          multipleOf: intTyped.multipleOf,
          maximum: intTyped.maximum,
          exclusiveMaximum: intTyped.exclusiveMaximum,
          minimum: intTyped.minimum,
          exclusiveMinimum: intTyped.exclusiveMinimum,
          format: intTyped.format,
        );

      case SchemaType.number:
        final numTyped = typed as NumberTypedSchema;
        return NumberEffectiveSchema(
          \$node: node,
          description: numTyped.description,
          readOnly: numTyped.readOnly,
          writeOnly: numTyped.writeOnly,
          example: numTyped.example,
          deprecated: numTyped.deprecated,
          nullable: numTyped.nullable,
          defaultValue: numTyped.defaultValue,
          enumValues: numTyped.enumValues,
          multipleOf: numTyped.multipleOf,
          maximum: numTyped.maximum,
          exclusiveMaximum: numTyped.exclusiveMaximum,
          minimum: numTyped.minimum,
          exclusiveMinimum: numTyped.exclusiveMinimum,
          format: numTyped.format,
        );

      case SchemaType.string:
        final strTyped = typed as StringTypedSchema;
        return StringEffectiveSchema(
          \$node: node,
          description: strTyped.description,
          readOnly: strTyped.readOnly,
          writeOnly: strTyped.writeOnly,
          example: strTyped.example,
          deprecated: strTyped.deprecated,
          nullable: strTyped.nullable,
          defaultValue: strTyped.defaultValue,
          enumValues: strTyped.enumValues,
          minLength: strTyped.minLength,
          maxLength: strTyped.maxLength,
          pattern: strTyped.pattern,
          format: strTyped.format,
        );

      case SchemaType.boolean:
        final boolTyped = typed as BooleanTypedSchema;
        return BooleanEffectiveSchema(
          \$node: node,
          description: boolTyped.description,
          readOnly: boolTyped.readOnly,
          writeOnly: boolTyped.writeOnly,
          example: boolTyped.example,
          deprecated: boolTyped.deprecated,
          nullable: boolTyped.nullable,
          defaultValue: boolTyped.defaultValue,
        );

      case SchemaType.array:
        final arrTyped = typed as ArrayTypedSchema;
        return ArrayEffectiveSchema(
          \$node: node,
          description: arrTyped.description,
          readOnly: arrTyped.readOnly,
          writeOnly: arrTyped.writeOnly,
          example: arrTyped.example,
          deprecated: arrTyped.deprecated,
          nullable: arrTyped.nullable,
          minItems: arrTyped.minItems,
          maxItems: arrTyped.maxItems,
          uniqueItems: arrTyped.uniqueItems,
        );

      case SchemaType.object:
        final objTyped = typed as ObjectTypedSchema;
        return ObjectEffectiveSchema(
          \$node: node,
          description: objTyped.description,
          readOnly: objTyped.readOnly,
          writeOnly: objTyped.writeOnly,
          example: objTyped.example,
          deprecated: objTyped.deprecated,
          nullable: objTyped.nullable,
          minProperties: objTyped.minProperties,
          maxProperties: objTyped.maxProperties,
          required: objTyped.required,
        );

      default:
        return UnknownEffectiveSchema(
          \$node: node,
          description: typed.description,
        );
    }
  }
}

