import '../schema.dart';
import '../raw_schema.dart';
import '../schema_type.dart';

import 'typed_schema.dart';

class UnknownTypedSchema extends TypedSchema<UnknownTypedSchema> {
  UnknownTypedSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
  }) : super($node, SchemaType.unknown, description, readOnly, writeOnly, example, deprecated, nullable);

  factory UnknownTypedSchema.fromRaw(SchemaNode node, RawSchema raw) {
    return UnknownTypedSchema(
      $node: node,
      description: raw.description,
      readOnly: raw.readOnly,
      writeOnly: raw.writeOnly,
      example: raw.example,
      deprecated: raw.deprecated,
      nullable: raw.nullable,
    );
  }
}
