import '../schema.dart';
import '../schema_type.dart';
import '../typed_schema/typed_schema.dart';
import '../typed_schema/integer_typed_schema.dart';
import '../typed_schema/number_typed_schema.dart';
import '../typed_schema/string_typed_schema.dart';
import '../typed_schema/boolean_typed_schema.dart';
import '../typed_schema/array_typed_schema.dart';
import '../typed_schema/object_typed_schema.dart';
import '../../../../validation/validation_context.dart';
import 'dart:math' as math;

/// Represents a branch in the composition tree.
class Branch {
  final List<SchemaNode> nodes;
  final SchemaType? resolvedType;

  Branch(this.nodes, this.resolvedType);

  @override
  String toString() => 'Branch(${nodes.length} nodes, type: $resolvedType)';
}

/// Handles composition resolution for schemas with allOf, oneOf, anyOf.
class CompositionResolver {
  final SchemaNode rootNode;
  final TypedSchema rootTyped;
  final ValidationContext ctx;

  CompositionResolver(this.rootNode, this.rootTyped, this.ctx);

  /// Enumerates all branches from the applicator graph.
  List<Branch> enumerateBranches() {
    // Start with a branch containing just the root node
    List<Branch> branches = [
      Branch([rootNode], rootTyped.type),
    ];

    // Handle allOf - all schemas must be satisfied (intersection)
    if (rootNode.allOfNodes != null && rootNode.allOfNodes!.isNotEmpty) {
      branches = _expandAllOf(branches, rootNode.allOfNodes!);
    }

    // Handle oneOf - exactly one schema must be satisfied (exclusive union)
    if (rootNode.oneOfNodes != null && rootNode.oneOfNodes!.isNotEmpty) {
      branches = _expandOneOf(branches, rootNode.oneOfNodes!);
    }

    // Handle anyOf - at least one schema must be satisfied (inclusive union)
    if (rootNode.anyOfNodes != null && rootNode.anyOfNodes!.isNotEmpty) {
      branches = _expandAnyOf(branches, rootNode.anyOfNodes!);
    }

    return branches;
  }

  /// Expands branches with allOf (adds schemas to each branch).
  List<Branch> _expandAllOf(List<Branch> currentBranches, List<SchemaNode> allOfNodes) {
    // allOf means ALL schemas must be satisfied - add all to each branch
    return currentBranches.map((branch) {
      final newNodes = [...branch.nodes, ...allOfNodes];
      final resolvedType = _resolveTypeForBranch(newNodes);
      return Branch(newNodes, resolvedType);
    }).toList();
  }

  /// Expands branches with oneOf (creates new branches for each alternative).
  List<Branch> _expandOneOf(List<Branch> currentBranches, List<SchemaNode> oneOfNodes) {
    // oneOf means exactly ONE schema must be satisfied - create separate branches
    final expandedBranches = <Branch>[];
    for (var branch in currentBranches) {
      for (var oneOfNode in oneOfNodes) {
        final newNodes = [...branch.nodes, oneOfNode];
        final resolvedType = _resolveTypeForBranch(newNodes);
        expandedBranches.add(Branch(newNodes, resolvedType));
      }
    }
    return expandedBranches;
  }

  /// Expands branches with anyOf (creates new branches for each alternative).
  List<Branch> _expandAnyOf(List<Branch> currentBranches, List<SchemaNode> anyOfNodes) {
    // anyOf means at least ONE schema must be satisfied - create separate branches
    // Similar to oneOf but less strict (allows multiple to be satisfied)
    final expandedBranches = <Branch>[];
    for (var branch in currentBranches) {
      for (var anyOfNode in anyOfNodes) {
        final newNodes = [...branch.nodes, anyOfNode];
        final resolvedType = _resolveTypeForBranch(newNodes);
        expandedBranches.add(Branch(newNodes, resolvedType));
      }
    }
    return expandedBranches;
  }

  /// Resolves the type for a branch by checking type consistency.
  SchemaType? _resolveTypeForBranch(List<SchemaNode> nodes) {
    SchemaType? commonType;

    for (var node in nodes) {
      if (!node.isTypedSchemaSet) continue;

      final nodeType = node.typed.type;
      if (nodeType == SchemaType.unknown) continue;

      if (commonType == null) {
        commonType = nodeType;
      } else if (commonType != nodeType) {
        // Type conflict - this branch is invalid
        return null;
      }
    }

    return commonType ?? rootTyped.type;
  }

  /// Validates a branch for consistency.
  bool validateBranch(Branch branch) {
    // Check type consistency
    if (branch.resolvedType == null) {
      return false; // Type conflict
    }

    // For now, accept all branches with consistent types
    // Future: Add constraint compatibility checks
    return true;
  }

  /// Checks if branches span multiple types.
  bool spansMultipleTypes(List<Branch> branches) {
    final types = <SchemaType>{};
    for (var branch in branches) {
      if (branch.resolvedType != null && branch.resolvedType != SchemaType.unknown) {
        types.add(branch.resolvedType!);
      }
    }
    return types.length > 1;
  }

  /// Merges constraints from multiple typed schemas.
  TypedSchema mergeConstraints(List<SchemaNode> nodes) {
    final typedSchemas = nodes.where((n) => n.isTypedSchemaSet).map((n) => n.typed).toList();

    if (typedSchemas.isEmpty) {
      return rootTyped;
    }

    // Get the base schema (first one or root)
    final baseTyped = typedSchemas.first;

    switch (baseTyped.type) {
      case SchemaType.integer:
        return _mergeIntegerConstraints(typedSchemas.cast<IntegerTypedSchema>());
      case SchemaType.number:
        return _mergeNumberConstraints(typedSchemas.cast<NumberTypedSchema>());
      case SchemaType.string:
        return _mergeStringConstraints(typedSchemas.cast<StringTypedSchema>());
      case SchemaType.boolean:
        return _mergeBooleanConstraints(typedSchemas.cast<BooleanTypedSchema>());
      case SchemaType.array:
        return _mergeArrayConstraints(typedSchemas.cast<ArrayTypedSchema>());
      case SchemaType.object:
        return _mergeObjectConstraints(typedSchemas.cast<ObjectTypedSchema>());
      default:
        return baseTyped;
    }
  }

  IntegerTypedSchema _mergeIntegerConstraints(List<IntegerTypedSchema> schemas) {
    int? minimum;
    int? maximum;
    int? exclusiveMinimum;
    int? exclusiveMaximum;
    double? multipleOf;

    for (var schema in schemas) {
      // Merge minimum (take the maximum of all minimums - most restrictive)
      if (schema.minimum != null) {
        minimum = minimum == null ? schema.minimum : math.max(minimum, schema.minimum!);
      }
      if (schema.exclusiveMinimum != null) {
        exclusiveMinimum = exclusiveMinimum == null
            ? schema.exclusiveMinimum
            : math.max(exclusiveMinimum, schema.exclusiveMinimum!);
      }

      // Merge maximum (take the minimum of all maximums - most restrictive)
      if (schema.maximum != null) {
        maximum = maximum == null ? schema.maximum : math.min(maximum, schema.maximum!);
      }
      if (schema.exclusiveMaximum != null) {
        exclusiveMaximum = exclusiveMaximum == null
            ? schema.exclusiveMaximum
            : math.min(exclusiveMaximum, schema.exclusiveMaximum!);
      }

      // Merge multipleOf (for simplicity, take first non-null)
      multipleOf ??= schema.multipleOf;
    }

    return IntegerTypedSchema(
      $node: rootNode,
      description: schemas.first.description ?? '',
      readOnly: schemas.any((s) => s.readOnly),
      writeOnly: schemas.any((s) => s.writeOnly),
      example: schemas.first.example,
      deprecated: schemas.any((s) => s.deprecated),
      nullable: schemas.any((s) => s.nullable),
      defaultValue: schemas.first.defaultValue,
      enumValues: _mergeEnums(schemas.map((s) => s.enumValues).toList()) ?? [],
      minimum: minimum,
      maximum: maximum,
      exclusiveMinimum: exclusiveMinimum,
      exclusiveMaximum: exclusiveMaximum,
      multipleOf: multipleOf,
      format: schemas.first.format,
    );
  }

  NumberTypedSchema _mergeNumberConstraints(List<NumberTypedSchema> schemas) {
    double? minimum;
    double? maximum;
    double? exclusiveMinimum;
    double? exclusiveMaximum;
    double? multipleOf;

    for (var schema in schemas) {
      if (schema.minimum != null) {
        minimum = minimum == null ? schema.minimum : math.max(minimum, schema.minimum!);
      }
      if (schema.exclusiveMinimum != null) {
        exclusiveMinimum = exclusiveMinimum == null
            ? schema.exclusiveMinimum
            : math.max(exclusiveMinimum, schema.exclusiveMinimum!);
      }
      if (schema.maximum != null) {
        maximum = maximum == null ? schema.maximum : math.min(maximum, schema.maximum!);
      }
      if (schema.exclusiveMaximum != null) {
        exclusiveMaximum = exclusiveMaximum == null
            ? schema.exclusiveMaximum
            : math.min(exclusiveMaximum, schema.exclusiveMaximum!);
      }
      multipleOf ??= schema.multipleOf;
    }

    return NumberTypedSchema(
      $node: rootNode,
      description: schemas.first.description ?? '',
      readOnly: schemas.any((s) => s.readOnly),
      writeOnly: schemas.any((s) => s.writeOnly),
      example: schemas.first.example,
      deprecated: schemas.any((s) => s.deprecated),
      nullable: schemas.any((s) => s.nullable),
      defaultValue: schemas.first.defaultValue,
      enumValues: _mergeEnums(schemas.map((s) => s.enumValues).toList()) ?? [],
      minimum: minimum,
      maximum: maximum,
      exclusiveMinimum: exclusiveMinimum,
      exclusiveMaximum: exclusiveMaximum,
      multipleOf: multipleOf,
      format: schemas.first.format,
    );
  }

  StringTypedSchema _mergeStringConstraints(List<StringTypedSchema> schemas) {
    int? minLength;
    int? maxLength;
    String? pattern;

    for (var schema in schemas) {
      // Take the maximum of all minLengths (most restrictive)
      if (schema.minLength != null) {
        minLength = minLength == null ? schema.minLength : math.max(minLength, schema.minLength!);
      }
      // Take the minimum of all maxLengths (most restrictive)
      if (schema.maxLength != null) {
        maxLength = maxLength == null ? schema.maxLength : math.min(maxLength, schema.maxLength!);
      }
      // For pattern, take first non-null (combining patterns is complex)
      pattern ??= schema.pattern;
    }

    return StringTypedSchema(
      $node: rootNode,
      description: schemas.first.description ?? '',
      readOnly: schemas.any((s) => s.readOnly),
      writeOnly: schemas.any((s) => s.writeOnly),
      example: schemas.first.example,
      deprecated: schemas.any((s) => s.deprecated),
      nullable: schemas.any((s) => s.nullable),
      defaultValue: schemas.first.defaultValue,
      enumValues: _mergeEnums(schemas.map((s) => s.enumValues).toList()) ?? [],
      minLength: minLength,
      maxLength: maxLength,
      pattern: pattern,
      format: schemas.first.format,
    );
  }

  BooleanTypedSchema _mergeBooleanConstraints(List<BooleanTypedSchema> schemas) {
    return BooleanTypedSchema(
      $node: rootNode,
      description: schemas.first.description ?? '',
      readOnly: schemas.any((s) => s.readOnly),
      writeOnly: schemas.any((s) => s.writeOnly),
      example: schemas.first.example,
      deprecated: schemas.any((s) => s.deprecated),
      nullable: schemas.any((s) => s.nullable),
      defaultValue: schemas.first.defaultValue,
      enumValues: _mergeEnums(schemas.map((s) => s.enumValues).toList()) ?? [],
    );
  }

  ArrayTypedSchema _mergeArrayConstraints(List<ArrayTypedSchema> schemas) {
    int? minItems;
    int? maxItems;
    bool? uniqueItems;

    for (var schema in schemas) {
      if (schema.minItems != null) {
        minItems = minItems == null ? schema.minItems : math.max(minItems, schema.minItems!);
      }
      if (schema.maxItems != null) {
        maxItems = maxItems == null ? schema.maxItems : math.min(maxItems, schema.maxItems!);
      }
      if (schema.uniqueItems == true) {
        uniqueItems = true;
      }
    }

    return ArrayTypedSchema(
      $node: rootNode,
      description: schemas.first.description ?? '',
      readOnly: schemas.any((s) => s.readOnly),
      writeOnly: schemas.any((s) => s.writeOnly),
      example: schemas.first.example,
      deprecated: schemas.any((s) => s.deprecated),
      nullable: schemas.any((s) => s.nullable),
      defaultValue: schemas.first.defaultValue,
      enumValues: _mergeEnums(schemas.map((s) => s.enumValues).toList()) ?? [],
      items: rootNode.itemsNode,
      minItems: minItems,
      maxItems: maxItems,
      uniqueItems: uniqueItems,
    );
  }

  ObjectTypedSchema _mergeObjectConstraints(List<ObjectTypedSchema> schemas) {
    int? minProperties;
    int? maxProperties;
    final requiredSet = <String>{};

    for (var schema in schemas) {
      if (schema.minProperties != null) {
        minProperties = minProperties == null ? schema.minProperties : math.max(minProperties, schema.minProperties!);
      }
      if (schema.maxProperties != null) {
        maxProperties = maxProperties == null ? schema.maxProperties : math.min(maxProperties, schema.maxProperties!);
      }
      if (schema.required != null) {
        requiredSet.addAll(schema.required!);
      }
    }

    return ObjectTypedSchema(
      $node: rootNode,
      description: schemas.first.description ?? '',
      readOnly: schemas.any((s) => s.readOnly),
      writeOnly: schemas.any((s) => s.writeOnly),
      example: schemas.first.example,
      deprecated: schemas.any((s) => s.deprecated),
      nullable: schemas.any((s) => s.nullable),
      defaultValue: schemas.first.defaultValue,
      enumValues: _mergeEnums(schemas.map((s) => s.enumValues).toList()) ?? [],
      properties: rootNode.propertiesNodes,
      minProperties: minProperties,
      maxProperties: maxProperties,
      required: requiredSet.isEmpty ? null : requiredSet.toList(),
    );
  }

  /// Merges enum values (intersection of all enums).
  List<T>? _mergeEnums<T>(List<List<T>?> enumLists) {
    final nonNullEnums = enumLists.where((e) => e != null && e.isNotEmpty).toList();
    if (nonNullEnums.isEmpty) return null;
    if (nonNullEnums.length == 1) return nonNullEnums.first;

    // Take intersection of all enum values
    var intersection = nonNullEnums.first!.toSet();
    for (var enumList in nonNullEnums.skip(1)) {
      intersection = intersection.intersection(enumList!.toSet());
    }

    return intersection.isEmpty ? null : intersection.toList();
  }
}
