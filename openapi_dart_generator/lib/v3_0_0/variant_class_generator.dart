import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/schema/schema_object.dart';
import 'package:openapi_dart_generator/src/models/v3_0_0/enums.dart';

/// Generates concrete variant classes that implement interfaces.
///
/// Implements patterns from GENERATION_ALGORITHM.md:
/// - Rule 3a: allOf simple → Concrete class implements parent
/// - Variant classes for oneOf schemas
/// - Wrapper classes for hybrid schemas
class VariantClassGenerator {
  /// Generate a concrete class that implements one or more interfaces.
  ///
  /// Parameters:
  /// - className: Name of the class to generate
  /// - schema: The schema definition
  /// - interfaces: List of interface names this class implements
  /// - discriminatorProperty: If present, adds const discriminator field
  /// - discriminatorValue: The value for the const discriminator field
  /// - parentProperties: Properties from parent interfaces to override
  /// - parentRequired: Required fields from parent schema
  /// - descendants: List of class names that extend this class (for custom fromJson)
  /// - descendantsRequiredProps: Map of descendant class -> list of its required properties
  Class generateVariantClass({
    required String className,
    required SchemaObject schema,
    required List<String> interfaces,
    String? discriminatorProperty,
    String? discriminatorValue,
    Map<String, SchemaObject>? parentProperties,
    List<String>? parentRequired,
    List<String>? descendants,
    Map<String, List<String>>? descendantsRequiredProps,
  }) {
    return Class((b) {
      b.name = className;

      // Annotations
      b.annotations.add(refer('CopyWith', 'package:copy_with_extension/copy_with_extension.dart').call([]));
      b.annotations.add(refer('JsonSerializable', 'package:json_annotation/json_annotation.dart').call([]));

      // Always extend Equatable (NEVER extend base classes - use implements)
      b.extend = refer('Equatable', 'package:equatable/equatable.dart');

      // Implements interfaces (deduplicate to avoid implementing the same interface twice)
      if (interfaces.isNotEmpty) {
        final uniqueInterfaces = interfaces.toSet().toList();
        b.implements.addAll(uniqueInterfaces.map((i) => refer(i)));
      }

      // Generate constructor
      b.constructors.add(
        _generateConstructor(className, schema, discriminatorProperty, parentProperties, parentRequired),
      );

      // Generate fields
      final fields = <String, SchemaObject>{};

      // Add discriminator field if present
      if (discriminatorProperty != null && discriminatorValue != null) {
        b.fields.add(_generateDiscriminatorField(discriminatorProperty, discriminatorValue));
        // Add discriminator field to fields map so it's included in props
        // Use a dummy schema since it's a const field with a default value
        fields[discriminatorProperty] = SchemaObject(type: SchemaType.string);
      }

      // Merge required fields from parent and current schema
      final allRequired = <String>{};
      if (parentRequired != null) {
        allRequired.addAll(parentRequired);
      }
      if (schema.required_ != null) {
        allRequired.addAll(schema.required_!);
      }

      // Add parent properties with @override
      // In the new hierarchy, we always duplicate fields from parent interfaces
      if (parentProperties != null) {
        for (final entry in parentProperties.entries) {
          // Skip discriminator property (it's already generated as const)
          if (entry.key == discriminatorProperty) {
            continue;
          }

          final isRequired = allRequired.contains(entry.key);
          b.fields.add(
            _generateField(entry.key, entry.value, isOverride: true, isDiscriminator: false, isRequired: isRequired),
          );
          fields[entry.key] = entry.value;
        }
      }

      // Add own properties
      if (schema.properties != null) {
        for (final entry in schema.properties!.entries) {
          final propName = entry.key;
          final propSchema = entry.value.asValue();

          if (propSchema != null && propName != discriminatorProperty && !fields.containsKey(propName)) {
            final isRequired = allRequired.contains(propName);
            b.fields.add(_generateField(propName, propSchema, isRequired: isRequired));
            fields[propName] = propSchema;
          }
        }
      }

      // canParse methods are no longer generated - logic is moved to parent interface's fromJson

      // Generate props getter
      b.methods.add(_generatePropsGetter(fields.keys.toList()));

      // Calculate base class required fields (merge parent and own required) for fromJson validation
      final baseRequiredForFromJson = <String>{};
      if (parentRequired != null) {
        baseRequiredForFromJson.addAll(parentRequired);
      }
      if (schema.required_ != null) {
        baseRequiredForFromJson.addAll(schema.required_!);
      }
      final baseRequiredList = baseRequiredForFromJson.toList();

      // Generate fromJson factory
      b.methods.add(_generateFromJsonFactory(className, descendants, descendantsRequiredProps, baseRequiredList));

      // Generate toJson method
      b.methods.add(_generateToJsonMethod(className));

      // Generate toString method
      b.methods.add(_generateToStringMethod());
    });
  }

  /// Generate a const discriminator field with a literal value.
  Field _generateDiscriminatorField(String propertyName, String value) {
    return Field((f) {
      f.name = ReCase(propertyName).camelCase;
      f.modifier = FieldModifier.final$;
      f.type = refer('String');
      f.assignment = literalString(value).code;
      f.annotations.add(
        refer(
          'JsonKey',
          'package:json_annotation/json_annotation.dart',
        ).call([], {'name': literalString(propertyName, raw: true)}),
      );
      f.annotations.add(refer('override'));
    });
  }

  /// Generate a field for a property.
  Field _generateField(
    String propertyName,
    SchemaObject schema, {
    bool isOverride = false,
    bool isDiscriminator = false,
    bool isRequired = false,
  }) {
    return Field((f) {
      f.name = ReCase(propertyName).camelCase;
      f.modifier = FieldModifier.final$;
      // Field is nullable if schema is explicitly nullable OR if it's not required
      final isNullable = schema.nullable == true || !isRequired;
      f.type = _mapToType(schema, isNullable: isNullable);
      f.annotations.add(
        refer(
          'JsonKey',
          'package:json_annotation/json_annotation.dart',
        ).call([], {'name': literalString(propertyName, raw: true)}),
      );

      if (isOverride && !isDiscriminator) {
        f.annotations.add(refer('override'));
      }
    });
  }

  /// Generate constructor.
  Constructor _generateConstructor(
    String className,
    SchemaObject schema,
    String? discriminatorProperty,
    Map<String, SchemaObject>? parentProperties,
    List<String>? parentRequired,
  ) {
    return Constructor((c) {
      // Collect all properties (parent + own)
      final allProperties = <String, SchemaObject>{};

      if (parentProperties != null) {
        allProperties.addAll(parentProperties);
      }

      if (schema.properties != null) {
        for (final entry in schema.properties!.entries) {
          final propSchema = entry.value.asValue();
          if (propSchema != null) {
            allProperties[entry.key] = propSchema;
          }
        }
      }

      // Merge required fields from parent and current schema
      final allRequired = <String>{};
      if (parentRequired != null) {
        allRequired.addAll(parentRequired);
      }
      if (schema.required_ != null) {
        allRequired.addAll(schema.required_!);
      }

      // Generate parameters for all properties (no super parameters in new hierarchy)
      for (final entry in allProperties.entries) {
        final propName = entry.key;
        final propSchema = entry.value;

        // Skip discriminator property (it's const)
        if (propName == discriminatorProperty) {
          continue;
        }

        final dartName = ReCase(propName).camelCase;
        final isRequired = allRequired.contains(propName);

        c.optionalParameters.add(
          Parameter((p) {
            p.name = dartName;
            p.named = true;
            p.toThis = true;
            p.required = isRequired && propSchema.nullable != true;
          }),
        );
      }
    });
  }

  /// Generate canParse static method for structural discrimination.
  /// Generate props getter.
  Method _generatePropsGetter(List<String> fieldNames) {
    return Method((m) {
      m.name = 'props';
      m.type = MethodType.getter;
      m.returns = refer('List<Object?>');
      m.annotations.add(refer('override'));

      // In the new hierarchy, we always list all fields explicitly (never use super.props)
      m.lambda = true;
      final propsList = fieldNames.map((name) => refer(ReCase(name).camelCase));
      m.body = literalList(propsList).code;
    });
  }

  /// Generate fromJson factory.
  Method _generateFromJsonFactory(
    String className,
    List<String>? descendants,
    Map<String, List<String>>? descendantsRequiredProps,
    List<String> baseRequiredFields,
  ) {
    return Method((m) {
      m.name = 'fromJson';
      m.static = true;
      m.returns = refer(className);
      m.requiredParameters.add(
        Parameter((p) {
          p.name = 'json';
          p.type = refer('Map<String, dynamic>');
        }),
      );

      // If no descendants, use simple arrow function
      if (descendants == null || descendants.isEmpty) {
        m.lambda = true;
        m.body = refer('_\$${className}FromJson').call([refer('json')]).code;
      } else {
        // Generate custom logic to check descendants
        m.body = _generateFromJsonWithDescendants(
          className,
          descendants,
          descendantsRequiredProps ?? {},
          baseRequiredFields,
        );
      }
    });
  }

  /// Generate fromJson body with descendant checking logic.
  Code _generateFromJsonWithDescendants(
    String className,
    List<String> descendants,
    Map<String, List<String>> descendantsRequiredProps,
    List<String> baseRequiredFields,
  ) {
    final buffer = StringBuffer();

    // Sort descendants by number of required properties (descending) to check most specific first
    final sortedDescendants = [...descendants];
    sortedDescendants.sort((a, b) {
      final aProps = descendantsRequiredProps[a]?.length ?? 0;
      final bProps = descendantsRequiredProps[b]?.length ?? 0;
      return bProps.compareTo(aProps);
    });

    // Generate if-else chain
    for (var i = 0; i < sortedDescendants.length; i++) {
      final descendant = sortedDescendants[i];
      final requiredProps = descendantsRequiredProps[descendant] ?? [];

      if (i == 0) {
        buffer.write('if (');
      } else {
        buffer.write(' else if (');
      }

      // Generate containsKey checks for required properties
      if (requiredProps.isNotEmpty) {
        final checks = requiredProps.map((prop) => "json.containsKey('$prop')").join(' &&\n        ');
        buffer.write(checks);
      } else {
        // No required properties to check, this shouldn't happen but handle it
        buffer.write('true');
      }

      buffer.writeln(') {');
      buffer.writeln('      return $descendant.fromJson(json);');
      buffer.write('    }');
    }

    // Default case: check base class required fields, then create base class instance
    buffer.writeln(' else {');
    if (baseRequiredFields.isNotEmpty) {
      // Check if base class required fields are present
      final baseChecks = baseRequiredFields.map((prop) => "json.containsKey('$prop')").join(' &&\n        ');
      buffer.writeln('      if ($baseChecks) {');
      buffer.writeln('        return _\$${className}FromJson(json);');
      buffer.writeln('      } else {');
      buffer.writeln("        throw Exception('Invalid JSON');");
      buffer.writeln('      }');
    } else {
      // No required fields, just create the instance
      buffer.writeln('      return _\$${className}FromJson(json);');
    }
    buffer.writeln('    }');

    return Code(buffer.toString());
  }

  /// Generate toJson method.
  Method _generateToJsonMethod(String className) {
    return Method((m) {
      m.name = 'toJson';
      m.returns = refer('Map<String, dynamic>');
      m.lambda = true;
      m.body = refer('_\$${className}ToJson').call([refer('this')]).code;
    });
  }

  /// Generate toString method.
  Method _generateToStringMethod() {
    return Method((m) {
      m.name = 'toString';
      m.returns = refer('String');
      m.annotations.add(refer('override'));
      m.lambda = true;
      m.body = refer('toJson').call([]).property('toString').call([]).code;
    });
  }

  /// Map a schema to a Dart type reference.
  Reference _mapToType(SchemaObject schema, {bool? isNullable}) {
    final typeName = schema.type?.name;
    final nullable = isNullable ?? (schema.nullable == true);

    switch (typeName) {
      case 'string':
        return refer(nullable ? 'String?' : 'String');
      case 'integer':
        return refer(nullable ? 'int?' : 'int');
      case 'number':
        return refer(nullable ? 'double?' : 'double');
      case 'boolean':
        return refer(nullable ? 'bool?' : 'bool');
      case 'array':
        return refer(nullable ? 'List?' : 'List');
      default:
        return refer(nullable ? 'dynamic?' : 'dynamic');
    }
  }
}
