import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/src/openapi_graph.dart';
import '../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/typed_schema/integer_typed_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/schema.dart';

class IntegerTypedSchemaImpl extends TypedSchemaImpl<int> implements IntegerTypedSchema {
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;
  final String? format;

  IntegerTypedSchemaImpl({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XMLNode? xml,
    ExternalDocumentationNode? externalDocs,
    Map<String, dynamic>? example,
    bool deprecated = false,
    bool nullable = false,
    int? defaultValue,
    List<int>? enumValues,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.format,
  }) : super(
         $node,
         SchemaType.integer,
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

  factory IntegerTypedSchemaImpl.of(SchemaNode node) {
    TypedSchemaImpl.validateConstraints<int>(node, OpenApiGraph.i.validationContext, validateConstraints);
    return IntegerTypedSchemaImpl(
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
      enumValues: node.enum_ as List<int>?,
      multipleOf: node.multipleOf?.toDouble(),
      maximum: node.maximum?.toInt(),
      exclusiveMaximum: node.exclusiveMaximum?.toInt(),
      minimum: node.minimum?.toInt(),
      exclusiveMinimum: node.exclusiveMinimum?.toInt(),
      format: node.format,
    );
  }

  /// Validates atomic constraints for integer type.
  static void validateConstraints(SchemaNode node, ValidationContext ctx) {
    final jsonPointer = node.$id.jsonPointer;

    if (node.minimum != null && node.maximum != null) {
      if (node.minimum! > node.maximum!) {
        ctx.addException(
          OpenApiValidationException(
            jsonPointer,
            'minimum (${node.minimum}) cannot be greater than maximum (${node.maximum})',
            specReference: 'JSON Schema Validation',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }

    if (node.multipleOf != null && node.multipleOf! <= 0) {
      ctx.addException(
        OpenApiValidationException(
          jsonPointer,
          'multipleOf must be greater than 0',
          specReference: 'JSON Schema Validation',
          severity: ValidationSeverity.critical,
        ),
      );
    }
  }
}
