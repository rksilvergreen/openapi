import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/schema/schema_type.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_graph.dart';
import '../../../../validation/validation_context.dart';
import '../../../../../validation_exception.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'typed_schema.dart';

class IntegerTypedSchema extends TypedSchema<int> {
  final double? multipleOf;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? minimum;
  final int? exclusiveMinimum;
  final String? format;

  IntegerTypedSchema({
    required SchemaNode $node,
    String? description,
    bool readOnly = false,
    bool writeOnly = false,
    XML? xml,
    ExternalDocumentation? externalDocs,
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

  factory IntegerTypedSchema.of(SchemaNode node) {
    TypedSchema.validateConstraints<int>(node, OpenApiGraph.i.validationContext, validateConstraints);
    return IntegerTypedSchema(
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