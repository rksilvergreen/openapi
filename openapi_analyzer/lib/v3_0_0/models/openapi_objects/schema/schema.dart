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
import '../../../naming/naming_utils.dart';
import '../operation.dart';
import '../parameter.dart';
import '../components.dart';
import '../media_type.dart';
import '../media_types_map.dart';
import '../request_body.dart';
import '../response.dart';
import '../responses_map.dart';
import '../header.dart';
import '../headers_map.dart';
import '../parameters_list.dart';
import '../path_item.dart';
import '../paths_map.dart';

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
  String get $name;
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

  String get $name {
    // Check if we already computed a name for this schema
    final cached = OpenApiGraph.i.getCachedSchemaName($id.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.registerSchemaName($id.absolutePointer, sanitized);
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
    final edge = trueParentEdge<SchemasMapNode>();
    if (edge != null) {
      final schemasMapNode = edge.from as SchemasMapNode;
      if (schemasMapNode.trueParentEdge<ComponentsNode>('schemas') != null) {
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
    final mediaTypeNode = trueParent<MediaTypeNode>('schema');
    if (mediaTypeNode != null) {
      final mediaTypesMapNode = mediaTypeNode.trueParent<MediaTypesMapNode>('content');
      final requestBodyNode = mediaTypesMapNode?.trueParent<RequestBodyNode>('content');
      final operation = requestBodyNode?.trueParent<OperationNode>('requestBody');

      if (operation != null) {
        return '${operation.$name}Request';
      }

      // Check for response body schema (same mediaType, different path)
      // Path: schema ← mediaType ← mediaTypesMap ← response ← responsesMap ← operation
      final responseNode = mediaTypesMapNode?.trueParent<ResponseNode>('content');
      if (responseNode != null) {
        // Need edge to get status code (via)
        final respEdge = responseNode.trueParentEdge<ResponsesMapNode>('responses');
        if (respEdge != null) {
          final responsesMapNode = respEdge.from as ResponsesMapNode;
          final statusCode = respEdge.via; // The map key is the status code
          final operation = responsesMapNode.trueParent<OperationNode>('responses');

          if (operation != null) {
            return '${operation.$name}${NamingUtils.statusCodeToName(statusCode)}Response';
          }
        }
      }
    }

    // Check for parameter schema
    // Path: schema ← parameter ← parametersList ← operation/pathItem
    final parameterNode = trueParent<ParameterNode>('schema');
    if (parameterNode != null) {
      final paramName = parameterNode.name;
      final parametersListNode = parameterNode.trueParent<ParametersListNode>('parameters');

      if (parametersListNode != null) {
        // Check if it's from an operation
        final operation = parametersListNode.trueParent<OperationNode>('parameters');
        if (operation != null) {
          return '${operation.$name}${NamingUtils.toPascalCase(paramName)}Param';
        }

        // Check if it's from a path item
        final pathItemNode = parametersListNode.trueParent<PathItemNode>('parameters');
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
    final headerNode = trueParent<HeaderNode>('schema');
    if (headerNode != null) {
      final headerEdge = headerNode.trueParentEdge<HeadersMapNode>('headers');
      if (headerEdge != null) {
        final headersMapNode = headerEdge.from as HeadersMapNode;
        final headerName = headerEdge.via; // The map key is the header name

        // Check if it's from a response
        final responseNode = headersMapNode.trueParent<ResponseNode>('headers');
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
      if (edge.from is SchemasMapNode) {
        final schemasMapNode = edge.from as SchemasMapNode;
        if (schemasMapNode.trueParent<SchemaNode>('properties') == parentNode) {
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
      if (edge.from is SchemasListNode) {
        final listNode = edge.from as SchemasListNode;

        // allOf: {Parent}AllOf{i}
        if (listNode.trueParent<SchemaNode>('allOf') == parentNode) {
          final index = int.tryParse(edge.via);
          if (index != null) {
            return '${parentName}AllOf${index + 1}';
          }
        }

        // oneOf: {Parent}Variant{i}
        if (listNode.trueParent<SchemaNode>('oneOf') == parentNode) {
          final index = int.tryParse(edge.via);
          if (index != null) {
            return '${parentName}Variant${index + 1}';
          }
        }

        // anyOf: {Parent}Variant{i}
        if (listNode.trueParent<SchemaNode>('anyOf') == parentNode) {
          final index = int.tryParse(edge.via);
          if (index != null) {
            return '${parentName}Variant${index + 1}';
          }
        }
      }
    }

    return null;
  }

  OperationNode? _findOperationFromResponse(ResponseNode responseNode) {
    final responsesMapNode = responseNode.parent<ResponsesMapNode>('responses', EdgeForm.inline);
    return responsesMapNode?.parent<OperationNode>('responses', EdgeForm.inline);
  }

  String? _getPathFromPathItem(PathItemNode pathItemNode) {
    // Get the path from the edge connecting PathItem to PathsMap
    for (final edge in pathItemNode.$from.where((e) => e.from is PathsMapNode)) {
      return edge.via; // The map key is the path
    }
    return null;
  }

  SchemaNode? _findParentSchema() {
    // Look through incoming edges to find parent schema
    for (final edge in $from) {
      if (edge.from is SchemaNode) {
        return edge.from as SchemaNode;
      }
      // Properties map - need to go one level up
      if (edge.from is SchemasMapNode) {
        final mapNode = edge.from as SchemasMapNode;
        final parentSchema = mapNode.parent<SchemaNode>('properties', EdgeForm.inline);
        if (parentSchema != null) return parentSchema;
      }
      // allOf/oneOf/anyOf list - need to go one level up
      if (edge.from is SchemasListNode) {
        final listNode = edge.from as SchemasListNode;
        // Check all possible composition keywords
        for (final keyword in ['allOf', 'oneOf', 'anyOf']) {
          final parentSchema = listNode.parent<SchemaNode>(keyword, EdgeForm.inline);
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
