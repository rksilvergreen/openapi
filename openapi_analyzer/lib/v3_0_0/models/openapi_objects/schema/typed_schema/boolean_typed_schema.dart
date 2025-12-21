import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_graph.dart';
import '../../../../validation/validation_context.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';

class BooleanTypedSchema extends TypedSchema<bool> {
  final String? format;

  BooleanTypedSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    bool? defaultValue,
    List<bool>? enumValues,
    this.format,
  }) : super(
         $node,
         SchemaType.boolean,
         description,
         readOnly,
         writeOnly,
         xml,
         externalDocs,
         example,
         deprecated,
         nullable,
         defaultValue,
         enumValues,
       );

  factory BooleanTypedSchema.of(SchemaNode node) {
    TypedSchema.validateConstraints<bool>(node, OpenApiGraph.i.validationContext, validateConstraints);
    return BooleanTypedSchema(
      $node: node,
      description: node.description,
      readOnly: node.readOnly,
      writeOnly: node.writeOnly,
      xml: node.xml,
      externalDocs: node.externalDocs,
      example: node.example,
      deprecated: node.deprecated,
      nullable: node.nullable,
      defaultValue: node.default_,
      enumValues: node.enum_ as List<bool>?,
      format: node.format,
    );
  }

  /// Validates atomic constraints for boolean type.
  static void validateConstraints(SchemaNode node, ValidationContext ctx) {
    // Boolean type has no specific constraints to validate
  }
}
