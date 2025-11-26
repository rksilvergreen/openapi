import 'package:code_builder/code_builder.dart';
import 'package:openapi_analyzer/openapi_analyzer.dart';
import 'package:recase/recase.dart';

import 'dart_type_mapper.dart';
import 'dart_name_generator.dart';

/// Generates Dart class code for object schemas using code_builder.
class ObjectClassGenerator {
  final DartTypeMapper typeMapper;
  final Map<String, String>? inlineEnumNames; // For resolving enum default values
  final Map<String, String>? inlineUnionNames; // For resolving union types

  ObjectClassGenerator(
    this.typeMapper, 
    {
      this.inlineEnumNames,
      this.inlineUnionNames,
    }
  );

  /// Generate a Dart class for an object schema.
  Class generateClass(SchemaObject schema, String className, {Reference? baseClass, SchemaObject? baseClassSchema}) {
    return Class((b) {
      b.name = className;

      // Add annotations
      b.annotations.addAll([
        refer('CopyWith', 'package:copy_with_extension/copy_with_extension.dart').call([]),
        refer('JsonSerializable', 'package:json_annotation/json_annotation.dart').call([]),
      ]);

      // Add extends clause if there's a base class
      // Note: If extending a custom class, don't also extend Equatable (base class should extend it)
      if (baseClass != null) {
        b.extend = baseClass;
      } else {
        // Extend Equatable
        b.extend = refer('Equatable', 'package:equatable/equatable.dart');
      }

      // Add fields
      if (schema.properties != null) {
        final required = schema.required_?.toSet() ?? <String>{};

        // Get base class property names to avoid duplicates
        final baseClassPropertyNames = baseClassSchema?.properties?.keys.toSet() ?? <String>{};

        for (final propEntry in schema.properties!.entries) {
          final originalPropName = propEntry.key;

          // Skip properties that already exist in the base class
          if (baseClassPropertyNames.contains(originalPropName)) {
            continue;
          }

          final propRef = propEntry.value;

          // Handle both references and inline schemas
          SchemaObject? propSchema;
          if (propRef.isReference()) {
            // Create a schema object with just the reference
            propSchema = SchemaObject(ref: propRef.asReference());
          } else {
            // Use the actual schema value
            propSchema = propRef.asValue();
          }

          if (propSchema != null) {
            // Create property path for inline enum lookup: ClassName.propertyName
            final propertyPath = '$className.${ReCase(originalPropName).camelCase}';
            final isRequired = required.contains(originalPropName);
            // Field nullability is based on whether it's required in the schema, not whether it's required in constructor
            // A required field with a default is still non-nullable, just not required in constructor
            final field = _generateField(
              originalPropName,
              propSchema,
              isRequired: isRequired,
              propertyPath: propertyPath,
            );
            b.fields.add(field);
          }
        }
      }

      // Add constructor
      b.constructors.add(_generateConstructor(schema, className, baseClassSchema: baseClassSchema));

      // Add props getter for Equatable
      // If extending a custom class, the props should call super.props
      b.methods.add(_generatePropsGetter(schema, hasBaseClass: baseClass != null, baseClassSchema: baseClassSchema));

      // Add fromJson factory
      b.methods.add(_generateFromJson(className));

      // Add toJson method
      b.methods.add(_generateToJson(className));

      // Add toString method
      b.methods.add(_generateToString());
    });
  }

  Field _generateField(String originalName, SchemaObject schema, {required bool isRequired, String? propertyPath}) {
    final dartName = ReCase(originalName).camelCase;
    final safeDartName = DartNameGenerator.handleDartKeywords(dartName);

    return Field((b) {
      b.name = safeDartName;
      b.modifier = FieldModifier.final$;
      b.type = typeMapper.mapSchemaToType(schema, nullable: !isRequired, propertyPath: propertyPath);

      // Add @JsonKey annotation
      b.annotations.add(
        refer(
          'JsonKey',
          'package:json_annotation/json_annotation.dart',
        ).call([], {'name': literalString(originalName, raw: true)}),
      );
    });
  }

  Constructor _generateConstructor(SchemaObject schema, String className, {SchemaObject? baseClassSchema}) {
    return Constructor((b) {
      b.docs.add('/// Returns a new [$className] instance.');

      // If we have a base class schema, we need to include its properties in constructor too
      if (baseClassSchema != null && baseClassSchema.properties != null) {
        final baseRequired = baseClassSchema.required_?.toSet() ?? <String>{};

        // Add base class properties first (they go to super)
        for (final originalPropName in baseClassSchema.properties!.keys) {
          final dartName = ReCase(originalPropName).camelCase;
          final safeDartName = DartNameGenerator.handleDartKeywords(dartName);
          final isRequired = baseRequired.contains(originalPropName);

          b.optionalParameters.add(
            Parameter((p) {
              p.name = safeDartName;
              p.named = true;
              p.toSuper = true; // Pass to super constructor

              if (isRequired) {
                p.required = true;
              }
            }),
          );
        }
      }

      // Then add this class's own properties
      if (schema.properties != null) {
        final required = schema.required_?.toSet() ?? <String>{};

        // Get base class property names to avoid duplicates
        final baseClassPropertyNames = baseClassSchema?.properties?.keys.toSet() ?? <String>{};

        for (final originalPropName in schema.properties!.keys) {
          // Skip properties that already exist in the base class
          if (baseClassPropertyNames.contains(originalPropName)) {
            continue;
          }

          final propRef = schema.properties![originalPropName];

          // Get the property schema to check for default values
          SchemaObject? propSchema;
          if (propRef != null && propRef.isReference()) {
            // For references, we can't get the default value directly
            // We'd need to resolve it, but for now, skip default for references
            propSchema = null;
          } else if (propRef != null) {
            propSchema = propRef.asValue();
          }

          final dartName = ReCase(originalPropName).camelCase;
          final safeDartName = DartNameGenerator.handleDartKeywords(dartName);
          final isRequired = required.contains(originalPropName);
          final hasDefault = propSchema?.default_ != null;

          // If property has a default value, it shouldn't be required in constructor
          final isRequiredInConstructor = isRequired && !hasDefault;

          // Generate default value code if present
          Code? defaultValueCode;
          if (hasDefault && propSchema != null) {
            final defaultValueExpr = _generateDefaultValue(
              propSchema.default_!,
              propSchema,
              propertyPath: '$className.$safeDartName',
            );
            defaultValueCode = defaultValueExpr.code;
          }

          b.optionalParameters.add(
            Parameter((p) {
              p.name = safeDartName;
              p.named = true;
              p.toThis = true; // This class's own property

              if (isRequiredInConstructor) {
                p.required = true;
              } else if (defaultValueCode != null) {
                p.defaultTo = defaultValueCode;
              }
            }),
          );
        }
      }
    });
  }

  Method _generatePropsGetter(SchemaObject schema, {bool hasBaseClass = false, SchemaObject? baseClassSchema}) {
    final propNames = <String>[];

    // Get base class property names to avoid duplicates
    final baseClassPropertyNames = baseClassSchema?.properties?.keys.toSet() ?? <String>{};

    if (schema.properties != null) {
      for (final originalPropName in schema.properties!.keys) {
        // Skip properties that already exist in the base class
        if (baseClassPropertyNames.contains(originalPropName)) {
          continue;
        }

        final dartName = ReCase(originalPropName).camelCase;
        final safeDartName = DartNameGenerator.handleDartKeywords(dartName);
        propNames.add(safeDartName);
      }
    }

    return Method((b) {
      b.annotations.add(refer('override'));
      b.type = MethodType.getter;
      b.name = 'props';
      b.returns = TypeReference(
        (t) => t
          ..symbol = 'List'
          ..types.add(refer('Object?')),
      );
      b.lambda = true;

      if (hasBaseClass) {
        // Include super.props when extending another class
        b.body = Code('[...super.props, ${propNames.join(', ')}]');
      } else {
        b.body = literalList(propNames.map((name) => refer(name))).code;
      }
    });
  }

  Method _generateFromJson(String className) {
    return Method((b) {
      b.name = 'fromJson';
      b.static = true;
      b.returns = refer(className);
      b.requiredParameters.add(
        Parameter((p) {
          p.name = 'json';
          p.type = TypeReference(
            (t) => t
              ..symbol = 'Map'
              ..types.addAll([refer('String'), refer('dynamic')]),
          );
        }),
      );
      b.lambda = true;
      b.body = refer('_\$${className}FromJson').call([refer('json')]).code;
    });
  }

  Method _generateToJson(String className) {
    return Method((b) {
      b.name = 'toJson';
      b.returns = TypeReference(
        (t) => t
          ..symbol = 'Map'
          ..types.addAll([refer('String'), refer('dynamic')]),
      );
      b.lambda = true;
      b.body = refer('_\$${className}ToJson').call([refer('this')]).code;
    });
  }

  Method _generateToString() {
    return Method((b) {
      b.annotations.add(refer('override'));
      b.name = 'toString';
      b.returns = refer('String');
      b.lambda = true;
      b.body = refer('toJson').call([]).property('toString').call([]).code;
    });
  }

  /// Generate a default value expression for a constructor parameter.
  Expression _generateDefaultValue(dynamic defaultValue, SchemaObject schema, {String? propertyPath}) {
    // Check if this property has an inline enum
    if (propertyPath != null && inlineEnumNames != null && inlineEnumNames!.containsKey(propertyPath)) {
      // This property uses an inline enum - need to find the enum value
      final enumClassName = inlineEnumNames![propertyPath]!;

      // Check if the default value matches an enum value
      if (schema.enum_ != null) {
        for (var i = 0; i < schema.enum_!.length; i++) {
          final enumValue = schema.enum_![i];
          if (_valuesEqual(defaultValue, enumValue)) {
            // Generate the enum value name
            final enumValueName = DartNameGenerator.normalizeIdentifier(enumValue.toString());
            // Reference the enum value: EnumClassName.enumValueName
            return refer(enumClassName).property(enumValueName);
          }
        }
      }
    }

    // Handle based on value type and schema type
    if (defaultValue is int) {
      return literal(defaultValue);
    } else if (defaultValue is double || defaultValue is num) {
      return literalNum(defaultValue);
    } else if (defaultValue is bool) {
      return literal(defaultValue);
    } else if (defaultValue is String) {
      return literalString(defaultValue);
    } else if (defaultValue is List) {
      return literalList(defaultValue.map((v) => _generateDefaultValue(v, SchemaObject())).toList());
    } else if (defaultValue is Map) {
      final mapEntries = <Expression, Expression>{};
      for (final entry in defaultValue.entries) {
        mapEntries[literalString(entry.key.toString())] = _generateDefaultValue(entry.value, SchemaObject());
      }
      return literalMap(mapEntries);
    } else {
      // Fallback to string representation
      return literalString(defaultValue.toString());
    }
  }

  /// Helper function to compare two values for equality, handling type conversions.
  bool _valuesEqual(dynamic a, dynamic b) {
    if (a == b) return true;

    if (a is num && b is num) {
      if (a is int && b is int) {
        return a == b;
      } else if (a is double && b is double) {
        return a == b;
      } else {
        return a.toDouble() == b.toDouble();
      }
    }

    return false;
  }
}
