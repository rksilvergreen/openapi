import 'openapi_graph.dart';
import '../validation/validation_utils.dart';

/// Extension providing helper methods for creating child nodes.
/// These methods handle the common patterns of node creation, edge addition, and node reuse.
extension NodeCreationHelpers on OpenApiNode {
  /// Creates a single referencable node (handles $ref resolution and node reuse).
  /// Returns the existing node if it was already created, otherwise creates and returns a new one.
  T? createReferencableNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function(Map<String, dynamic> json, String document, String jsonPointer) factory,
  }) {
    if (!json.containsKey(jsonKey)) return null;

    final childJson = json[jsonKey] as Map<String, dynamic>;
    final childNode =
        factory(childJson, $id.document, ValidationUtils.buildPath($id.jsonPointer, jsonKey)) as OpenApiNode;

    if (OpenApiGraph.i.openApiNodes.containsKey(childNode.$id.absolutePointer)) {
      return OpenApiGraph.i.openApiNodes[childNode.$id.absolutePointer] as T;
    }

    OpenApiGraph.i.addOpenApiNode(childNode);
    OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, jsonKey));
    childNode.create();
    return childNode as T;
  }

  /// Creates a single non-referencable node (always creates a new instance).
  T? createNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function(NodeId id, Map<String, dynamic> json) factory,
    bool required = false,
  }) {
    if (required) {
      final childJson = json[jsonKey] as Map<String, dynamic>;
      final childNode =
          factory(NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, jsonKey)), childJson) as OpenApiNode;

      OpenApiGraph.i.addOpenApiNode(childNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, jsonKey));
      childNode.create();
      return childNode as T;
    }

    if (!json.containsKey(jsonKey)) return null;

    final childJson = json[jsonKey] as Map<String, dynamic>;
    final childNode =
        factory(NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, jsonKey)), childJson) as OpenApiNode;

    OpenApiGraph.i.addOpenApiNode(childNode);
    OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, jsonKey));
    childNode.create();
    return childNode as T;
  }

  /// Creates a list of referencable nodes (handles $ref resolution and node reuse).
  List<T> createReferencableListNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function(Map<String, dynamic> json, String document, String jsonPointer) factory,
  }) {
    if (!json.containsKey(jsonKey)) return [];

    final list = json[jsonKey] as List;
    final nodes = <T>[];

    for (var i = 0; i < list.length; i++) {
      final childJson = list[i] as Map<String, dynamic>;
      final childNode =
          factory(
                childJson,
                $id.document,
                ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, jsonKey), '[$i]'),
              )
              as OpenApiNode;

      nodes.add(childNode as T);

      if (OpenApiGraph.i.openApiNodes.containsKey(childNode.$id.absolutePointer)) {
        continue;
      }

      OpenApiGraph.i.addOpenApiNode(childNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, jsonKey));
      childNode.create();
    }

    return nodes;
  }

  /// Creates a list of non-referencable nodes (always creates new instances).
  List<T> createListNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function(NodeId id, Map<String, dynamic> json) factory,
  }) {
    if (!json.containsKey(jsonKey)) return [];

    final list = json[jsonKey] as List;
    final nodes = <T>[];

    for (var i = 0; i < list.length; i++) {
      final childJson = list[i] as Map<String, dynamic>;
      final childNode =
          factory(
                NodeId(
                  $id.document,
                  ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, jsonKey), '[$i]'),
                ),
                childJson,
              )
              as OpenApiNode;

      nodes.add(childNode as T);
      OpenApiGraph.i.addOpenApiNode(childNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, jsonKey));
      childNode.create();
    }

    return nodes;
  }

  /// Creates a map of referencable nodes (handles $ref resolution and node reuse).
  Map<String, T> createReferencableMapNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function(Map<String, dynamic> json, String document, String jsonPointer) factory,
    bool required = false,
  }) {
    if (required) {
      final map = json[jsonKey] as Map<String, dynamic>;
      return processReferencableMapEntries<T>(map, jsonKey, factory);
    }

    if (!json.containsKey(jsonKey)) return {};

    final map = json[jsonKey] as Map<String, dynamic>;
    return processReferencableMapEntries<T>(map, jsonKey, factory);
  }

  /// Creates a map of non-referencable nodes (always creates new instances).
  Map<String, T> createMapNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function(NodeId id, Map<String, dynamic> json) factory,
    bool required = false,
  }) {
    if (required) {
      final map = json[jsonKey] as Map<String, dynamic>;
      return processMapEntries<T>(map, jsonKey, factory);
    }

    if (!json.containsKey(jsonKey)) return {};

    final map = json[jsonKey] as Map<String, dynamic>;
    return processMapEntries<T>(map, jsonKey, factory);
  }

  // Helper methods for processing map entries
  Map<String, T> processReferencableMapEntries<T extends OpenApiNode>(
    Map<String, dynamic> map,
    String jsonKey,
    T Function(Map<String, dynamic> json, String document, String jsonPointer) factory,
  ) {
    final nodes = <String, T>{};

    for (final entry in map.entries) {
      final key = entry.key.toString();
      final childJson = entry.value as Map<String, dynamic>;
      final childNode =
          factory(
                childJson,
                $id.document,
                ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, jsonKey), key),
              )
              as OpenApiNode;

      nodes[key] = childNode as T;

      if (OpenApiGraph.i.openApiNodes.containsKey(childNode.$id.absolutePointer)) {
        continue;
      }

      OpenApiGraph.i.addOpenApiNode(childNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, '$jsonKey/$key'));
      childNode.create();
    }

    return nodes;
  }

  Map<String, T> processMapEntries<T extends OpenApiNode>(
    Map<String, dynamic> map,
    String jsonKey,
    T Function(NodeId id, Map<String, dynamic> json) factory,
  ) {
    final nodes = <String, T>{};

    for (final entry in map.entries) {
      final key = entry.key.toString();
      final childJson = entry.value as Map<String, dynamic>;
      final childNode =
          factory(
                NodeId(
                  $id.document,
                  ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, jsonKey), key),
                ),
                childJson,
              )
              as OpenApiNode;

      nodes[key] = childNode as T;
      OpenApiGraph.i.addOpenApiNode(childNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, '$jsonKey/$key'));
      childNode.create();
    }

    return nodes;
  }
}
