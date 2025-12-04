import '../lib/v3_0_0/parser/src/schema_object.dart';

enum SchemaType { string, integer, boolean, number, array, object, unknown }

abstract class AtomicSchemaObject<T> {
  SchemaType get type;
  final T? defaultValue;
  final bool nullable;
  AtomicSchemaObject([this.defaultValue, this.nullable = false]);

  factory AtomicSchemaObject.fromSchemaObject(SchemaObject schema, SchemaType type) {
    return switch (type) {
      SchemaType.string => StringAtomicSchemaObject.fromSchemaObject(schema) as AtomicSchemaObject<T>,
      SchemaType.unknown => throw Exception('Invalid schema type: $type'),
      _ => throw Exception('Invalid schema type: $type'),
    };
  }
}

class StringAtomicSchemaObject extends AtomicSchemaObject<String> {
  final SchemaType type = SchemaType.string;
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final String? format;
  StringAtomicSchemaObject([
    super.defaultValue,
    super.nullable,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.format,
  ]);

  factory StringAtomicSchemaObject.fromSchemaObject(SchemaObject schema) {
    return StringAtomicSchemaObject(
      schema.default_,
      schema.nullable,
      schema.maxLength,
      schema.minLength,
      schema.pattern,
      schema.format,
    );
  }
}
