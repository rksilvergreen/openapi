import 'package:openapi_analyzer/v3_0_0/doc_nodes/schema_doc_node.dart';
import '../typed_schema/object_typed_schema.dart';
import 'effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/effective_schema/object_effective_schema.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/schema.dart';

class ObjectEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<Map<String, dynamic>, ObjectEffectiveSchemaImpl>
    with ObjectEffectiveSchemaImplVariant
    implements ObjectEffectiveSchema {
  final Map<String, EffectiveSchemaImpl>? properties;
  final bool additionalPropertiesAllowed;
  final EffectiveSchemaImpl? additionalProperties;
  final int? maxProperties;
  final int? minProperties;
  final List<String>? required;

  ObjectEffectiveSchemaImpl({
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
    this.additionalPropertiesAllowed = true,
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

  factory ObjectEffectiveSchemaImpl.fromTyped(SchemaNode node, ObjectTypedSchemaImpl typed) {
    return ObjectEffectiveSchemaImpl(
      $node: node,
      description: typed.description,
      readOnly: typed.readOnly,
      writeOnly: typed.writeOnly,
      xml: node.xml,
      externalDocs: node.externalDocs,
      example: typed.example,
      deprecated: typed.deprecated,
      nullable: typed.nullable,
      defaultValue: typed.defaultValue,
      enumValues: typed.enumValues,
      minProperties: typed.minProperties,
      maxProperties: typed.maxProperties,
      required: typed.required,
    );
  }
}

class ObjectUnionEffectiveSchemaImpl
    extends SingleTypeEffectiveSchemaImpl<Map<String, dynamic>, ObjectEffectiveSchemaImpl>
    with ObjectEffectiveSchemaImplVariant {
  final List<ObjectEffectiveSchemaImplVariant> variants;
  ObjectUnionEffectiveSchemaImpl({
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
    required this.variants,
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
}

mixin ObjectEffectiveSchemaImplVariant {}

class ObjectEffectiveSchemaImplUnregistered with ObjectEffectiveSchemaImplVariant {
  final Map<String, dynamic>? defaultValue;
  final List<Map<String, dynamic>>? enumValues;
  final Map<String, EffectiveSchemaImpl>? properties;
  final bool additionalPropertiesAllowed;
  final EffectiveSchemaImpl? additionalProperties;
  final int? maxProperties;
  final int? minProperties;
  final List<String>? required;

  ObjectEffectiveSchemaImplUnregistered({
    this.defaultValue,
    this.enumValues,
    this.properties,
    this.additionalPropertiesAllowed = true,
    this.additionalProperties,
    this.maxProperties,
    this.minProperties,
    this.required,
  });
}
