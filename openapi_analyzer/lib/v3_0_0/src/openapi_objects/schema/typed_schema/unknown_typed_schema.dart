import '../schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';

class UnknownTypedSchemaImpl extends TypedSchemaImpl<dynamic> {
  UnknownTypedSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
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

  factory UnknownTypedSchemaImpl.of(SchemaNode node) {
    return UnknownTypedSchemaImpl(
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
