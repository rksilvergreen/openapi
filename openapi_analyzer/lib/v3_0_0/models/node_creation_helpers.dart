import 'openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../../validation_exception.dart';

typedef NodeFactory<T> = T Function(Map<String, dynamic> json, String document, String jsonPointer);

/// Extension providing helper methods for creating child nodes.
/// These methods handle the common patterns of node creation, edge addition, and node reuse.
extension NodeCreationHelpers on Node {
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

  /// Gets an existing node or creates a new one, handling edge creation.
  /// Returns the existing node if found, otherwise creates and returns a new node.
  T _getOrCreateNode<T extends Node>({
    required Map<String, dynamic> json,
    required String document,
    required String jsonPointer,
    required bool isRef,
    required String via,
  }) {
    // Determine the 'form' argument: use referenced for refs, inline otherwise
    final form = isRef ? EdgeForm.referenced : EdgeForm.inline;

    // Check if node already exists at the resolved location
    final absolutePointer = '$document#$jsonPointer';
    final existingNode = OpenApiGraph.i.nodes[absolutePointer] as T?;

    if (existingNode != null) {
      OpenApiGraph.i.addEdge(this, existingNode, via, form);
      return existingNode;
    }

    // Create new node
    final childNode = Node.ofType<T>(json, document, jsonPointer);
    OpenApiGraph.i.addNode(childNode);
    OpenApiGraph.i.addEdge(this, childNode, via, form);
    childNode.create();
    return childNode;
  }

  /// Creates a single node (handles $ref resolution and node reuse for referencable nodes).
  /// Returns the existing node if it was already created (for referencable nodes), otherwise creates and returns a new one.
  T? createNode<T extends Node>({required String jsonKey, bool required = false}) {
    if (!_containsKey(jsonKey, required)) {
      return null;
    }

    final originalJson = json[jsonKey] as Map<String, dynamic>;
    final originalDocument = $id.document;
    final originalJsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, jsonKey]);

    final isRef = _isRef(originalJson);
    final (resolvedJson, resolvedDocument, resolvedJsonPointer) = isRef
        ? _resolveRef(json: originalJson, jsonPointer: originalJsonPointer)
        : (originalJson, originalDocument, originalJsonPointer);

    return _getOrCreateNode<T>(
      json: resolvedJson,
      document: resolvedDocument,
      jsonPointer: resolvedJsonPointer,
      isRef: isRef,
      via: jsonKey,
    );
  }

  /// Creates a list of nodes (handles $ref resolution and node reuse for referencable nodes).
  List<T>? createListNode<T extends Node>() {
    final list = json as List;
    final nodes = <T>[];
    for (var i = 0; i < list.length; i++) {
      final originalJson = list[i] as Map<String, dynamic>;
      final originalDocument = $id.document;
      final originalJsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, '$i']);

      final isRef = _isRef(originalJson);
      final (resolvedJson, resolvedDocument, resolvedJsonPointer) = isRef
          ? _resolveRef(json: originalJson, jsonPointer: originalJsonPointer)
          : (originalJson, originalDocument, originalJsonPointer);

      final registeredNode = _getOrCreateNode<T>(
        json: resolvedJson,
        document: resolvedDocument,
        jsonPointer: resolvedJsonPointer,
        isRef: isRef,
        via: '$i',
      );
      nodes.add(registeredNode);
    }

    return nodes;
  }

  Map<String, T>? createMapNode<T extends Node>() {
    final nodes = <String, T>{};
    for (final entry in json.entries) {
      final key = entry.key.toString();
      final originalJson = entry.value as Map<String, dynamic>;
      final originalDocument = $id.document;
      final originalJsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, key]);

      final isRef = _isRef(originalJson);
      final (resolvedJson, resolvedDocument, resolvedJsonPointer) = isRef
          ? _resolveRef(json: originalJson, jsonPointer: originalJsonPointer)
          : (originalJson, originalDocument, originalJsonPointer);

      final registeredNode = _getOrCreateNode<T>(
        json: resolvedJson,
        document: resolvedDocument,
        jsonPointer: resolvedJsonPointer,
        isRef: isRef,
        via: key,
      );
      nodes[key] = registeredNode;
    }

    return nodes;
  }
}
