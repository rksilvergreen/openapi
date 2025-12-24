import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../validation_exception.dart';
import '../referencable.dart';
import '../doc_node.dart';
import '../edge.dart';
import 'enums.dart';
import 'schema.dart';
import 'example.dart';
import 'media_type.dart';
import '../naming/naming_utils.dart';
import 'operation.dart';
import 'path_item.dart';
import '../list_doc_node.dart';
import '../map_doc_node.dart';

class ParameterDocNode extends DocNode with DocInternalNode, Referencable {
  ParameterDocNode(super.json, super.document, super.jsonPointer);

  late final String name;
  late final ParameterLocation in_;
  late final String? description;
  late final bool required_;
  late final bool deprecated;
  late final bool allowEmptyValue;
  late final ParameterStyle? style;
  late final bool? explode;
  late final bool allowReserved;
  late final SchemaDocNode? schema;
  late final dynamic example;
  late final ExamplesMapDocNode? examples;
  late final MediaTypesMapDocNode? content;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateName(jsonPointer);
    _validateIn(jsonPointer);
    _validateDescription(jsonPointer);
    _validateRequired(jsonPointer);
    _validateDeprecated(jsonPointer);
    _validateAllowEmptyValue(jsonPointer);
    _validateSchema(jsonPointer);
    _validateStyle(jsonPointer);
    _validateExplode(jsonPointer);
    _validateAllowReserved(jsonPointer);
    _validateExamples(jsonPointer);
    _validateContent(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateName(String jsonPointer) {
    final name = ValidationUtils.requireField(json, 'name', jsonPointer);
    ValidationUtils.requireString(name, ValidationUtils.buildPointer([jsonPointer, 'name']));
  }

  void _validateIn(String jsonPointer) {
    final inValue = ValidationUtils.requireField(json, 'in', jsonPointer);
    ValidationUtils.requireString(inValue, ValidationUtils.buildPointer([jsonPointer, 'in']));
    ValidationUtils.validateEnum(inValue as String, [
      'query',
      'header',
      'path',
      'cookie',
    ], ValidationUtils.buildPointer([jsonPointer, 'in']));

    // If in=path, required must be true
    if (inValue == 'path') {
      if (!json.containsKey('required') || json['required'] != true) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([jsonPointer, 'required']),
            'Parameter with in=path must have required=true',
            specReference: 'OpenAPI 3.0.0 - Parameter Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateRequired(String jsonPointer) {
    if (json.containsKey('required')) {
      ValidationUtils.requireBool(json['required'], ValidationUtils.buildPointer([jsonPointer, 'required']));
    }
  }

  void _validateDeprecated(String jsonPointer) {
    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPointer([jsonPointer, 'deprecated']));
    }
  }

  void _validateAllowEmptyValue(String jsonPointer) {
    if (json.containsKey('allowEmptyValue')) {
      ValidationUtils.requireBool(
        json['allowEmptyValue'],
        ValidationUtils.buildPointer([jsonPointer, 'allowEmptyValue']),
      );
    }
  }

  void _validateSchema(String jsonPointer) {
    if (json.containsKey('schema')) {
      ValidationUtils.requireMap(json['schema'], ValidationUtils.buildPointer([jsonPointer, 'schema']));
    }
  }

  void _validateStyle(String jsonPointer) {
    if (json.containsKey('style')) {
      ValidationUtils.requireString(json['style'], ValidationUtils.buildPointer([jsonPointer, 'style']));
    }
  }

  void _validateExplode(String jsonPointer) {
    if (json.containsKey('explode')) {
      ValidationUtils.requireBool(json['explode'], ValidationUtils.buildPointer([jsonPointer, 'explode']));
    }
  }

  void _validateAllowReserved(String jsonPointer) {
    if (json.containsKey('allowReserved')) {
      ValidationUtils.requireBool(json['allowReserved'], ValidationUtils.buildPointer([jsonPointer, 'allowReserved']));
    }
  }

  void _validateExamples(String jsonPointer) {
    if (json.containsKey('examples')) {
      ValidationUtils.requireMap(json['examples'], ValidationUtils.buildPointer([jsonPointer, 'examples']));
    }
  }

  void _validateContent(String jsonPointer) {
    if (json.containsKey('content')) {
      ValidationUtils.requireMap(json['content'], ValidationUtils.buildPointer([jsonPointer, 'content']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {
        'name',
        'in',
        'description',
        'required',
        'deprecated',
        'allowEmptyValue',
        'style',
        'explode',
        'allowReserved',
        'schema',
        'example',
        'examples',
        'content',
      },
      jsonPointer,
      'Parameter Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<SchemaDocNode>(jsonKey: 'schema');
    createNode<ExamplesMapDocNode>(jsonKey: 'examples');
    createNode<MediaTypesMapDocNode>(jsonKey: 'content');
  }

  @override
  void createContent() {
    name = json['name'];
    in_ = ParameterLocation.values.firstWhere((e) => e.value == json['in']);
    description = json['description'];
    required_ = json['required'] ?? false;
    deprecated = json['deprecated'] ?? false;
    allowEmptyValue = json['allowEmptyValue'] ?? false;
    style = json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null;
    explode = json['explode'];
    allowReserved = json['allowReserved'] ?? false;
    schema = $to.to<SchemaDocNode>('schema');
    example = json['example'];
    examples = $to.to<ExamplesMapDocNode>('examples');
    content = $to.to<MediaTypesMapDocNode>('content');
    extensions = extractExtensions(json);
  }

  @override
  String get $name {
    // Check if we already computed a name for this parameter
    final cached = OpenApiGraph.i.nameRegistry.getCachedParameterName($id.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerParameterName($id.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: Use parameter.name if present and valid
    final nameBased = _deriveFromName();
    if (nameBased != null) return nameBased;

    // Step 2: Derive from context
    final contextBased = _deriveFromContext();
    if (contextBased != null) return contextBased;

    // Step 3: Hash-based fallback
    return _generateHashFallback();
  }

  String? _deriveFromName() {
    if (name.isNotEmpty) {
      final sanitized = NamingUtils.toValidDartIdentifier(name);
      if (sanitized.isNotEmpty && sanitized != 'unnamed') {
        return NamingUtils.toPascalCase(name);
      }
    }
    return null;
  }

  String? _deriveFromContext() {
    final parametersListDocNode = trueParent<ParametersListDocNode>('parameters');
    if (parametersListDocNode == null) return null;

    // For path parameters, use the corresponding path segment name
    if (in_ == ParameterLocation.path) {
      final pathSegmentName = _getPathSegmentName();
      if (pathSegmentName != null) {
        return NamingUtils.toPascalCase(pathSegmentName);
      }
      // If we can't find the segment, fall through to hash fallback
      return null;
    }

    // For query/header/cookie parameters, derive from operation name + parameter location
    final operation = parametersListDocNode.trueParent<OperationDocNode>('parameters');
    if (operation != null) {
      final locationName = _getLocationName();
      return '${operation.$name}$locationName';
    }

    // If no operation, try to derive from path item
    final pathItemNode = parametersListDocNode.trueParent<PathItemDocNode>('parameters');
    if (pathItemNode != null) {
      final path = _getPathFromPathItem(pathItemNode);
      if (path != null) {
        final locationName = _getLocationName();
        final pathName = NamingUtils.toPascalCase(Uri.decodeComponent(path));
        return '$pathName$locationName';
      }
    }

    return null;
  }

  String? _getPathSegmentName() {
    // Get the path template from PathItem
    final pathItemNode = _findPathItem();
    if (pathItemNode == null) return null;

    final path = _getPathFromPathItem(pathItemNode);
    if (path == null) return null;

    // Extract path segments (e.g., "/pets/{petId}" -> ["pets", "{petId}"])
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();

    // Find the segment that matches this parameter's name
    for (final segment in segments) {
      // Remove curly braces and compare
      final segmentName = segment.replaceAll(RegExp(r'[{}]'), '');
      if (segmentName == name) {
        return segmentName;
      }
    }

    return null;
  }

  String _getLocationName() {
    switch (in_) {
      case ParameterLocation.query:
        return 'QueryParam';
      case ParameterLocation.header:
        return 'HeaderParam';
      case ParameterLocation.cookie:
        return 'CookieParam';
      case ParameterLocation.path:
        return 'PathParam';
    }
  }

  PathItemDocNode? _findPathItem() {
    final parametersListDocNode = trueParent<ParametersListDocNode>('parameters');
    if (parametersListDocNode == null) return null;

    // Check if it's from a path item
    final pathItemNode = parametersListDocNode.trueParent<PathItemDocNode>('parameters');
    if (pathItemNode != null) return pathItemNode;

    // Check if it's from an operation, then get the path item
    final operation = parametersListDocNode.trueParent<OperationDocNode>('parameters');
    if (operation != null) {
      // Operation is connected to PathItem via the HTTP method edge
      for (final edge in operation.$from.where((e) => e.from is PathItemDocNode)) {
        return edge.from as PathItemDocNode;
      }
    }

    return null;
  }

  String? _getPathFromPathItem(PathItemDocNode pathItemNode) {
    // Get the path from the edge connecting PathItem to PathsMap
    for (final edge in pathItemNode.$from.where((e) => e.from is PathsMapDocNode)) {
      return edge.via; // The map key is the path
    }
    return null;
  }

  int? _getParameterIndex() {
    final parametersListDocNode = trueParent<ParametersListDocNode>('parameters');
    if (parametersListDocNode == null) return null;

    // Find the index of this parameter in the list
    final parameters = parametersListDocNode.toList();
    for (int i = 0; i < parameters.length; i++) {
      if (parameters[i] == this) {
        return i;
      }
    }
    return null;
  }

  String? _getHttpMethod() {
    final operation = _findOperation();
    if (operation == null) return null;

    // Get the HTTP method from the edge connecting Operation to PathItem
    for (final edge in operation.$from.where((e) => e.from is PathItemDocNode)) {
      return edge.via; // get_, post, put, etc.
    }
    return null;
  }

  OperationDocNode? _findOperation() {
    final parametersListDocNode = trueParent<ParametersListDocNode>('parameters');
    if (parametersListDocNode == null) return null;

    return parametersListDocNode.trueParent<OperationDocNode>('parameters');
  }

  String _generateHashFallback() {
    // Create a deterministic hash from: document URI, path template, HTTP method, parameter location, parameter index
    final pathItemNode = _findPathItem();
    final path = pathItemNode != null ? _getPathFromPathItem(pathItemNode) ?? '' : '';
    final method = _getHttpMethod() ?? '';
    final location = in_.value;
    final index = _getParameterIndex() ?? 0;

    final identity = '${$id.document}|$path|$method|$location|$index';
    final codeUnits = identity.codeUnits;
    final hash = codeUnits.fold<int>(0, (prev, code) => (prev * 31 + code) & 0xFFFFFFFF);
    final shortHash = hash.toRadixString(16).padLeft(8, '0').substring(0, 6);
    return 'Param_$shortHash';
  }
}

class ParametersListDocNode extends ListDocNode<ParameterDocNode> {
  ParametersListDocNode(super.json, super.document, super.jsonPointer);
}

class ParametersMapDocNode extends MapDocNode<ParameterDocNode> {
  ParametersMapDocNode(super.json, super.document, super.jsonPointer);
}
