import 'package:openapi_analyzer/beta/effective_schema_node/effective_schema_node.dart';
import 'package:openapi_analyzer/beta/schema/integer_schema.dart';

mixin IntegerTypeEffectiveSchema {}

class IntegerEffectiveSchemaNode extends IntegerSchema
    with SingleTypeEffectiveSchemaNode<int, IntegerSchema>, IntegerTypeEffectiveSchema {
  final String $id;

  IntegerEffectiveSchemaNode({
    required this.$id,
    required super.name,
    super.description,
    super.nullable = false,
    super.readOnly = false,
    super.writeOnly = false,
    super.xml,
    super.externalDocs,
    super.example,
    super.deprecated = false,
    super.enumValues = const [],
    super.defaultValue,
    super.multipleOf,
    super.maximum,
    super.exclusiveMaximum,
    super.minimum,
    super.exclusiveMinimum,
    super.format,
  });
}

class IntegerUnionEffectiveSchemaNode
    with SingleTypeEffectiveSchemaNode<int, IntegerSchema>, IntegerTypeEffectiveSchema {
  final String $id;
  List<IntegerTypeEffectiveSchema> variants;
  IntegerUnionEffectiveSchemaNode({required this.$id, required this.variants});
}

class IntegerEffectiveSchema extends IntegerSchema with IntegerTypeEffectiveSchema {

  IntegerEffectiveSchema({
    required super.name,
    super.description,
    super.nullable = false,
    super.readOnly = false,
    super.writeOnly = false,
    super.xml,
    super.externalDocs,
    super.example,
    super.deprecated = false,
    super.enumValues = const [],
    super.defaultValue,
    super.multipleOf,
    super.maximum,
    super.exclusiveMaximum,
    super.minimum,
    super.exclusiveMinimum,
    super.format,
  });
}
