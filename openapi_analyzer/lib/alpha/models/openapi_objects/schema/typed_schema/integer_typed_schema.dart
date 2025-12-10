import 'package:openapi_analyzer/alpha/models/openapi_objects/schema/schema_node.dart';

import 'typed_schema.dart';

class IntegerTypedSchema extends TypedSchema<int, IntegerTypedSchema> {
  final SchemaType type = SchemaType.integer;
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;
  final String? format;

  IntegerTypedSchema({
    required super.$id,
    super.description,
    super.nullable,
    super.readOnly,
    super.writeOnly,
    super.xml,
    super.externalDocs,
    super.example,
    super.deprecated,
    super.enumValues,
    super.defaultValue,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.format,
  });
}