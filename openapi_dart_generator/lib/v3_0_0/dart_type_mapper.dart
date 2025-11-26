import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/schema/schema_object.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/enums.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/referenceable.dart';

/// Maps OpenAPI SchemaObject types to Dart types using code_builder References.
class DartTypeMapper {
  final Map<String, String> _schemaClassNames;
  final Map<String, String> _inlineEnumNames; // Maps property path to enum class name
  final Map<String, String> _inlineUnionNames; // Maps property path to union class name

  DartTypeMapper(
    this._schemaClassNames, 
    {
      Map<String, String>? inlineEnumNames,
      Map<String, String>? inlineUnionNames,
    }
  ) : _inlineEnumNames = inlineEnumNames ?? {},
      _inlineUnionNames = inlineUnionNames ?? {};

  /// Map a SchemaObject to a code_builder Reference.
  Reference mapSchemaToType(SchemaObject schema, {bool nullable = false, String? propertyPath}) {
    Reference baseTypeRef;

    // Check for inline enum first (if propertyPath is provided)
    if (propertyPath != null && _inlineEnumNames.containsKey(propertyPath)) {
      baseTypeRef = refer(_inlineEnumNames[propertyPath]!);
    }
    // Check for inline union (if propertyPath is provided)
    else if (propertyPath != null && _inlineUnionNames.containsKey(propertyPath)) {
      baseTypeRef = refer(_inlineUnionNames[propertyPath]!);
    }
    // Check if this is a reference ($ref field)
    else if (schema.ref != null) {
      // Extract the class name from the reference string
      final refString = schema.ref!;

      // Special case: if it's product_specs.yaml, map to Map<String, dynamic>
      if (refString.contains('product_specs')) {
        baseTypeRef = TypeReference(
          (b) => b
            ..symbol = 'Map'
            ..types.addAll([refer('String'), refer('dynamic')]),
        );
      } else {
        String referencedName;

        if (refString.startsWith('#/')) {
          // Internal reference like '#/components/schemas/User' -> 'User'
          final parts = refString.split('/');
          referencedName = parts.isNotEmpty ? parts.last : 'dynamic';
        } else {
          // External file reference like 'address.yaml' -> 'Address'
          // Remove file extension and convert to PascalCase
          final fileName = refString.split('/').last; // Get filename if path
          final nameWithoutExt = fileName.replaceAll(RegExp(r'\.(yaml|yml|json)$'), '');
          referencedName = ReCase(nameWithoutExt).pascalCase;
        }

        baseTypeRef = refer(referencedName);
      }
    }
    // Check for reference to another schema (by title or component name)
    else if (schema.title != null && _schemaClassNames.containsKey(schema.title)) {
      baseTypeRef = refer(_schemaClassNames[schema.title]!);
    }
    // Check for union types (anyOf/oneOf)
    else if ((schema.anyOf != null && schema.anyOf!.isNotEmpty) ||
             (schema.oneOf != null && schema.oneOf!.isNotEmpty)) {
      // For union types, try to find the generated union class name
      // If it exists in our schema class names, use it
      // Otherwise default to dynamic (union type generation may have failed)
      if (schema.title != null && _schemaClassNames.containsKey(schema.title)) {
        baseTypeRef = refer(_schemaClassNames[schema.title]!);
      } else {
        // Union type without a title or not in our class names
        // This could be an inline union in a property
        // For now, default to dynamic
        baseTypeRef = refer('dynamic');
      }
    }
    // Check schema type
    else if (schema.type != null) {
      baseTypeRef = _mapPrimitiveType(schema);
    }
    // Default to dynamic if type is not specified
    else {
      baseTypeRef = refer('dynamic');
    }

    // Handle nullable
    final shouldBeNullable = nullable || schema.nullable == true;
    if (shouldBeNullable) {
      // Special case: dynamic is already nullable, so don't add '?'
      if (baseTypeRef.symbol == 'dynamic') {
        return baseTypeRef;
      }

      // For simple types, append '?' to the symbol
      if (baseTypeRef is! TypeReference) {
        return refer('${baseTypeRef.symbol}?');
      }
      // For TypeReference (complex types like List), convert to string representation
      // We know baseTypeRef is TypeReference here due to the is! check above
      final typeString = _typeReferenceToString(baseTypeRef);
      return refer('$typeString?');
    }

    return baseTypeRef;
  }

  String _typeReferenceToString(TypeReference typeRef) {
    final buffer = StringBuffer(typeRef.symbol);
    if (typeRef.types.isNotEmpty) {
      buffer.write('<');
      buffer.write(typeRef.types.map((t) => t.symbol).join(', '));
      buffer.write('>');
    }
    return buffer.toString();
  }

  Reference _mapPrimitiveType(SchemaObject schema) {
    switch (schema.type!) {
      case SchemaType.string:
        // Check for format
        if (schema.format == 'date-time' || schema.format == 'date') {
          return refer('DateTime');
        }
        return refer('String');

      case SchemaType.number:
        return refer('double');

      case SchemaType.integer:
        return refer('int');

      case SchemaType.boolean:
        return refer('bool');

      case SchemaType.array:
        Reference itemType;
        if (schema.items != null) {
          if (schema.items!.isReference()) {
            // Handle reference - extract the class name from the reference
            final refString = schema.items!.asReference()!;
            String referencedName;

            if (refString.startsWith('#/')) {
              // Internal reference like '#/components/schemas/User' to get 'User'
              final parts = refString.split('/');
              referencedName = parts.isNotEmpty ? parts.last : 'dynamic';
            } else {
              // External file reference like 'review.yaml' -> 'Review'
              // Remove file extension and convert to PascalCase
              final fileName = refString.split('/').last; // Get filename if path
              final nameWithoutExt = fileName.replaceAll(RegExp(r'\.(yaml|yml|json)$'), '');
              referencedName = ReCase(nameWithoutExt).pascalCase;
            }

            // Check if we have a class name for this reference
            if (_schemaClassNames.containsKey(referencedName)) {
              final className = _schemaClassNames[referencedName]!;
              itemType = refer(className);
            } else {
              // Fall back to the referenced name directly
              itemType = refer(referencedName);
            }
          } else {
            // Handle inline schema
            final itemSchema = schema.items!.asValue();
            if (itemSchema != null) {
              itemType = mapSchemaToType(itemSchema);
            } else {
              itemType = refer('dynamic');
            }
          }
        } else {
          itemType = refer('dynamic');
        }

        return TypeReference(
          (b) => b
            ..symbol = 'List'
            ..types.add(itemType),
        );

      case SchemaType.object:
        // Check if it's a map (only additionalProperties)
        if ((schema.properties == null || schema.properties!.isEmpty) && schema.additionalProperties != null) {
          // It's a map
          if (schema.additionalProperties is bool) {
            return TypeReference(
              (b) => b
                ..symbol = 'Map'
                ..types.addAll([refer('String'), refer('dynamic')]),
            );
          }
          // Handle typed additionalProperties
          if (schema.additionalProperties is Referenceable<SchemaObject>) {
            final additionalPropsRef = schema.additionalProperties as Referenceable<SchemaObject>;
            Reference valueType;

            if (additionalPropsRef.isReference()) {
              // It's a reference - resolve it
              final refString = additionalPropsRef.asReference()!;
              valueType = mapSchemaToType(SchemaObject(ref: refString), nullable: false);
            } else {
              // It's an inline schema - map its type
              final additionalPropsSchema = additionalPropsRef.asValue();
              if (additionalPropsSchema != null) {
                valueType = mapSchemaToType(additionalPropsSchema, nullable: false);
              } else {
                valueType = refer('dynamic');
              }
            }

            return TypeReference(
              (b) => b
                ..symbol = 'Map'
                ..types.addAll([refer('String'), valueType]),
            );
          }
        }
        // Default to Map<String, dynamic>
        return TypeReference(
          (b) => b
            ..symbol = 'Map'
            ..types.addAll([refer('String'), refer('dynamic')]),
        );

      case SchemaType.null_:
        return refer('Null');
    }
  }
}
