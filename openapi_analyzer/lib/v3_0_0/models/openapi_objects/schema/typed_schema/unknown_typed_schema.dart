import '../schema.dart';
import '../schema_type.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';

class UnknownTypedSchema extends TypedSchema<dynamic> {
  UnknownTypedSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
    dynamic example,
    bool deprecated = false,
    bool nullable = false,
  }) : super(
         $node,
         SchemaType.unknown,
         description,
         readOnly,
         writeOnly,
         xml,
         externalDocs,
         example,
         deprecated,
         nullable,
         null,
         null,
       );

  factory UnknownTypedSchema.of(SchemaNode node) {
    return UnknownTypedSchema(
      $node: node,
      description: node.description,
      readOnly: node.readOnly,
      writeOnly: node.writeOnly,
      xml: node.xml,
      externalDocs: node.externalDocs,
      example: node.example,
      deprecated: node.deprecated,
      nullable: node.nullable,
    );
  }
}
