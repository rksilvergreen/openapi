import 'package:code_builder/code_builder.dart';

/// Generates wrapper classes for primitive types in unions.
///
/// Implements Rule 6 from GENERATION_ALGORITHM.md:
/// When a oneOf includes primitive types, generate wrapper classes.
///
/// Example:
/// ```dart
/// class CreatureStringValue extends Equatable implements Creature {
///   CreatureStringValue({required this.value});
///
///   final String value;
///
///   @override
///   List<Object?> get props => [value];
///
///   @override
///   dynamic toJson() => value;
/// }
/// ```
class PrimitiveWrapperGenerator {
  /// Generate a wrapper class for a primitive type.
  ///
  /// Parameters:
  /// - wrapperName: Name of the wrapper class (e.g., "CreatureStringValue")
  /// - primitiveType: The Dart primitive type ("String", "int", "double", "bool")
  /// - interfaceName: The interface this wrapper implements
  Class generatePrimitiveWrapper({
    required String wrapperName,
    required String primitiveType,
    required String interfaceName,
  }) {
    return Class((b) {
      b.name = wrapperName;

      // Extends Equatable
      b.extend = refer('Equatable', 'package:equatable/equatable.dart');

      // Implements the interface
      b.implements.add(refer(interfaceName));

      // Constructor
      b.constructors.add(
        Constructor((c) {
          c.optionalParameters.add(
            Parameter((p) {
              p.name = 'value';
              p.named = true;
              p.required = true;
              p.toThis = true;
            }),
          );
        }),
      );

      // Value field
      b.fields.add(
        Field((f) {
          f.name = 'value';
          f.modifier = FieldModifier.final$;
          f.type = refer(primitiveType);
        }),
      );

      // props getter
      b.methods.add(
        Method((m) {
          m.name = 'props';
          m.type = MethodType.getter;
          m.returns = refer('List<Object?>');
          m.annotations.add(refer('override'));
          m.lambda = true;
          m.body = literalList([refer('value')]).code;
        }),
      );

      // toJson method - returns the primitive value directly
      b.methods.add(
        Method((m) {
          m.name = 'toJson';
          m.returns = refer('dynamic');
          m.annotations.add(refer('override'));
          m.lambda = true;
          m.body = refer('value').code;
        }),
      );

      // toString method
      b.methods.add(
        Method((m) {
          m.name = 'toString';
          m.returns = refer('String');
          m.annotations.add(refer('override'));
          m.lambda = true;
          m.body = refer('value').property('toString').call([]).code;
        }),
      );

      // canParse methods are no longer generated - logic is moved to parent interface's fromJson
    });
  }

  /// Generate wrapper classes for all primitive variants in a union.
  ///
  /// Returns a map of wrapper name to Class spec.
  Map<String, Class> generatePrimitiveWrappers({required String baseName, required List<String> primitiveTypes}) {
    final wrappers = <String, Class>{};

    for (final primitiveType in primitiveTypes) {
      final typeName = _getTypeNameForWrapper(primitiveType);
      final wrapperName = '$baseName${typeName}Value';

      wrappers[wrapperName] = generatePrimitiveWrapper(
        wrapperName: wrapperName,
        primitiveType: primitiveType,
        interfaceName: baseName,
      );
    }

    return wrappers;
  }

  /// Get a capitalized type name for the wrapper class name.
  String _getTypeNameForWrapper(String primitiveType) {
    switch (primitiveType.toLowerCase()) {
      case 'string':
        return 'String';
      case 'int':
      case 'integer':
        return 'Integer';
      case 'double':
      case 'number':
        return 'Number';
      case 'bool':
      case 'boolean':
        return 'Boolean';
      default:
        return primitiveType;
    }
  }
}
