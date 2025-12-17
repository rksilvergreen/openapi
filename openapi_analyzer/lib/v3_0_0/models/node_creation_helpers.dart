import 'openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import 'referencable.dart';

/// Extension providing helper methods for creating child nodes.
/// These methods handle the common patterns of node creation, edge addition, and node reuse.
extension NodeCreationHelpers on OpenApiNode {
  /// Helper method to create a child node, handling $ref resolution and node reuse.
  /// Returns: (childNode, existingNode) where existingNode is non-null if the node already exists.
  T _createResolvedNode<T extends OpenApiNode>({
    required Map<String, dynamic> json,
    required String document,
    required String jsonPointer,
    required T Function({required Map<String, dynamic> json, required String document, required String jsonPointer})
    factory,
  }) {
    late final T childNode;

    if (T is Referencable && json.containsKey('\$ref')) {
      final ref = ValidationUtils.requireString(
        json['\$ref'],
        ValidationUtils.buildPointer([jsonPointer, '\$ref']),
      );
      ValidationUtils.validateNoUnknownFields(json, {'\$ref'}, jsonPointer, 'Reference Object');
      final (referencedJson, referencedDocument, referencedJsonPointer) = OpenApiGraph.i.referenceResolver
          .resolveReference(ref, jsonPointer);
      childNode = factory(json: referencedJson, document: referencedDocument, jsonPointer: referencedJsonPointer);
    } else {
      childNode = factory(json: json, document: document, jsonPointer: jsonPointer);
    }

    return childNode;
  }

  /// Registers a node in the graph, checking for existing nodes and creating edges.
  /// Returns the existing node if it was already registered, otherwise registers and returns the new node.
  T _registerNode<T extends OpenApiNode>({required T childNode, required String jsonKey}) {
    // Check if node is referencable and already exists
    if (OpenApiGraph.i.openApiNodes.containsKey(childNode.$id.absolutePointer)) {
      return OpenApiGraph.i.openApiNodes[childNode.$id.absolutePointer] as T;
    }
    OpenApiGraph.i.addOpenApiNode(childNode);
    OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, jsonKey));
    childNode.create();
    return childNode;
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
  T? createNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function({required Map<String, dynamic> json, required String document, required String jsonPointer})
    factory,
    bool required = false,
  }) {
    if (!_containsKey(jsonKey, required)) {
      return null;
    }

    final childNode = _createResolvedNode<T>(
      json: json[jsonKey] as Map<String, dynamic>,
      document: $id.document,
      jsonPointer: ValidationUtils.buildPointer([$id.jsonPointer, jsonKey]),
      factory: factory,
    );

    return _registerNode<T>(childNode: childNode, jsonKey: jsonKey);
  }

  /// Creates a list of nodes (handles $ref resolution and node reuse for referencable nodes).
  List<T>? createListNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function({required Map<String, dynamic> json, required String document, required String jsonPointer})
    factory,
    bool required = false,
  }) {
    if (!_containsKey(jsonKey, required)) {
      return null;
    }

    final list = json[jsonKey] as List;
    final nodes = <T>[];

    for (var i = 0; i < list.length; i++) {
      final childNode = _createResolvedNode<T>(
        json: list[i] as Map<String, dynamic>,
        document: $id.document,
        jsonPointer: ValidationUtils.buildPointer([$id.jsonPointer, jsonKey, '[$i]']),
        factory: factory,
      );

      final registeredNode = _registerNode<T>(childNode: childNode, jsonKey: jsonKey);
      nodes.add(registeredNode);
    }

    return nodes;
  }

  /// Creates a map of nodes (handles $ref resolution and node reuse for referencable nodes).
  Map<String, T>? createMapNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function({required Map<String, dynamic> json, required String document, required String jsonPointer})
    factory,
    bool required = false,
  }) {
    if (!_containsKey(jsonKey, required)) {
      return null;
    }

    final map = json[jsonKey] as Map<String, dynamic>;
    final nodes = <String, T>{};

    for (final entry in map.entries) {
      final key = entry.key.toString();
      final childNode = _createResolvedNode<T>(
        json: entry.value as Map<String, dynamic>,
        document: $id.document,
        jsonPointer: ValidationUtils.buildPointer([$id.jsonPointer, jsonKey, key]),
        factory: factory,
      );

      final registeredNode = _registerNode<T>(childNode: childNode, jsonKey: '$jsonKey/$key');
      nodes[key] = registeredNode;
    }

    return nodes;
  }
}
