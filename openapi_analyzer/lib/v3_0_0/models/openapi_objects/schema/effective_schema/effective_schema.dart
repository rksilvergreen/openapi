import '../schema_node.dart';
import '../schema_type.dart';
import '../typed_schema/typed_schema.dart';
import '../typed_schema/integer_typed_schema.dart';
import '../typed_schema/number_typed_schema.dart';
import '../typed_schema/string_typed_schema.dart';
import '../typed_schema/boolean_typed_schema.dart';
import '../typed_schema/array_typed_schema.dart';
import '../typed_schema/object_typed_schema.dart';
import '../../../../validation/validation_context.dart';
import 'integer_effective_schema.dart';
import 'number_effective_schema.dart';
import 'string_effective_schema.dart';
import 'boolean_effective_schema.dart';
import 'array_effective_schema.dart';
import 'object_effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';

abstract class EffectiveSchema<T extends EffectiveSchema<T>> {
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

  EffectiveSchema(
    this.$node,
    this.type,
    this.description,
    this.readOnly,
    this.writeOnly,
    this.example,
    this.deprecated,
    this.nullable,
  );

  /// Creates an EffectiveSchema from a SchemaNode and its TypedSchema.
  static EffectiveSchema fromTyped(SchemaNode node, TypedSchema typed, ValidationContext ctx) {
    // Check if schema has compositions
    final hasCompositions = node.allOfNodes != null || node.oneOfNodes != null || node.anyOfNodes != null;

    if (hasCompositions) {
      // Simplified composition handling - for now, just use the typed schema as-is
      // Full implementation would enumerate branches, validate, and merge constraints
      return _createDirectEffectiveSchema(node, typed);
    } else {
      // No compositions - create direct effective schema
      return _createDirectEffectiveSchema(node, typed);
    }
  }

  /// Creates an effective schema directly from typed schema (no composition resolution).
  static EffectiveSchema _createDirectEffectiveSchema(SchemaNode node, TypedSchema typed) {
    switch (typed.type) {
      case SchemaType.integer:
        return IntegerEffectiveSchema.fromTyped(node, typed as IntegerTypedSchema);
      case SchemaType.number:
        return NumberEffectiveSchema.fromTyped(node, typed as NumberTypedSchema);
      case SchemaType.string:
        return StringEffectiveSchema.fromTyped(node, typed as StringTypedSchema);
      case SchemaType.boolean:
        return BooleanEffectiveSchema.fromTyped(node, typed as BooleanTypedSchema);
      case SchemaType.array:
        return ArrayEffectiveSchema.fromTyped(node, typed as ArrayTypedSchema);
      case SchemaType.object:
        return ObjectEffectiveSchema.fromTyped(node, typed as ObjectTypedSchema);
      default:
        return UnknownEffectiveSchema($node: node, description: typed.description);
    }
  }
}

abstract class SingleTypeEffectiveSchema<T, S extends SingleTypeEffectiveSchema<T, S>> extends EffectiveSchema<S> {
  final T? defaultValue;
  final List<T>? enumValues;

  SingleTypeEffectiveSchema(
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

class MultiTypeUnionEffectiveSchema extends EffectiveSchema<MultiTypeUnionEffectiveSchema> {
  final List<EffectiveSchema> variants;
  MultiTypeUnionEffectiveSchema({
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

class UnknownEffectiveSchema extends EffectiveSchema<UnknownEffectiveSchema> {
  UnknownEffectiveSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
  }) : super($node, SchemaType.unknown, description, readOnly, writeOnly, example, deprecated, nullable);
}
