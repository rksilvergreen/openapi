import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/src/openapi_graph.dart';
import '../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/typed_schema/array_typed_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/schema.dart';

class ArrayTypedSchemaImpl extends TypedSchemaImpl<List<dynamic>> implements ArrayTypedSchema {
  final SchemaNode? items;
  final int? maxItems;
  final int? minItems;
  final bool uniqueItems;

  ArrayTypedSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
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

  factory ArrayTypedSchemaImpl.of(SchemaNode node) {
    TypedSchemaImpl.validateConstraints<List<dynamic>>(node, OpenApiGraph.i.validationContext, validateConstraints);
    return ArrayTypedSchemaImpl(
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
