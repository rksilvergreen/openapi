import 'package:openapi_analyzer/v3_0_0/modeler/schema/integer_schema.dart';
import 'package:openapi_analyzer/v3_0_0/modeler/schema_node/schema_node.dart';

class IntegerSchemaNode extends IntegerSchema with SingleTypeSchemaNode<int, IntegerSchema> {
  final String $id;

  IntegerSchemaNode({
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
