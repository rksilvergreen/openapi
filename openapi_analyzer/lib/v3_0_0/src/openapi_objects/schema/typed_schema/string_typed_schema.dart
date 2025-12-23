import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/src/openapi_graph.dart';
import '../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/typed_schema/string_typed_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/schema.dart';

class StringTypedSchemaImpl extends TypedSchemaImpl<String> implements StringTypedSchema {
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final String? format;

  StringTypedSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    String? defaultValue,
    List<String>? enumValues,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.format,
  }) : super(
         $node,
         SchemaType.string,
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

  factory StringTypedSchemaImpl.of(SchemaNode node) {
    TypedSchemaImpl.validateConstraints<String>(node, OpenApiGraph.i.validationContext, validateConstraints);
    return StringTypedSchemaImpl(
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
      enumValues: node.enum_ as List<String>?,
      minLength: node.minLength,
      maxLength: node.maxLength,
      pattern: node.pattern,
      format: node.format,
    );
  }

  /// Validates atomic constraints for string type.
  static void validateConstraints(SchemaNode node, ValidationContext ctx) {
    final jsonPointer = node.$id.jsonPointer;

    if (node.minLength != null && node.maxLength != null) {
      if (node.minLength! > node.maxLength!) {
        ctx.addException(
          OpenApiValidationException(
            jsonPointer,
            'minLength (${node.minLength}) cannot be greater than maxLength (${node.maxLength})',
            specReference: 'JSON Schema Validation',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }
}
