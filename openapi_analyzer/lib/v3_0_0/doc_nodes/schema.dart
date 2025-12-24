import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../validation_exception.dart';
import '../referencable.dart';
import 'external_documentation.dart';
import 'xml.dart';
import '../doc_node.dart';
import 'discriminator.dart';
import '../naming/naming_utils.dart';
import 'operation.dart';
import 'parameter.dart';
import 'components.dart';
import 'media_type.dart';
import 'request_body.dart';
import 'response.dart';
import 'header.dart';
import 'path_item.dart';
import '../edge.dart';
import '../map_doc_node.dart';
import '../list_doc_node.dart';
import 'package:openapi_analyzer/v3_0_0/nodes/schema/schema.dart';

class SchemaDocNode extends DocNode with Referencable, DocInternalNode {
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
  late final SchemaDocNode? items;

  // Object validations
  late final int? maxProperties;
  late final int? minProperties;
  late final List<String>? required_;
  late final SchemasMapDocNode? properties;
  late final bool? additionalPropertiesAllowed;
  late final SchemaDocNode? additionalProperties;

  // Composition
  late final SchemasListDocNode? allOf;
  late final SchemasListDocNode? oneOf;
  late final SchemasListDocNode? anyOf;

  // Generic
  late final List<dynamic>? enum_;

  // OpenAPI-specific
  late final bool nullable;
  late final DiscriminatorDocNode? discriminator;
  late final bool readOnly;
  late final bool writeOnly;
  late final XMLDocNode? xml;
  late final ExternalDocumentationDocNode? externalDocs;
  late final dynamic example;
  late final bool deprecated;
  late final Map<String, dynamic>? extensions;

  SchemaDocNode(super.json, super.document, super.jsonPointer);

  late final TypedSchemaImpl $typed;
  late final EffectiveSchemaImpl $effective;

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
    createNode<SchemasMapDocNode>(jsonKey: 'properties');
    createNode<SchemaDocNode>(jsonKey: 'items');
    if (json['additionalProperties'] is Map) {
      createNode<SchemaDocNode>(jsonKey: 'additionalProperties');
    }
    createNode<SchemasListDocNode>(jsonKey: 'allOf');
    createNode<SchemasListDocNode>(jsonKey: 'oneOf');
    createNode<SchemasListDocNode>(jsonKey: 'anyOf');
    createNode<XMLDocNode>(jsonKey: 'xml');
    createNode<ExternalDocumentationDocNode>(jsonKey: 'externalDocs');
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
    items = $to.to<SchemaDocNode>('items');
    maxProperties = json['maxProperties'];
    minProperties = json['minProperties'];
    required_ = json['required'];
    properties = $to.to<SchemasMapDocNode>('properties');
    additionalPropertiesAllowed = json['additionalProperties'] is bool ? json['additionalProperties'] : null;
    additionalProperties = $to.to<SchemaDocNode>('additionalProperties');
    allOf = $to.to<SchemasListDocNode>('allOf');
    oneOf = $to.to<SchemasListDocNode>('oneOf');
    anyOf = $to.to<SchemasListDocNode>('anyOf');
    discriminator = $to.to<DiscriminatorDocNode>('discriminator');
    readOnly = json['readOnly'];
    writeOnly = json['writeOnly'];
    xml = $to.to<XMLDocNode>('xml');
    externalDocs = $to.to<ExternalDocumentationDocNode>('externalDocs');
    example = json['example'];
    deprecated = json['deprecated'];
    extensions = extractExtensions(json);
    _createTyped();
    _createEffective();
  }

  void _createTyped() {
    $typed = TypedSchemaImpl.of(this, OpenApiGraph.i.validationContext);
  }

  void _createEffective() {
    $effective = EffectiveSchemaImpl.fromTyped(this, $typed, OpenApiGraph.i.validationContext);
  }

  String get $name {
    // Check if we already computed a name for this schema
    final cached = OpenApiGraph.i.nameRegistry.getCachedSchemaName($id.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerSchemaName($id.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: If under components/schemas/{key}, use the key
    final componentsName = _deriveFromComponents();
    if (componentsName != null) return componentsName;

    // Step 2: If schema has title, use it
    final titleName = _deriveFromTitle();
    if (titleName != null) return titleName;

    // Step 3: Derive from OpenAPI context
    final contextName = _deriveFromContext();
    if (contextName != null) return contextName;

    // Step 4: Derive from parent schema
    final parentName = _deriveFromParent();
    if (parentName != null) return parentName;

    // Step 5: Use hash fallback
    return _generateHashFallback();
  }

  String? _deriveFromComponents() {
    final edge = trueParentEdge<SchemasMapDocNode>();
    if (edge != null) {
      final schemasMapDocNode = edge.from as SchemasMapDocNode;
      if (schemasMapDocNode.trueParentEdge<ComponentsDocNode>('schemas') != null) {
        return NamingUtils.toPascalCase(edge.via);
      }
    }
    return null;
  }

  String? _deriveFromTitle() {
    if (title != null && title!.isNotEmpty) {
      return NamingUtils.toPascalCase(title!);
    }
    return null;
  }

  String? _deriveFromContext() {
    // Check for request body schema
    // Path: schema ← mediaType ← mediaTypesMap ← requestBody ← operation
    final mediaTypeNode = trueParent<MediaTypeDocNode>('schema');
    if (mediaTypeNode != null) {
      final mediaTypesMapDocNode = mediaTypeNode.trueParent<MediaTypesMapDocNode>('content');
      final requestBodyNode = mediaTypesMapDocNode?.trueParent<RequestBodyDocNode>('content');
      final operation = requestBodyNode?.trueParent<OperationDocNode>('requestBody');

      if (operation != null) {
        return '${operation.$name}Request';
      }

      // Check for response body schema (same mediaType, different path)
      // Path: schema ← mediaType ← mediaTypesMap ← response ← responsesMap ← operation
      final responseNode = mediaTypesMapDocNode?.trueParent<ResponseDocNode>('content');
      if (responseNode != null) {
        // Need edge to get status code (via)
        final respEdge = responseNode.trueParentEdge<ResponsesMapDocNode>('responses');
        if (respEdge != null) {
          final responsesMapDocNode = respEdge.from as ResponsesMapDocNode;
          final statusCode = respEdge.via; // The map key is the status code
          final operation = responsesMapDocNode.trueParent<OperationDocNode>('responses');

          if (operation != null) {
            return '${operation.$name}${NamingUtils.statusCodeToName(statusCode)}Response';
          }
        }
      }
    }

    // Check for parameter schema
    // Path: schema ← parameter ← parametersList ← operation/pathItem
    final parameterNode = trueParent<ParameterDocNode>('schema');
    if (parameterNode != null) {
      final paramName = parameterNode.name;
      final parametersListDocNode = parameterNode.trueParent<ParametersListDocNode>('parameters');

      if (parametersListDocNode != null) {
        // Check if it's from an operation
        final operation = parametersListDocNode.trueParent<OperationDocNode>('parameters');
        if (operation != null) {
          return '${operation.$name}${NamingUtils.toPascalCase(paramName)}Param';
        }

        // Check if it's from a path item
        final pathItemNode = parametersListDocNode.trueParent<PathItemDocNode>('parameters');
        if (pathItemNode != null) {
          final path = _getPathFromPathItem(pathItemNode);
          if (path != null) {
            return NamingUtils.toPascalCase(Uri.decodeComponent(path)) + NamingUtils.toPascalCase(paramName) + 'Param';
          }
        }
      }
    }

    // Check for header schema
    // Path: schema ← header ← headersMap ← response
    // Need edge to get header name (via)
    final headerNode = trueParent<HeaderDocNode>('schema');
    if (headerNode != null) {
      final headerEdge = headerNode.trueParentEdge<HeadersMapDocNode>('headers');
      if (headerEdge != null) {
        final headersMapDocNode = headerEdge.from as HeadersMapDocNode;
        final headerName = headerEdge.via; // The map key is the header name

        // Check if it's from a response
        final responseNode = headersMapDocNode.trueParent<ResponseDocNode>('headers');
        if (responseNode != null) {
          // Try to find the operation
          final operation = _findOperationFromResponse(responseNode);
          if (operation != null) {
            return '${operation.$name}${NamingUtils.toPascalCase(headerName)}Header';
          }
        }

        // If no operation found, use just the header name
        return NamingUtils.toPascalCase(headerName) + 'Header';
      }
    }

    return null;
  }

  String? _deriveFromParent() {
    // Get parent schema if this is nested
    final parentNode = _findParentSchema();
    if (parentNode == null) return null;

    final parentName = parentNode.$name;

    // Check the edge to determine relationship
    for (final edge in $from.where((e) => e.form == EdgeForm.inline)) {
      // Property schema: {Parent}{Prop}
      if (edge.from is SchemasMapDocNode) {
        final schemasMapDocNode = edge.from as SchemasMapDocNode;
        if (schemasMapDocNode.trueParent<SchemaDocNode>('properties') == parentNode) {
          final propertyName = edge.via;
          return parentName + NamingUtils.toPascalCase(propertyName);
        }
      }

      // Array items: {Parent}Item
      if (edge.from == parentNode && edge.via == 'items') {
        return parentName + 'Item';
      }

      // Additional properties: {Parent}Value
      if (edge.from == parentNode && edge.via == 'additionalProperties') {
        return parentName + 'Value';
      }

      // not: {Parent}Not
      if (edge.from == parentNode && edge.via == 'not') {
        return parentName + 'Not';
      }

      // allOf/oneOf/anyOf composition
      if (edge.from is SchemasListDocNode) {
        final listNode = edge.from as SchemasListDocNode;

        // allOf: {Parent}AllOf{i}
        if (listNode.trueParent<SchemaDocNode>('allOf') == parentNode) {
          final index = int.tryParse(edge.via);
          if (index != null) {
            return '${parentName}AllOf${index + 1}';
          }
        }

        // oneOf: {Parent}Variant{i}
        if (listNode.trueParent<SchemaDocNode>('oneOf') == parentNode) {
          final index = int.tryParse(edge.via);
          if (index != null) {
            return '${parentName}Variant${index + 1}';
          }
        }

        // anyOf: {Parent}Variant{i}
        if (listNode.trueParent<SchemaDocNode>('anyOf') == parentNode) {
          final index = int.tryParse(edge.via);
          if (index != null) {
            return '${parentName}Variant${index + 1}';
          }
        }
      }
    }

    return null;
  }

  OperationDocNode? _findOperationFromResponse(ResponseDocNode responseNode) {
    final responsesMapDocNode = responseNode.parent<ResponsesMapDocNode>('responses', EdgeForm.inline);
    return responsesMapDocNode?.parent<OperationDocNode>('responses', EdgeForm.inline);
  }

  String? _getPathFromPathItem(PathItemDocNode pathItemNode) {
    // Get the path from the edge connecting PathItem to PathsMap
    for (final edge in pathItemNode.$from.where((e) => e.from is PathsMapDocNode)) {
      return edge.via; // The map key is the path
    }
    return null;
  }

  SchemaDocNode? _findParentSchema() {
    // Look through incoming edges to find parent schema
    for (final edge in $from) {
      if (edge.from is SchemaDocNode) {
        return edge.from as SchemaDocNode;
      }
      // Properties map - need to go one level up
      if (edge.from is SchemasMapDocNode) {
        final mapNode = edge.from as SchemasMapDocNode;
        final parentSchema = mapNode.parent<SchemaDocNode>('properties', EdgeForm.inline);
        if (parentSchema != null) return parentSchema;
      }
      // allOf/oneOf/anyOf list - need to go one level up
      if (edge.from is SchemasListDocNode) {
        final listNode = edge.from as SchemasListDocNode;
        // Check all possible composition keywords
        for (final keyword in ['allOf', 'oneOf', 'anyOf']) {
          final parentSchema = listNode.parent<SchemaDocNode>(keyword, EdgeForm.inline);
          if (parentSchema != null) return parentSchema;
        }
      }
    }
    return null;
  }

  String _generateHashFallback() {
    // Create a deterministic hash from the absolute pointer
    final codeUnits = $id.absolutePointer.codeUnits;
    final hash = codeUnits.fold<int>(0, (prev, code) => (prev * 31 + code) & 0xFFFFFFFF);
    final shortHash = hash.toRadixString(16).padLeft(8, '0').substring(0, 6);
    return 'Anon_$shortHash';
  }
}

class SchemasMapDocNode extends MapDocNode<SchemaDocNode> {
  SchemasMapDocNode(super.json, super.document, super.jsonPointer);
}

class SchemasListDocNode extends ListDocNode<SchemaDocNode> {
  SchemasListDocNode(super.json, super.document, super.jsonPointer);
}
