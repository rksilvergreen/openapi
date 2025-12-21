import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_graph.dart';
import '../../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';

class ArrayTypedSchema extends TypedSchema<List<dynamic>> {
  final SchemaNode? items;
  final int? maxItems;
  final int? minItems;
  final bool uniqueItems;

  ArrayTypedSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    List<dynamic>? defaultValue,
    List<List<dynamic>>? enumValues,
    this.items,
    this.maxItems,
    this.minItems,
    this.uniqueItems = false,
  }) : super(
         $node,
         SchemaType.array,
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

  factory ArrayTypedSchema.of(SchemaNode node) {
    TypedSchema.validateConstraints<List<dynamic>>(node, OpenApiGraph.i.validationContext, validateConstraints);
    return ArrayTypedSchema(
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
      enumValues: node.enum_ as List<List<dynamic>>?,
      items: node.items,
      minItems: node.minItems,
      maxItems: node.maxItems,
      uniqueItems: node.uniqueItems,
    );
  }

  /// Validates atomic constraints for array type.
  static void validateConstraints(SchemaNode node, ValidationContext ctx) {
    final jsonPointer = node.$id.jsonPointer;

    if (node.minItems != null && node.maxItems != null) {
      if (node.minItems! > node.maxItems!) {
        ctx.addException(
          OpenApiValidationException(
            jsonPointer,
            'minItems (${node.minItems}) cannot be greater than maxItems (${node.maxItems})',
            specReference: 'JSON Schema Validation',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }
}
