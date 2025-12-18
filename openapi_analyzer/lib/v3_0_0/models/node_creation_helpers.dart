import 'openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../../validation_exception.dart';

typedef NodeFactory<T> = T Function(Map<String, dynamic> json, String document, String jsonPointer);

/// Extension providing helper methods for creating child nodes.
/// These methods handle the common patterns of node creation, edge addition, and node reuse.
extension NodeCreationHelpers on OpenApiNode {
  /// Checks if the JSON contains a $ref.
  bool _isRef(Map<String, dynamic> json) {
    return json.containsKey('\$ref');
  }

  /// Resolves a $ref reference, returning the target (json, document, jsonPointer).
  (Map<String, dynamic>, String, String) _resolveRef({
    required Map<String, dynamic> json,
    required String jsonPointer,
  }) {
    final ref = ValidationUtils.requireString(json['\$ref'], ValidationUtils.buildPointer([jsonPointer, '\$ref']));
    ValidationUtils.validateNoUnknownFields(json, {'\$ref'}, jsonPointer, 'Reference Object');
    return OpenApiGraph.i.referenceResolver.resolveReference(ref, jsonPointer);
  }

  bool _containsKey(String jsonKey, bool required) {
    if (!json.containsKey(jsonKey)) {
      if (required) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([$id.jsonPointer, jsonKey]),
            'Required field "$jsonKey" is missing',
            specReference: 'OpenAPI 3.0.0 Specification',
            severity: ValidationSeverity.critical,
          ),
        );
      }
      return false;
    }
    return true;
  }

  /// Creates a single node (handles $ref resolution and node reuse for referencable nodes).
  /// Returns the existing node if it was already created (for referencable nodes), otherwise creates and returns a new one.
  T? createNode<T extends OpenApiNode>({required String jsonKey, bool required = false}) {
    if (!_containsKey(jsonKey, required)) {
      return null;
    }

    final originalJson = json[jsonKey] as Map<String, dynamic>;
    final originalJsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, jsonKey]);

    // Check if it's a reference and resolve if needed
    final isRef = _isRef(originalJson);
    final (resolvedJson, resolvedDocument, resolvedJsonPointer) = isRef
        ? _resolveRef(json: originalJson, jsonPointer: originalJsonPointer)
        : (originalJson, $id.document, originalJsonPointer);

    final via = jsonKey;
    // Determine the 'form' argument: use referenced for refs, inline otherwise
    final form = isRef ? EdgeForm.referenced : EdgeForm.inline;

    // Check if node already exists at the resolved location
    final absolutePointer = '$resolvedDocument#$resolvedJsonPointer';
    final existingNode = OpenApiGraph.i.openApiNodes[absolutePointer] as T?;

    if (existingNode != null) {
      OpenApiGraph.i.addOpenApiEdge(this, existingNode, via, form);
      return existingNode;
    }

    // Create new node
    final childNode = Node.ofType<T>(resolvedJson, resolvedDocument, resolvedJsonPointer);
    OpenApiGraph.i.addOpenApiNode(childNode);
    OpenApiGraph.i.addOpenApiEdge(this, childNode, via, form);
    childNode.create();
    return childNode;
  }

  /// Creates a list of nodes (handles $ref resolution and node reuse for referencable nodes).
  List<T>? createListNode<T extends OpenApiNode>({required String jsonKey, bool required = false}) {
    if (!_containsKey(jsonKey, required)) {
      return null;
    }

    final list = json[jsonKey] as List;
    final nodes = <T>[];

    for (var i = 0; i < list.length; i++) {
      final originalJson = list[i] as Map<String, dynamic>;
      final originalJsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, jsonKey, '[$i]']);

      // Check if it's a reference and resolve if needed
      final isRef = _isRef(originalJson);
      final (resolvedJson, resolvedDocument, resolvedJsonPointer) = isRef
          ? _resolveRef(json: originalJson, jsonPointer: originalJsonPointer)
          : (originalJson, $id.document, originalJsonPointer);

      final via = jsonKey;
      // Determine the 'form' argument: use referenced for refs, inline otherwise
      final form = isRef ? EdgeForm.referenced : EdgeForm.inline;

      // Check if node already exists at the resolved location
      final absolutePointer = '$resolvedDocument#$resolvedJsonPointer';
      final existingNode = OpenApiGraph.i.openApiNodes[absolutePointer] as T?;

      if (existingNode != null) {
        OpenApiGraph.i.addOpenApiEdge(this, existingNode, via, form);
        nodes.add(existingNode);
      } else {
        // Create new node
        final childNode = Node.ofType<T>(resolvedJson, resolvedDocument, resolvedJsonPointer);
        OpenApiGraph.i.addOpenApiNode(childNode);
        OpenApiGraph.i.addOpenApiEdge(this, childNode, via, form);
        childNode.create();
        nodes.add(childNode);
      }
    }

    return nodes;
  }

  Map<String, T>? createMapNode<T extends OpenApiNode>() {
    final nodes = <String, T>{};
    for (final entry in json.entries) {
      final key = entry.key.toString();
      final originalJson = entry.value as Map<String, dynamic>;
      final originalJsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, key]);

      // Check if it's a reference and resolve if needed
      final isRef = _isRef(originalJson);
      final (resolvedJson, resolvedDocument, resolvedJsonPointer) = isRef
          ? _resolveRef(json: originalJson, jsonPointer: originalJsonPointer)
          : (originalJson, $id.document, originalJsonPointer);

      final via = key;
      // Determine the 'form' argument: use referenced for refs, inline otherwise
      final form = isRef ? EdgeForm.referenced : EdgeForm.inline;

      // Check if node already exists at the resolved location
      final absolutePointer = '$resolvedDocument#$resolvedJsonPointer';
      final existingNode = OpenApiGraph.i.openApiNodes[absolutePointer] as T?;

      if (existingNode != null) {
        OpenApiGraph.i.addOpenApiEdge(this, existingNode, via, form);
        nodes[key] = existingNode;
      } else {
        // Create new node
        final childNode = Node.ofType<T>(resolvedJson, resolvedDocument, resolvedJsonPointer);
        OpenApiGraph.i.addOpenApiNode(childNode);
        OpenApiGraph.i.addOpenApiEdge(this, childNode, via, form);
        childNode.create();
        nodes[key] = childNode;
      }
    }

    return nodes;
  }
}
