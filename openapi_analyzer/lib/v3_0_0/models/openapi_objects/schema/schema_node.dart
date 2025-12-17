import '../../openapi_graph.dart';
import '../../../validation/validation_utils.dart';
import '../../../../validation_exception.dart';
import '../../referencable.dart';
import 'raw_schema.dart';
import 'typed_schema/typed_schema.dart';
import 'effective_schema/effective_schema.dart';
import '../external_documentation.dart';
import '../xml.dart';

class SchemaNode extends Node with Referencable {
  SchemaNode._(super.$id, super.json);

  factory SchemaNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<SchemaNode>(json, document, jsonPointer, (nodeId, json) => SchemaNode._(nodeId, json));

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _isStructuralValidationPassed = false;
  bool _isRawSet = false;
  bool isTypedSet = false;
  bool isEffectiveSet = false;

  bool get isStructuralValidated => _isStructuralValidationPassed;
  bool get isRawSet => _isRawSet;
  bool get isTypedSchemaSet => isTypedSet;
  bool get isEffectiveSchemaSet => isEffectiveSet;

  late final List<SchemaNode>? allOfNodes;
  late final List<SchemaNode>? oneOfNodes;
  late final List<SchemaNode>? anyOfNodes;
  late final Map<String, SchemaNode>? propertiesNodes;
  late final SchemaNode? additionalPropertiesNode;
  late final SchemaNode itemsNode;

  late final ExternalDocumentationNode? externalDocsNode;
  late final XMLNode? xmlNode;

  late final RawSchema raw;
  late final TypedSchema typed;
  late final EffectiveSchema effective;

  void _validateStructure() {
    _isStructuralValidationPassed = true;
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

  void _createChildNodes() {
    // Create Structural Children
    _createPropertiesNodes();
    _createItemsNode();
    _createAdditionalPropertiesNode();

    // Create Applicator Children
    _createAllOfNodes();
    _createOneOfNodes();
    _createAnyOfNodes();

    // Create XML and ExternalDocs nodes if present
    _createXmlNode();
    _createExternalDocsNode();
  }

  void _createPropertiesNodes() {
    if (!json.containsKey('properties')) {
      return;
    }

    final propertiesMap = json['properties'] as Map<String, dynamic>;
    propertiesNodes = {};
    for (final entry in propertiesMap.entries) {
      final propertyName = entry.key.toString();
      final propertyJson = entry.value as Map<String, dynamic>;
      final propertyNode = SchemaNode(
        propertyJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'properties', propertyName]),
      );
      propertiesNodes![propertyName] = propertyNode;
      if (!OpenApiGraph.i.schemaNodes.containsKey(propertyNode.$id.absolutePointer)) {
        OpenApiGraph.i.addSchemaNode(propertyNode);
        OpenApiGraph.i.addSchemaStructuralEdge(PropertiesEdge($id.absolutePointer, propertyNode.$id.absolutePointer));
        propertyNode.create();
      }
    }
  }

  void _createItemsNode() {
    if (!json.containsKey('items')) {
      return;
    }

    final items = json['items'] as Map<String, dynamic>;
    itemsNode = SchemaNode(items, $id.document, ValidationUtils.buildPointer([$id.jsonPointer, 'items']));
    if (!OpenApiGraph.i.schemaNodes.containsKey(itemsNode.$id.absolutePointer)) {
      OpenApiGraph.i.addSchemaNode(itemsNode);
      OpenApiGraph.i.addSchemaStructuralEdge(ItemsEdge($id.absolutePointer, itemsNode.$id.absolutePointer));
      itemsNode.create();
    }
  }

  void _createAdditionalPropertiesNode() {
    if (!json.containsKey('additionalProperties')) {
      return;
    }

    final additionalProps = json['additionalProperties'];
    if (additionalProps is Map) {
      additionalPropertiesNode = SchemaNode(
        additionalProps as Map<String, dynamic>,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'additionalProperties']),
      );
      if (!OpenApiGraph.i.schemaNodes.containsKey(additionalPropertiesNode!.$id.absolutePointer)) {
        OpenApiGraph.i.addSchemaNode(additionalPropertiesNode!);
        OpenApiGraph.i.addSchemaStructuralEdge(
          AdditionalPropertiesEdge($id.absolutePointer, additionalPropertiesNode!.$id.absolutePointer),
        );
        additionalPropertiesNode!.create();
      }
    }
    // If additionalProperties is boolean, no child node is created
  }

  void _createAllOfNodes() {
    if (!json.containsKey('allOf')) {
      return;
    }

    final allOfList = json['allOf'] as List;
    allOfNodes = [];
    for (var i = 0; i < allOfList.length; i++) {
      final allOfJson = allOfList[i] as Map<String, dynamic>;
      final allOfNode = SchemaNode(
        allOfJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'allOf', '[$i]']),
      );
      allOfNodes!.add(allOfNode);
      if (!OpenApiGraph.i.schemaNodes.containsKey(allOfNode.$id.absolutePointer)) {
        OpenApiGraph.i.addSchemaNode(allOfNode);
        OpenApiGraph.i.addSchemaApplicatorEdge(AllOfEdge($id.absolutePointer, allOfNode.$id.absolutePointer));
        allOfNode.create();
      }
    }
  }

  void _createOneOfNodes() {
    if (!json.containsKey('oneOf')) {
      return;
    }

    final oneOfList = json['oneOf'] as List;
    oneOfNodes = [];
    for (var i = 0; i < oneOfList.length; i++) {
      final oneOfJson = oneOfList[i] as Map<String, dynamic>;
      final oneOfNode = SchemaNode(
        oneOfJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'oneOf', '[$i]']),
      );
      oneOfNodes!.add(oneOfNode);
      if (!OpenApiGraph.i.schemaNodes.containsKey(oneOfNode.$id.absolutePointer)) {
        OpenApiGraph.i.addSchemaNode(oneOfNode);
        OpenApiGraph.i.addSchemaApplicatorEdge(OneOfEdge($id.absolutePointer, oneOfNode.$id.absolutePointer));
        oneOfNode.create();
      }
    }
  }

  void _createAnyOfNodes() {
    if (!json.containsKey('anyOf')) {
      return;
    }

    final anyOfList = json['anyOf'] as List;
    anyOfNodes = [];
    for (var i = 0; i < anyOfList.length; i++) {
      final anyOfJson = anyOfList[i] as Map<String, dynamic>;
      final anyOfNode = SchemaNode(
        anyOfJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'anyOf', '[$i]']),
      );
      anyOfNodes!.add(anyOfNode);
      if (!OpenApiGraph.i.schemaNodes.containsKey(anyOfNode.$id.absolutePointer)) {
        OpenApiGraph.i.addSchemaNode(anyOfNode);
        OpenApiGraph.i.addSchemaApplicatorEdge(AnyOfEdge($id.absolutePointer, anyOfNode.$id.absolutePointer));
        anyOfNode.create();
      }
    }
  }

  void _createXmlNode() {
    if (!json.containsKey('xml')) {
      return;
    }

    final xmlJson = json['xml'] as Map<String, dynamic>;
    xmlNode = XMLNode(xmlJson, $id.document, ValidationUtils.buildPointer([$id.jsonPointer, 'xml']));
    OpenApiGraph.i.addOpenApiNode(xmlNode!);
    xmlNode!.create();
    // Note: XML node is connected but not via standard edges
  }

  void _createExternalDocsNode() {
    if (!json.containsKey('externalDocs')) {
      return;
    }

    final externalDocsJson = json['externalDocs'] as Map<String, dynamic>;
    externalDocsNode = ExternalDocumentationNode(
      externalDocsJson,
      $id.document,
      ValidationUtils.buildPointer([$id.jsonPointer, 'externalDocs']),
    );
    OpenApiGraph.i.addOpenApiNode(externalDocsNode!);
    externalDocsNode!.create();
    // Note: ExternalDocs node is connected but not via standard edges
  }

  void _createContent() {
    _createRaw();
    _createTyped();
    _createEffective();
  }

  void _createRaw() {
    raw = RawSchema.fromJson(json);
    _isRawSet = true;
  }

  void _createTyped() {
    typed = TypedSchema.fromRaw(this, raw, OpenApiGraph.i.validationContext);
    isTypedSet = true;
  }

  void _createEffective() {
    effective = EffectiveSchema.fromTyped(this, typed, OpenApiGraph.i.validationContext);
    isEffectiveSet = true;
  }
}
