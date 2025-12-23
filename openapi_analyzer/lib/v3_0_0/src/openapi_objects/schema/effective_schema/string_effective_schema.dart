import 'package:openapi_analyzer/v3_0_0/src/openapi_objects/schema/schema.dart';
import '../typed_schema/string_typed_schema.dart';
import 'effective_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/effective_schema/string_effective_schema.dart';
import 'package:openapi_analyzer/v3_0_0/objects/schema/schema.dart';

class StringEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<String, StringEffectiveSchemaImpl>
    with StringEffectiveSchemaImplVariant
    implements StringEffectiveSchema {
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final String? format;

  StringEffectiveSchemaImpl({
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

  factory StringEffectiveSchemaImpl.fromTyped(SchemaNode node, StringTypedSchemaImpl typed) {
    return StringEffectiveSchemaImpl(
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
      minLength: typed.minLength,
      maxLength: typed.maxLength,
      pattern: typed.pattern,
      format: typed.format,
    );
  }
}

class StringUnionEffectiveSchemaImpl extends SingleTypeEffectiveSchemaImpl<String, StringEffectiveSchemaImpl>
    with StringEffectiveSchemaImplVariant {
  final List<StringEffectiveSchemaImplVariant> variants;
  StringUnionEffectiveSchemaImpl({
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
    required this.variants,
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
}

mixin StringEffectiveSchemaImplVariant {}

class StringEffectiveSchemaImplUnregistered with StringEffectiveSchemaImplVariant {
  final String? defaultValue;
  final List<String>? enumValues;
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final String? format;

  StringEffectiveSchemaImplUnregistered({
    this.defaultValue,
    this.enumValues,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.format,
  });
}
