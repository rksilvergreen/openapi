import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/src/openapi_graph.dart';
import '../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';

class ObjectTypedSchemaImpl extends TypedSchemaImpl<Map<String, dynamic>> {
  final SchemasMapNode? properties;
  final bool? additionalPropertiesAllowed;
  final SchemaNode? additionalProperties;
  final int? maxProperties;
  final int? minProperties;
  final List<String>? required;

  ObjectTypedSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    Map<String, dynamic>? defaultValue,
    List<Map<String, dynamic>>? enumValues,
    this.properties,
    this.additionalPropertiesAllowed,
    this.additionalProperties,
    this.maxProperties,
    this.minProperties,
    this.required,
  }) : super(
         $node,
         SchemaType.object,
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

  factory ObjectTypedSchemaImpl.of(SchemaNode node) {
    TypedSchemaImpl.validateConstraints<Map<String, dynamic>>(
      node,
      OpenApiGraph.i.validationContext,
      validateConstraints,
    );
    return ObjectTypedSchemaImpl(
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
      enumValues: node.enum_ as List<Map<String, dynamic>>?,
      properties: node.properties,
      minProperties: node.minProperties,
      maxProperties: node.maxProperties,
      required: node.required_,
      additionalPropertiesAllowed: node.additionalPropertiesAllowed,
      additionalProperties: node.additionalProperties,
    );
  }

  /// Validates atomic constraints for object type.
  static void validateConstraints(SchemaNode node, ValidationContext ctx) {
    final jsonPointer = node.$id.jsonPointer;

    if (node.minProperties != null && node.maxProperties != null) {
      if (node.minProperties! > node.maxProperties!) {
        ctx.addException(
          OpenApiValidationException(
            jsonPointer,
            'minProperties (${node.minProperties}) cannot be greater than maxProperties (${node.maxProperties})',
            specReference: 'JSON Schema Validation',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }

    // Validate required properties exist in properties
    if (node.required_ != null && node.properties != null) {
      for (final requiredProp in node.required_!) {
        if (!node.properties!.containsKey(requiredProp)) {
          ctx.addException(
            OpenApiValidationException(
              jsonPointer,
              'Required property "$requiredProp" not found in properties',
              specReference: 'JSON Schema Validation',
              severity: ValidationSeverity.low, // Not critical - could be in allOf
            ),
          );
        }
      }
    }
  }
}
