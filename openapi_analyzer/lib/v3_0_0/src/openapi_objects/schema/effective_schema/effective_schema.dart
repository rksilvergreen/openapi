import '../schema.dart';
import '../typed_schema/typed_schema.dart';
import '../typed_schema/integer_typed_schema.dart';
import '../typed_schema/number_typed_schema.dart';
import '../typed_schema/string_typed_schema.dart';
import '../typed_schema/boolean_typed_schema.dart';
import '../typed_schema/array_typed_schema.dart';
import '../typed_schema/object_typed_schema.dart';
import '../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';
import 'integer_effective_schema.dart';
import 'number_effective_schema.dart';
import 'string_effective_schema.dart';
import 'boolean_effective_schema.dart';
import 'array_effective_schema.dart';
import 'object_effective_schema.dart';
import 'composition_resolver.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/effective_schema/effective_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/schema.dart';

abstract class EffectiveSchemaImpl<T extends EffectiveSchemaImpl<T>> implements EffectiveSchema<T> {
  final SchemaNode $node;
  final SchemaType type;
  final String? description;
  final bool readOnly;
  final bool writeOnly;
  final XMLNode? xml;
  final ExternalDocumentationNode? externalDocs;
  final Map<String, dynamic>? example;
  final bool deprecated;
  final bool nullable;

  EffectiveSchemaImpl(
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
  );

  List<EffectiveSchemaImpl>? get allOf => $node.allOf?.map((node) => node.$effective).toList();
  List<EffectiveSchemaImpl>? get oneOf => $node.oneOf?.map((node) => node.$effective).toList();
  List<EffectiveSchemaImpl>? get anyOf => $node.anyOf?.map((node) => node.$effective).toList();

  SchemaNode get raw => $node;
  TypedSchemaImpl get typed => $node.$typed;

  /// Creates an EffectiveSchemaImpl from a SchemaNode and its TypedSchemaImpl.
  static EffectiveSchemaImpl fromTyped(SchemaNode node, TypedSchemaImpl typed, ValidationContext ctx) {
    // Check if schema has compositions
    final hasCompositions = node.allOf != null || node.oneOf != null || node.anyOf != null;

    if (hasCompositions) {
      return _createWithCompositions(node, typed, ctx);
    } else {
      // No compositions - create direct effective schema
      return _createDirectEffectiveSchemaImpl(node, typed);
    }
  }

  /// Creates an effective schema with full composition resolution.
  static EffectiveSchemaImpl _createWithCompositions(SchemaNode node, TypedSchemaImpl typed, ValidationContext ctx) {
    final resolver = CompositionResolver(node, typed, ctx);

    // 1. Enumerate branches from applicator graph
    final branches = resolver.enumerateBranches();

    // 2. Validate each branch
    final validBranches = branches.where((b) => resolver.validateBranch(b)).toList();

    if (validBranches.isEmpty && branches.isNotEmpty) {
      ctx.addException(
        OpenApiValidationException(
          node.$id.absolutePointer,
          'All composition branches are unsatisfiable due to type conflicts or constraint incompatibilities',
          severity: ValidationSeverity.critical,
        ),
      );
      // Fall back to direct schema creation
      return _createDirectEffectiveSchemaImpl(node, typed);
    }

    // 3. Determine if multi-type
    if (resolver.spansMultipleTypes(validBranches)) {
      // Multiple types - create variants for each type
      final variants = _createVariants(node, validBranches, resolver, ctx);
      return MultiTypeUnionEffectiveSchemaImpl(
        $node: node,
        description: typed.description,
        readOnly: typed.readOnly,
        writeOnly: typed.writeOnly,
        example: typed.example,
        deprecated: typed.deprecated,
        nullable: typed.nullable,
        variants: variants,
      );
    }

    // 4. Single type - merge constraints from all branches
    if (validBranches.length == 1) {
      // Single branch - merge constraints
      final mergedTyped = resolver.mergeConstraints(validBranches.first.nodes);
      return _createDirectEffectiveSchemaImpl(node, mergedTyped);
    } else if (node.oneOf != null && node.oneOf!.isNotEmpty) {
      // Multiple oneOf branches - create variants
      return _createOneOfVariants(node, typed, validBranches, resolver, ctx);
    } else {
      // Multiple branches (anyOf/allOf) - merge all constraints
      final allNodes = validBranches.expand((b) => b.nodes).toSet().toList();
      final mergedTyped = resolver.mergeConstraints(allNodes);
      return _createDirectEffectiveSchemaImpl(node, mergedTyped);
    }
  }

  /// Creates variants from branches spanning multiple types.
  static List<EffectiveSchemaImpl> _createVariants(
    SchemaNode node,
    List<Branch> branches,
    CompositionResolver resolver,
    ValidationContext ctx,
  ) {
    final variantsByType = <SchemaType, List<Branch>>{};
    for (var branch in branches) {
      if (branch.resolvedType != null) {
        variantsByType.putIfAbsent(branch.resolvedType!, () => []).add(branch);
      }
    }

    return variantsByType.entries.map((entry) {
      final typeBranches = entry.value;

      // Merge constraints for this type
      final allNodes = typeBranches.expand((b) => b.nodes).toSet().toList();
      final mergedTyped = resolver.mergeConstraints(allNodes);

      return _createDirectEffectiveSchemaImpl(node, mergedTyped);
    }).toList();
  }

  /// Creates variants for oneOf branches.
  static EffectiveSchemaImpl _createOneOfVariants(
    SchemaNode node,
    TypedSchemaImpl typed,
    List<Branch> branches,
    CompositionResolver resolver,
    ValidationContext ctx,
  ) {
    // For oneOf, each branch represents a distinct variant
    // Check if variants have different constraints (worth creating variants)

    if (branches.length <= 1) {
      // Only one valid branch, no need for variants
      final mergedTyped = resolver.mergeConstraints(branches.first.nodes);
      return _createDirectEffectiveSchemaImpl(node, mergedTyped);
    }

    // For now, just merge all branches (simplified approach)
    // Full implementation would create distinct variants for each oneOf option
    final allNodes = branches.expand((b) => b.nodes).toSet().toList();
    final mergedTyped = resolver.mergeConstraints(allNodes);
    return _createDirectEffectiveSchemaImpl(node, mergedTyped);
  }

  /// Creates an effective schema directly from typed schema (no composition resolution).
  static EffectiveSchemaImpl _createDirectEffectiveSchemaImpl(SchemaNode node, TypedSchemaImpl typed) {
    switch (typed.type) {
      case SchemaType.integer:
        return IntegerEffectiveSchemaImpl.fromTyped(node, typed as IntegerTypedSchemaImpl);
      case SchemaType.number:
        return NumberEffectiveSchemaImpl.fromTyped(node, typed as NumberTypedSchemaImpl);
      case SchemaType.string:
        return StringEffectiveSchemaImpl.fromTyped(node, typed as StringTypedSchemaImpl);
      case SchemaType.boolean:
        return BooleanEffectiveSchemaImpl.fromTyped(node, typed as BooleanTypedSchemaImpl);
      case SchemaType.array:
        return ArrayEffectiveSchemaImpl.fromTyped(node, typed as ArrayTypedSchemaImpl);
      case SchemaType.object:
        return ObjectEffectiveSchemaImpl.fromTyped(node, typed as ObjectTypedSchemaImpl);
      default:
        return UnknownEffectiveSchemaImpl($node: node, description: typed.description);
    }
  }
}

abstract class SingleTypeEffectiveSchemaImpl<T, S extends SingleTypeEffectiveSchemaImpl<T, S>>
    extends EffectiveSchemaImpl<S> {
  final T? defaultValue;
  final List<T>? enumValues;

  SingleTypeEffectiveSchemaImpl(
    super.$node,
    super.type,
    super.description,
    super.readOnly,
    super.writeOnly,
    super.xml,
    super.externalDocs,
    super.example,
    super.deprecated,
    super.nullable,
    this.defaultValue,
    this.enumValues,
  );
}

class MultiTypeUnionEffectiveSchemaImpl extends EffectiveSchemaImpl<MultiTypeUnionEffectiveSchemaImpl> {
  final List<EffectiveSchemaImpl> variants;
  MultiTypeUnionEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    required this.variants,
  }) : super(
         $node,
         SchemaType.multiType,
         description,
         readOnly,
         writeOnly,
         xml,
         externalDocs,
         example,
         deprecated,
         nullable,
       );
}

class UnknownEffectiveSchemaImpl extends EffectiveSchemaImpl<UnknownEffectiveSchemaImpl> {
  UnknownEffectiveSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
  }) : super(
         $node,
         SchemaType.unknown,
         description,
         readOnly,
         writeOnly,
         xml,
         externalDocs,
         example,
         deprecated,
         nullable,
       );
}
