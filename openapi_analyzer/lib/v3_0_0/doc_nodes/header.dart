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
import 'components.dart';
import 'response.dart';
import 'operation.dart';
import 'path_item.dart';
import '../map_doc_node.dart';

class HeaderDocNode extends DocNode with DocInternalNode, Referencable {
  HeaderDocNode(super.json, super.document, super.jsonPointer);

  late final String? description;
  late final bool required_;
  late final bool deprecated;
  late final bool allowEmptyValue;
  late final ParameterStyle? style;
  late final bool? explode;
  late final bool allowReserved;
  late final SchemasMapDocNode? schema;
  late final dynamic example;
  late final ExamplesMapDocNode? examples;
  late final MediaTypesMapDocNode? content;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateDescription(jsonPointer);
    _validateRequired(jsonPointer);
    _validateDeprecated(jsonPointer);
    _validateAllowEmptyValue(jsonPointer);
    _validateStyle(jsonPointer);
    _validateExplode(jsonPointer);
    _validateAllowReserved(jsonPointer);
    _validateSchema(jsonPointer);
    _validateExamples(jsonPointer);
    _validateContent(jsonPointer);
    _validateExampleMutualExclusivity(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
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

  void _validateStyle(String jsonPointer) {
    if (json.containsKey('style')) {
      ValidationUtils.validateEnum(
        ValidationUtils.requireString(json['style'], ValidationUtils.buildPointer([jsonPointer, 'style'])),
        ['simple'],
        ValidationUtils.buildPointer([jsonPointer, 'style']),
      );
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

  void _validateSchema(String jsonPointer) {
    if (json.containsKey('schema')) {
      ValidationUtils.requireMap(json['schema'], ValidationUtils.buildPointer([jsonPointer, 'schema']));
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

  void _validateExampleMutualExclusivity(String jsonPointer) {
    if (json.containsKey('example') && json.containsKey('examples')) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          jsonPointer,
          'Header Object cannot have both "example" and "examples"',
          specReference: 'OpenAPI 3.0.0 - Header Object',
          severity: ValidationSeverity.critical,
        ),
      );
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {
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
      'Header Object',
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
    description = json['description'];
    required_ = json['required'];
    deprecated = json['deprecated'];
    allowEmptyValue = json['allowEmptyValue'];
    style = json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null;
    explode = json['explode'];
    allowReserved = json['allowReserved'];
    schema = $to.to<SchemasMapDocNode>('schema');
    example = json['example'];
    examples = $to.to<ExamplesMapDocNode>('examples');
    content = $to.to<MediaTypesMapDocNode>('content');
    extensions = extractExtensions(json);
  }

  @override
  String get $name {
    // Check if we already computed a name for this header
    final cached = OpenApiGraph.i.nameRegistry.getCachedHeaderName($id.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerHeaderName($id.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: If it's a component, use the component key (check first to take precedence)
    final componentBased = _deriveFromComponent();
    if (componentBased != null) return componentBased;

    // Step 2: Use the header map key
    final keyBased = _deriveFromHeaderKey();
    if (keyBased != null) return keyBased;

    // Step 3: Hash-based fallback
    return _generateHashFallback();
  }

  String? _deriveFromComponent() {
    // Check if this is a component header
    // Path: header ← headersMap ← components
    final edge = trueParentEdge<HeadersMapDocNode>();
    if (edge != null) {
      final headersMapDocNode = edge.from as HeadersMapDocNode;
      // Check if parent is components
      if (headersMapDocNode.trueParentEdge<ComponentsDocNode>('headers') != null) {
        final componentKey = edge.via; // The map key
        return NamingUtils.toPascalCase(componentKey);
      }
    }
    return null;
  }

  String? _deriveFromHeaderKey() {
    // Get the header key from the HeadersMapDocNode edge
    // Path: header ← headersMap
    // Only use this if it's NOT a component (components are handled in Step 1)
    final edge = trueParentEdge<HeadersMapDocNode>();
    if (edge != null) {
      final headersMapDocNode = edge.from as HeadersMapDocNode;
      // Skip if it's a component (already handled)
      if (headersMapDocNode.trueParentEdge<ComponentsDocNode>('headers') == null) {
        final headerKey = edge.via; // The map key (e.g., "X-Rate-Limit", "ETag")
        return '${NamingUtils.toPascalCase(headerKey)}Header';
      }
    }
    return null;
  }

  String _generateHashFallback() {
    // Create a deterministic hash from the identity
    String identity;

    // Check if it's a component
    final edge = trueParentEdge<HeadersMapDocNode>();
    if (edge != null) {
      final headersMapDocNode = edge.from as HeadersMapDocNode;

      // Check if it's a component header
      if (headersMapDocNode.trueParentEdge<ComponentsDocNode>('headers') != null) {
        final componentKey = edge.via;
        identity = '${$id.document}#/components/headers/$componentKey';
      } else {
        // It's inline - use document URI, path, method, "headers", headerKey
        final headerKey = edge.via;

        // Try to find the operation through the response
        final responseNode = headersMapDocNode.trueParent<ResponseDocNode>('headers');
        if (responseNode != null) {
          // Get the responses map edge to get status code
          final respEdge = responseNode.trueParentEdge<ResponsesMapDocNode>();
          if (respEdge != null) {
            final responsesMapDocNode = respEdge.from as ResponsesMapDocNode;
            final operation = responsesMapDocNode.trueParent<OperationDocNode>('responses');
            if (operation != null) {
              // Get path and method from the operation
              final pathAndMethod = _getPathAndMethodFromOperation(operation);
              if (pathAndMethod != null) {
                identity = '${$id.document}|${pathAndMethod['path']}|${pathAndMethod['method']}|headers|$headerKey';
              } else {
                identity = $id.absolutePointer;
              }
            } else {
              identity = $id.absolutePointer;
            }
          } else {
            identity = $id.absolutePointer;
          }
        } else {
          identity = $id.absolutePointer;
        }
      }
    } else {
      identity = $id.absolutePointer;
    }

    final codeUnits = identity.codeUnits;
    final hash = codeUnits.fold<int>(0, (prev, code) => (prev * 31 + code) & 0xFFFFFFFF);
    final shortHash = hash.toRadixString(16).padLeft(8, '0').substring(0, 6);
    return 'Header_$shortHash';
  }

  Map<String, String>? _getPathAndMethodFromOperation(OperationDocNode operation) {
    // Operation is connected to PathItem via HTTP method edge
    for (final edge in operation.$from.where((e) => e.from is PathItemDocNode)) {
      final pathItemNode = edge.from as PathItemDocNode;
      final method = edge.via; // get_, post, put, etc.

      // Get the path from PathsMap
      for (final pathEdge in pathItemNode.$from.where((e) => e.from is PathsMapDocNode)) {
        final path = pathEdge.via; // The map key is the path
        return {'path': path, 'method': method};
      }
    }
    return null;
  }
}

class HeadersMapDocNode extends MapDocNode<HeaderDocNode> {
  HeadersMapDocNode(super.json, super.document, super.jsonPointer);
}
