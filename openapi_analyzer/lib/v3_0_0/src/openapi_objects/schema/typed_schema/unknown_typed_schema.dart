import '../schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/typed_schema/unknown_typed_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/schema.dart';

class UnknownTypedSchemaImpl extends TypedSchemaImpl<dynamic> implements UnknownTypedSchema {
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
