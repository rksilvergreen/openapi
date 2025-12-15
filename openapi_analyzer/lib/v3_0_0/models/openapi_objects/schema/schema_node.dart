import '../../openapi_graph.dart';
import '../../../validation/validation_utils.dart';
import '../../../../validation_exception.dart';
import 'raw_schema.dart';
import 'typed_schema/typed_schema.dart';
import 'effective_schema/effective_schema.dart';
import '../external_documentation.dart';
import '../xml.dart';

class SchemaNode extends Node {
  SchemaNode(super.$id, super.json);

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
    final path = $id.relativePath;

    _validateType(path);
    _validateNumericConstraints(path);
    _validateStringConstraints(path);
    _validateArrayConstraints(path);
    _validateObjectConstraints(path);
    _validateCompositionKeywords(path);
    _validateRef(path);
    _validateOpenApiSpecificFields(path);
  }

  void _validateType(String path) {
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
        ], ValidationUtils.buildPath(path, 'type'));
      } else if (type != null) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPath(path, 'type'),
            'type must be a string',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }

  void _validateNumericConstraints(String path) {
    if (json.containsKey('minimum')) {
      ValidationUtils.requireNumber(json['minimum'], ValidationUtils.buildPath(path, 'minimum'));
    }
    if (json.containsKey('maximum')) {
      ValidationUtils.requireNumber(json['maximum'], ValidationUtils.buildPath(path, 'maximum'));
    }
    if (json.containsKey('exclusiveMinimum')) {
      ValidationUtils.requireNumber(json['exclusiveMinimum'], ValidationUtils.buildPath(path, 'exclusiveMinimum'));
    }
    if (json.containsKey('exclusiveMaximum')) {
      ValidationUtils.requireNumber(json['exclusiveMaximum'], ValidationUtils.buildPath(path, 'exclusiveMaximum'));
    }
    if (json.containsKey('multipleOf')) {
      final val = ValidationUtils.requireNumber(json['multipleOf'], ValidationUtils.buildPath(path, 'multipleOf'));
      ValidationUtils.validatePositive(val, ValidationUtils.buildPath(path, 'multipleOf'));
    }
  }

  void _validateStringConstraints(String path) {
    if (json.containsKey('minLength')) {
      final val = ValidationUtils.requireInt(json['minLength'], ValidationUtils.buildPath(path, 'minLength'));
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPath(path, 'minLength'));
    }
    if (json.containsKey('maxLength')) {
      final val = ValidationUtils.requireInt(json['maxLength'], ValidationUtils.buildPath(path, 'maxLength'));
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPath(path, 'maxLength'));
    }
    if (json.containsKey('pattern')) {
      final pattern = ValidationUtils.requireString(json['pattern'], ValidationUtils.buildPath(path, 'pattern'));
      ValidationUtils.validateRegexPattern(pattern, ValidationUtils.buildPath(path, 'pattern'));
    }
  }

  void _validateArrayConstraints(String path) {
    if (json.containsKey('minItems')) {
      final val = ValidationUtils.requireInt(json['minItems'], ValidationUtils.buildPath(path, 'minItems'));
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPath(path, 'minItems'));
    }
    if (json.containsKey('maxItems')) {
      final val = ValidationUtils.requireInt(json['maxItems'], ValidationUtils.buildPath(path, 'maxItems'));
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPath(path, 'maxItems'));
    }
    if (json.containsKey('uniqueItems')) {
      ValidationUtils.requireBool(json['uniqueItems'], ValidationUtils.buildPath(path, 'uniqueItems'));
    }
    if (json.containsKey('items')) {
      // items MUST be an object per OpenAPI 3.0.0 Schema Object specification
      ValidationUtils.requireMap(json['items'], ValidationUtils.buildPath(path, 'items'));
    }
  }

  void _validateObjectConstraints(String path) {
    if (json.containsKey('minProperties')) {
      final val = ValidationUtils.requireInt(json['minProperties'], ValidationUtils.buildPath(path, 'minProperties'));
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPath(path, 'minProperties'));
    }
    if (json.containsKey('maxProperties')) {
      final val = ValidationUtils.requireInt(json['maxProperties'], ValidationUtils.buildPath(path, 'maxProperties'));
      ValidationUtils.validateNonNegative(val, ValidationUtils.buildPath(path, 'maxProperties'));
    }
    if (json.containsKey('required')) {
      final required = ValidationUtils.requireList(json['required'], ValidationUtils.buildPath(path, 'required'));
      for (var i = 0; i < required.length; i++) {
        ValidationUtils.requireString(
          required[i],
          ValidationUtils.buildPath(ValidationUtils.buildPath(path, 'required'), '[$i]'),
        );
      }
    }
    if (json.containsKey('properties')) {
      ValidationUtils.requireMap(json['properties'], ValidationUtils.buildPath(path, 'properties'));
    }
    if (json.containsKey('additionalProperties')) {
      // Can be boolean or object per OpenAPI 3.0.0 Schema Object specification
      final val = json['additionalProperties'];
      if (val is! bool && val is! Map) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPath(path, 'additionalProperties'),
            'additionalProperties must be a boolean or object',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }

  void _validateCompositionKeywords(String path) {
    if (json.containsKey('allOf')) {
      ValidationUtils.requireList(json['allOf'], ValidationUtils.buildPath(path, 'allOf'));
    }
    if (json.containsKey('oneOf')) {
      ValidationUtils.requireList(json['oneOf'], ValidationUtils.buildPath(path, 'oneOf'));
    }
    if (json.containsKey('anyOf')) {
      ValidationUtils.requireList(json['anyOf'], ValidationUtils.buildPath(path, 'anyOf'));
    }
    if (json.containsKey('not')) {
      ValidationUtils.requireMap(json['not'], ValidationUtils.buildPath(path, 'not'));
    }
  }

  void _validateRef(String path) {
    if (json.containsKey('\$ref')) {
      ValidationUtils.requireString(json['\$ref'], ValidationUtils.buildPath(path, '\$ref'));
    }
  }

  void _validateOpenApiSpecificFields(String path) {
    if (json.containsKey('nullable')) {
      ValidationUtils.requireBool(json['nullable'], ValidationUtils.buildPath(path, 'nullable'));
    }
    if (json.containsKey('discriminator')) {
      ValidationUtils.requireMap(json['discriminator'], ValidationUtils.buildPath(path, 'discriminator'));
    }
    if (json.containsKey('readOnly')) {
      ValidationUtils.requireBool(json['readOnly'], ValidationUtils.buildPath(path, 'readOnly'));
    }
    if (json.containsKey('writeOnly')) {
      ValidationUtils.requireBool(json['writeOnly'], ValidationUtils.buildPath(path, 'writeOnly'));
    }
    if (json.containsKey('xml')) {
      ValidationUtils.requireMap(json['xml'], ValidationUtils.buildPath(path, 'xml'));
    }
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPath(path, 'externalDocs'));
    }
    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }
  }

  void _createChildNodes() {
    // Handle $ref - if present, resolve it and create edge (no other children)
    if (_handleRef()) {
      return; // No other children when $ref is present
    }

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

  /// Handles $ref resolution. Returns true if $ref was present (and handled), false otherwise.
  bool _handleRef() {
    if (!json.containsKey('\$ref')) {
      return false;
    }

    final ref = json['\$ref'] as String;
    final resolved = OpenApiGraph.i.referenceResolver.parseReference(ref, $id.relativePath);

    // Load external document if needed
    Map<dynamic, dynamic> targetDoc;
    if (resolved.isExternal) {
      targetDoc = OpenApiGraph.i.referenceResolver.loadExternalDocument(resolved.documentPath);
    } else {
      targetDoc = OpenApiGraph.i.loadedDocuments[$id.document] ?? {};
    }

    // Resolve pointer within document
    final targetJson = OpenApiGraph.i.referenceResolver.resolvePointer(targetDoc, resolved.jsonPointer);

    if (targetJson == null) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          $id.relativePath,
          'Reference not found: $ref',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        ),
      );
      return true; // Cannot proceed without valid reference
    }

    // Check if referenced schema node already exists
    final targetNodeId = NodeId(resolved.documentPath, resolved.jsonPointer);
    SchemaNode targetNode;

    if (OpenApiGraph.i.schemaNodes.containsKey(targetNodeId.absolutePath)) {
      targetNode = OpenApiGraph.i.schemaNodes[targetNodeId.absolutePath]!;
    } else {
      // Create the referenced schema node recursively
      targetNode = SchemaNode(targetNodeId, targetJson as Map<String, dynamic>);
      OpenApiGraph.i.addSchemaNode(targetNode);
      targetNode.create();
    }

    // Note: $ref doesn't create a special edge type - the reference is resolved
    // The referring node effectively "becomes" the referenced node
    // We don't create edges for $ref - the node just points to the target
    return true;
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
        NodeId(
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'properties'), propertyName),
        ),
        propertyJson,
      );
      propertiesNodes![propertyName] = propertyNode;
      OpenApiGraph.i.addSchemaNode(propertyNode);
      OpenApiGraph.i.addSchemaStructuralEdge(PropertiesEdge($id.absolutePath, propertyNode.$id.absolutePath));
      propertyNode.create();
    }
  }

  void _createItemsNode() {
    if (!json.containsKey('items')) {
      return;
    }

    final items = json['items'] as Map<String, dynamic>;
    itemsNode = SchemaNode(NodeId($id.document, ValidationUtils.buildPath($id.relativePath, 'items')), items);
    OpenApiGraph.i.addSchemaNode(itemsNode);
    OpenApiGraph.i.addSchemaStructuralEdge(ItemsEdge($id.absolutePath, itemsNode.$id.absolutePath));
    itemsNode.create();
  }

  void _createAdditionalPropertiesNode() {
    if (!json.containsKey('additionalProperties')) {
      return;
    }

    final additionalProps = json['additionalProperties'];
    if (additionalProps is Map) {
      additionalPropertiesNode = SchemaNode(
        NodeId($id.document, ValidationUtils.buildPath($id.relativePath, 'additionalProperties')),
        additionalProps as Map<String, dynamic>,
      );
      OpenApiGraph.i.addSchemaNode(additionalPropertiesNode!);
      OpenApiGraph.i.addSchemaStructuralEdge(
        AdditionalPropertiesEdge($id.absolutePath, additionalPropertiesNode!.$id.absolutePath),
      );
      additionalPropertiesNode!.create();
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
        NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'allOf'), '[$i]')),
        allOfJson,
      );
      allOfNodes!.add(allOfNode);
      OpenApiGraph.i.addSchemaNode(allOfNode);
      OpenApiGraph.i.addSchemaApplicatorEdge(AllOfEdge($id.absolutePath, allOfNode.$id.absolutePath));
      allOfNode.create();
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
        NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'oneOf'), '[$i]')),
        oneOfJson,
      );
      oneOfNodes!.add(oneOfNode);
      OpenApiGraph.i.addSchemaNode(oneOfNode);
      OpenApiGraph.i.addSchemaApplicatorEdge(OneOfEdge($id.absolutePath, oneOfNode.$id.absolutePath));
      oneOfNode.create();
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
        NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'anyOf'), '[$i]')),
        anyOfJson,
      );
      anyOfNodes!.add(anyOfNode);
      OpenApiGraph.i.addSchemaNode(anyOfNode);
      OpenApiGraph.i.addSchemaApplicatorEdge(AnyOfEdge($id.absolutePath, anyOfNode.$id.absolutePath));
      anyOfNode.create();
    }
  }

  void _createXmlNode() {
    if (!json.containsKey('xml')) {
      return;
    }

    final xmlJson = json['xml'] as Map<String, dynamic>;
    xmlNode = XMLNode(NodeId($id.document, ValidationUtils.buildPath($id.relativePath, 'xml')), xmlJson);
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
      NodeId($id.document, ValidationUtils.buildPath($id.relativePath, 'externalDocs')),
      externalDocsJson,
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