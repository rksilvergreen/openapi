import '../lib/v3_0_0/parser/src/schema_object.dart';
import 'atomic_schema_object.dart';

class SemanticSchemaValidator {
  void validateSchema(SchemaObject schema) {
    /// TO DO
  }

  /// #########################################################
  /// # Atomic Schema Object
  /// #########################################################

  AtomicSchemaObject getAtomicSchema(SchemaObject schema) {
    SchemaType type = _getAtomicSchemaType(schema);
    final atomicSchema = AtomicSchemaObject.fromSchemaObject(schema, type);
    _validateAtomicConstraints(atomicSchema);
    return atomicSchema;
  }

  SchemaType _getAtomicSchemaType(SchemaObject schema) {
    SchemaType type = _getAtomicSchemaExplicitType(schema);
    if (type != SchemaType.unknown) {
      return type;
    }
    type = _getAtomicSchemaImplicitType(schema);
    if (type != SchemaType.unknown) {
      return type;
    }
    return SchemaType.unknown;
  }

  SchemaType _getAtomicSchemaExplicitType(SchemaObject schema) {
    /// TO DO
    return SchemaType.unknown;
  }

  SchemaType _getAtomicSchemaImplicitType(SchemaObject schema) {
    /// Validate that there are no properties from different types
    return SchemaType.unknown;
  }

  void _validateAtomicConstraints(atomicSchema) {
    /// validate constraints for the given type
  }

  /// #########################################################
  /// # Atomic Schema List
  /// #########################################################

  AtomicSchemaObject getAtomicSchemaListEquivalent(List<AtomicSchemaObject> atomicSchemaList) {
    SchemaType type = atomicSchemaList.first.type;
    return switch (type) {
      SchemaType.string => _getStringAtomicSchemaListEquivalent(atomicSchemaList as List<StringAtomicSchemaObject>),
      _ => throw Exception('Invalid schema type: $type'),
    };
  }

  StringAtomicSchemaObject _getStringAtomicSchemaListEquivalent(List<StringAtomicSchemaObject> stringAtomicSchemaList) {
    String? defaultValue = _getEquivalentDefaultValue(stringAtomicSchemaList);
    bool nullable = _getEquivalentNullable(stringAtomicSchemaList);
    int? maxLength = _getEquivalentMaxLength(stringAtomicSchemaList);
    int? minLength = _getEquivalentMinLength(stringAtomicSchemaList);
    String? pattern = _getEquivalentPattern(stringAtomicSchemaList);
    String? format = _getEquivalentFormat(stringAtomicSchemaList);

    final stringAtomicSchema = StringAtomicSchemaObject(defaultValue, nullable, maxLength, minLength, pattern, format);
    _validateAtomicConstraints(stringAtomicSchema);
    return stringAtomicSchema;
  }

  bool _getEquivalentNullable(List<StringAtomicSchemaObject> stringAtomicSchemaList) {
    bool nullable = stringAtomicSchemaList.first.nullable;
    for (final stringAtomicSchema in stringAtomicSchemaList) {
      if (stringAtomicSchema.nullable != nullable) {
        throw Exception('Invalid nullable: ${stringAtomicSchema.nullable}');
      }
    }
    return nullable;
  }

  String? _getEquivalentDefaultValue(List<StringAtomicSchemaObject> stringAtomicSchemaList) {
    String? defaultValue = stringAtomicSchemaList.first.defaultValue;
    for (final stringAtomicSchema in stringAtomicSchemaList) {
      if (stringAtomicSchema.defaultValue != null) {
        if (defaultValue == null) {
        defaultValue = stringAtomicSchema.defaultValue;
        }
        else if (stringAtomicSchema.defaultValue != defaultValue) {
          throw Exception('Invalid defaultValue: ${stringAtomicSchema.defaultValue}');
        }
      }
    }
    return defaultValue;
  }

  int? _getEquivalentMaxLength(List<StringAtomicSchemaObject> stringAtomicSchemaList) {
    int? maxLength = stringAtomicSchemaList.first.maxLength;
    for (StringAtomicSchemaObject stringAtomicSchema in stringAtomicSchemaList) {
      if (stringAtomicSchema.maxLength != null && (maxLength == null || (stringAtomicSchema.maxLength! > maxLength))) {
        maxLength = stringAtomicSchema.maxLength;
      }
    }
    return maxLength;
  }

  int? _getEquivalentMinLength(List<StringAtomicSchemaObject> stringAtomicSchemaList) {
    int? minLength = stringAtomicSchemaList.first.minLength;
    for (StringAtomicSchemaObject stringAtomicSchema in stringAtomicSchemaList) {
      if (stringAtomicSchema.minLength != null && (minLength == null || (stringAtomicSchema.minLength! < minLength))) {
        minLength = stringAtomicSchema.minLength;
      }
    }
    return minLength;
  }

  String? _getEquivalentPattern(List<StringAtomicSchemaObject> stringAtomicSchemaList) {
    String? pattern = stringAtomicSchemaList.first.pattern;
    for (final stringAtomicSchema in stringAtomicSchemaList) {
      if (stringAtomicSchema.pattern != null) {
        if (pattern == null) {
        pattern = stringAtomicSchema.pattern;
        }
        else if (stringAtomicSchema.pattern != pattern) {
          throw Exception('Invalid pattern: ${stringAtomicSchema.pattern}');
        }
      }
    }
    return pattern;
  }

  String? _getEquivalentFormat(List<StringAtomicSchemaObject> stringAtomicSchemaList) {
    String? format = stringAtomicSchemaList.first.format;
    for (final stringAtomicSchema in stringAtomicSchemaList) {
      if (stringAtomicSchema.format != null) {
        if (format == null) {
        format = stringAtomicSchema.format;
        }
        else if (stringAtomicSchema.format != format) {
          throw Exception('Invalid format: ${stringAtomicSchema.format}');
        }
      }
    }
    return format;
  }
}

// Why dont we use reference resolved,validated SchemaObjects as the final form?
// Because the schema needs to be flattened for the final form. We don't want to put the onus on the generator to flatten the schema.
//
// Why dont we use SchemaObjects for branch resolution (branch flattening)?
// Branch resolution is done on atomic schemas, and the result of branch reolution is an atomic schema.
//
// Do we do branch resolution recursively?
// We start with outlining the branches as SchemaObjects.
// We then resolve each branch recursively.
// We start with the leaves.
// The leaf SchemaObject is converted to an AtomicSchemaObject.
// Does it then get converted into a Schema? **why not? when better?
// Maybe a super structure that contains the SchemaObject and the AtomicSchemaObject and the Schema?



// branches are made of atomic schema objects
// resolve branches
// 


// can there be circular references? For allOf nad/or oneOf? If not, we must validate for this. 
// We need to make a distinction between the scheme object tree of nested schema via schema properties,
// and the schema object tree of nested schema via allOf and/or oneOf.
// Then we can map those trees and traverse them