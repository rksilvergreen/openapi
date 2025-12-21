import '../../openapi_graph.dart';
import '../../../validation/validation_utils.dart';
import '../../../../validation_exception.dart';
import '../../referencable.dart';
import 'typed_schema/typed_schema.dart';
import 'effective_schema/effective_schema.dart';
import '../external_documentation.dart';
import '../xml.dart';
import 'schema_map.dart';
import 'schemas_list.dart';
import '../../node_creation_helpers.dart';
import '../discriminator.dart';
import 'schema_type.dart';

abstract class Schema {
  String? get title;
  String? get description;
  dynamic get default_;
  SchemaType? get type;
  String? get format;
  num? get multipleOf;
  num? get maximum;
  num? get exclusiveMaximum;
  num? get minimum;
  num? get exclusiveMinimum;
  int? get maxLength;
  int? get minLength;
  String? get pattern;
  int? get maxItems;
  int? get minItems;
  bool get uniqueItems;
  SchemaNode? get items;
  int? get maxProperties;
  int? get minProperties;
  List<String>? get required_;
  SchemasMapNode? get properties;
  bool? get additionalPropertiesAllowed;
  SchemaNode? get additionalProperties;
  SchemasListNode? get allOf;
  SchemasListNode? get oneOf;
  SchemasListNode? get anyOf;
  List<dynamic>? get enum_;
  bool get nullable;
  DiscriminatorNode? get discriminator;
  bool get readOnly;
  bool get writeOnly;
  XMLNode? get xml;
  ExternalDocumentationNode? get externalDocs;
  dynamic get example;
  bool get deprecated;
  Map<String, dynamic>? get extensions;

  TypedSchema get $typed;
  EffectiveSchema get $effective;
}

class SchemaNode extends Node with Referencable, InternalNode implements Schema {
  // JSON Schema Core keywords
  late final String? title;
  late final String? description;
  late final dynamic default_;

  // Type and format
  late final SchemaType? type;
  late final String? format;

  // Numeric validations
  late final num? multipleOf;
  late final num? maximum;
  late final num? exclusiveMaximum;
  late final num? minimum;
  late final num? exclusiveMinimum;

  // String validations
  late final int? maxLength;
  late final int? minLength;
  late final String? pattern;

  // Array validations
  late final int? maxItems;
  late final int? minItems;
  late final bool uniqueItems;
  late final SchemaNode? items;

  // Object validations
  late final int? maxProperties;
  late final int? minProperties;
  late final List<String>? required_;
  late final SchemasMapNode? properties;
  late final bool? additionalPropertiesAllowed;
  late final SchemaNode? additionalProperties;

  // Composition
  late final SchemasListNode? allOf;
  late final SchemasListNode? oneOf;
  late final SchemasListNode? anyOf;

  // Generic
  late final List<dynamic>? enum_;

  // OpenAPI-specific
  late final bool nullable;
  late final DiscriminatorNode? discriminator;
  late final bool readOnly;
  late final bool writeOnly;
  late final XMLNode? xml;
  late final ExternalDocumentationNode? externalDocs;
  late final dynamic example;
  late final bool deprecated;
  late final Map<String, dynamic>? extensions;

  SchemaNode(super.json, super.document, super.jsonPointer);

  late final TypedSchema $typed;
  late final EffectiveSchema $effective;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    _validateType(jsonPointer);
    _validateNumericConstraints(jsonPointer);
    _validateStringConstraints(jsonPointer);
    _validateArrayConstraints(jsonPointer);
    _validateObjectConstraints(jsonPointer);
    _validateCompositionKeywords(jsonPointer);
    _validateOpenApiSpecificFields(jsonPointer);
  }

  void _validateType(String jsonPointer) {
    if (json.containsKey('type')) {
      final type = json['type'];
      if (type is String) {
        ValidationUtils.validateEnum(type, [
          'string',
          'number',
          'integer',
          'boolean',
          'array',
          'object',
          'null',
        ], ValidationUtils.buildPointer([jsonPointer, 'type']));
      } else if (type != null) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([jsonPointer, 'type']),
            'type must be a string',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }

  void _validateNumericConstraints(String jsonPointer) {
    if (json.containsKey('minimum')) {
      ValidationUtils.requireNumber(json['minimum'], ValidationUtils.buildPointer([jsonPointer, 'minimum']));
    }
    if (json.containsKey('maximum')) {
      ValidationUtils.requireNumber(json['maximum'], ValidationUtils.buildPointer([jsonPointer, 'maximum']));
    }
    if (json.containsKey('exclusiveMinimum')) {
      ValidationUtils.requireNumber(
        json['exclusiveMinimum'],
        ValidationUtils.buildPointer([jsonPointer, 'exclusiveMinimum']),
      );
    }
    if (json.containsKey('exclusiveMaximum')) {
      ValidationUtils.requireNumber(
        json['exclusiveMaximum'],
        ValidationUtils.buildPointer([jsonPointer, 'exclusiveMaximum']),
      );
    }
    if (json.containsKey('multipleOf')) {
      final val = ValidationUtils.requireNumber(
        json['multipleOf'],
        ValidationUtils.buildPointer([jsonPointer, 'multipleOf']),
      );
      ValidationUtils.validatePositive(val, ValidationUtils.buildPointer([jsonPointer, 'multipleOf']));
    }
  }

  void _validateStringConstraints(String jsonPointer) {
    if (json.containsKey('minLength')) {
      final val = ValidationUtils.requireInt(
        json['minLength'],
        ValidationUtils.buildPointer([jsonPointer, 'minLength']),
      );
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPointer([jsonPointer, 'minLength']));
    }
    if (json.containsKey('maxLength')) {
      final val = ValidationUtils.requireInt(
        json['maxLength'],
        ValidationUtils.buildPointer([jsonPointer, 'maxLength']),
      );
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPointer([jsonPointer, 'maxLength']));
    }
    if (json.containsKey('pattern')) {
      final pattern = ValidationUtils.requireString(
        json['pattern'],
        ValidationUtils.buildPointer([jsonPointer, 'pattern']),
      );
      ValidationUtils.validateRegexPattern(pattern, ValidationUtils.buildPointer([jsonPointer, 'pattern']));
    }
  }

  void _validateArrayConstraints(String jsonPointer) {
    if (json.containsKey('minItems')) {
      final val = ValidationUtils.requireInt(json['minItems'], ValidationUtils.buildPointer([jsonPointer, 'minItems']));
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPointer([jsonPointer, 'minItems']));
    }
    if (json.containsKey('maxItems')) {
      final val = ValidationUtils.requireInt(json['maxItems'], ValidationUtils.buildPointer([jsonPointer, 'maxItems']));
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPointer([jsonPointer, 'maxItems']));
    }
    if (json.containsKey('uniqueItems')) {
      ValidationUtils.requireBool(json['uniqueItems'], ValidationUtils.buildPointer([jsonPointer, 'uniqueItems']));
    }
    if (json.containsKey('items')) {
      // items MUST be an object per OpenAPI 3.0.0 Schema Object specification
      ValidationUtils.requireMap(json['items'], ValidationUtils.buildPointer([jsonPointer, 'items']));
    }
  }

  void _validateObjectConstraints(String jsonPointer) {
    if (json.containsKey('minProperties')) {
      final val = ValidationUtils.requireInt(
        json['minProperties'],
        ValidationUtils.buildPointer([jsonPointer, 'minProperties']),
      );
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPointer([jsonPointer, 'minProperties']));
    }
    if (json.containsKey('maxProperties')) {
      final val = ValidationUtils.requireInt(
        json['maxProperties'],
        ValidationUtils.buildPointer([jsonPointer, 'maxProperties']),
      );
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPointer([jsonPointer, 'maxProperties']));
    }
    if (json.containsKey('required')) {
      final required = ValidationUtils.requireList(
        json['required'],
        ValidationUtils.buildPointer([jsonPointer, 'required']),
      );
      for (var i = 0; i < required.length; i++) {
        ValidationUtils.requireString(required[i], ValidationUtils.buildPointer([jsonPointer, 'required', '[$i]']));
      }
    }
    if (json.containsKey('properties')) {
      ValidationUtils.requireMap(json['properties'], ValidationUtils.buildPointer([jsonPointer, 'properties']));
    }
    if (json.containsKey('additionalProperties')) {
      // Can be boolean or object per OpenAPI 3.0.0 Schema Object specification
      final val = json['additionalProperties'];
      if (val is! bool && val is! Map) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([jsonPointer, 'additionalProperties']),
            'additionalProperties must be a boolean or object',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }

  void _validateCompositionKeywords(String jsonPointer) {
    if (json.containsKey('allOf')) {
      ValidationUtils.requireList(json['allOf'], ValidationUtils.buildPointer([jsonPointer, 'allOf']));
    }
    if (json.containsKey('oneOf')) {
      ValidationUtils.requireList(json['oneOf'], ValidationUtils.buildPointer([jsonPointer, 'oneOf']));
    }
    if (json.containsKey('anyOf')) {
      ValidationUtils.requireList(json['anyOf'], ValidationUtils.buildPointer([jsonPointer, 'anyOf']));
    }
    if (json.containsKey('not')) {
      ValidationUtils.requireMap(json['not'], ValidationUtils.buildPointer([jsonPointer, 'not']));
    }
  }

  void _validateOpenApiSpecificFields(String jsonPointer) {
    if (json.containsKey('nullable')) {
      ValidationUtils.requireBool(json['nullable'], ValidationUtils.buildPointer([jsonPointer, 'nullable']));
    }
    if (json.containsKey('discriminator')) {
      ValidationUtils.requireMap(json['discriminator'], ValidationUtils.buildPointer([jsonPointer, 'discriminator']));
    }
    if (json.containsKey('readOnly')) {
      ValidationUtils.requireBool(json['readOnly'], ValidationUtils.buildPointer([jsonPointer, 'readOnly']));
    }
    if (json.containsKey('writeOnly')) {
      ValidationUtils.requireBool(json['writeOnly'], ValidationUtils.buildPointer([jsonPointer, 'writeOnly']));
    }
    if (json.containsKey('xml')) {
      ValidationUtils.requireMap(json['xml'], ValidationUtils.buildPointer([jsonPointer, 'xml']));
    }
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPointer([jsonPointer, 'externalDocs']));
    }
    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPointer([jsonPointer, 'deprecated']));
    }
  }

  @override
  void createChildNodes() {
    createNode<SchemasMapNode>(jsonKey: 'properties');
    createNode<SchemaNode>(jsonKey: 'items');
    if (json['additionalProperties'] is Map) {
      createNode<SchemaNode>(jsonKey: 'additionalProperties');
    }
    createNode<SchemasListNode>(jsonKey: 'allOf');
    createNode<SchemasListNode>(jsonKey: 'oneOf');
    createNode<SchemasListNode>(jsonKey: 'anyOf');
    createNode<XMLNode>(jsonKey: 'xml');
    createNode<ExternalDocumentationNode>(jsonKey: 'externalDocs');
  }

  @override
  void createContent() {
    title = json['title'];
    description = json['description'];
    default_ = json['default'];
    type = json['type'] != null ? SchemaType.values.byName(json['type']) : null;
    format = json['format'];
    multipleOf = json['multipleOf'];
    maximum = json['maximum'];
    exclusiveMaximum = json['exclusiveMaximum'];
    minimum = json['minimum'];
    exclusiveMinimum = json['exclusiveMinimum'];
    maxLength = json['maxLength'];
    minLength = json['minLength'];
    pattern = json['pattern'];
    maxItems = json['maxItems'];
    minItems = json['minItems'];
    uniqueItems = json['uniqueItems'];
    items = $to.to<SchemaNode>('items');
    maxProperties = json['maxProperties'];
    minProperties = json['minProperties'];
    required_ = json['required'];
    properties = $to.to<SchemasMapNode>('properties');
    additionalPropertiesAllowed = json['additionalProperties'] is bool ? json['additionalProperties'] : null;
    additionalProperties = $to.to<SchemaNode>('additionalProperties');
    allOf = $to.to<SchemasListNode>('allOf');
    oneOf = $to.to<SchemasListNode>('oneOf');
    anyOf = $to.to<SchemasListNode>('anyOf');
    discriminator = $to.to<DiscriminatorNode>('discriminator');
    readOnly = json['readOnly'];
    writeOnly = json['writeOnly'];
    xml = $to.to<XMLNode>('xml');
    externalDocs = $to.to<ExternalDocumentationNode>('externalDocs');
    example = json['example'];
    deprecated = json['deprecated'];
    extensions = extractExtensions(json);
    _createTyped();
    _createEffective();
  }

  void _createTyped() {
    $typed = TypedSchema.of(this, OpenApiGraph.i.validationContext);
  }

  void _createEffective() {
    $effective = EffectiveSchema.fromTyped(this, $typed, OpenApiGraph.i.validationContext);
  }
}
