import 'openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import 'referencable.dart';

/// Extension providing helper methods for creating child nodes.
/// These methods handle the common patterns of node creation, edge addition, and node reuse.
extension NodeCreationHelpers on OpenApiNode {
  /// Creates a single node (handles $ref resolution and node reuse for referencable nodes).
  /// Returns the existing node if it was already created (for referencable nodes), otherwise creates and returns a new one.
  T? createNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function({required Map<String, dynamic> json, required String document, required String jsonPointer})
    factory,
    bool required = false,
  }) {
    if (!json.containsKey(jsonKey)) {
      if (required) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPath($id.jsonPointer, jsonKey),
            'Required field "$jsonKey" is missing',
            specReference: 'OpenAPI 3.0.0 Specification',
            severity: ValidationSeverity.critical,
          ),
        );
      }
      return null;
    }

    var childJson = json[jsonKey] as Map<String, dynamic>;
    late final T childNode;

    if (T is Referencable && childJson.containsKey('\$ref')) {
      final ref = ValidationUtils.requireString(
        childJson['\$ref'],
        ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, jsonKey), '\$ref'),
      );
      ValidationUtils.validateNoUnknownFields(
        childJson,
        {'\$ref'},
        ValidationUtils.buildPath($id.jsonPointer, jsonKey),
        'Reference Object',
      );
      final (referencedJson, referencedDocument, referencedJsonPointer) = OpenApiGraph.i.referenceResolver
          .resolveReference(ref, ValidationUtils.buildPath($id.jsonPointer, jsonKey));
      childNode = factory(json: referencedJson, document: referencedDocument, jsonPointer: referencedJsonPointer);
      // Check if node is referencable and already exists
      if (OpenApiGraph.i.openApiNodes.containsKey(childNode.$id.absolutePointer)) {
        return OpenApiGraph.i.openApiNodes[childNode.$id.absolutePointer] as T;
      }
    } else {
      childNode = factory(
        json: childJson,
        document: $id.document,
        jsonPointer: ValidationUtils.buildPath($id.jsonPointer, jsonKey),
      );
    }

    OpenApiGraph.i.addOpenApiNode(childNode);
    OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, jsonKey));
    childNode.create();
    return childNode;
  }

  /// Creates a list of nodes (handles $ref resolution and node reuse for referencable nodes).
  List<T>? createListNode<T extends OpenApiNode>({
    required String jsonKey,
    required T Function({required Map<String, dynamic> json, required String document, required String jsonPointer})
    factory,
    bool required = false,
  }) {
    if (!json.containsKey(jsonKey)) {
      if (required) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPath($id.jsonPointer, jsonKey),
            'Required field "$jsonKey" is missing',
            specReference: 'OpenAPI 3.0.0 Specification',
            severity: ValidationSeverity.critical,
          ),
        );
      }
      return null;
    }

    final list = json[jsonKey] as List;
    final nodes = <T>[];

    for (var i = 0; i < list.length; i++) {
      final childJson = list[i] as Map<String, dynamic>;
      final childNode =
          factory(
                json: childJson,
                document: $id.document,
                jsonPointer: ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, jsonKey), '[$i]'),
              )
              as OpenApiNode;

      nodes.add(childNode as T);

      // Check if node is referencable and already exists
      if (childNode is Referencable) {
        if (OpenApiGraph.i.openApiNodes.containsKey(childNode.$id.absolutePointer)) {
          continue;
        }
      }

      OpenApiGraph.i.addOpenApiNode(childNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, jsonKey));
      childNode.create();
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
    if (!json.containsKey(jsonKey)) {
      if (required) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPath($id.jsonPointer, jsonKey),
            'Required field "$jsonKey" is missing',
            specReference: 'OpenAPI 3.0.0 Specification',
            severity: ValidationSeverity.critical,
          ),
        );
      }
      return null;
    }

    final map = json[jsonKey] as Map<String, dynamic>;
    final nodes = <String, T>{};

    for (final entry in map.entries) {
      final key = entry.key.toString();
      final childJson = entry.value as Map<String, dynamic>;
      final childNode =
          factory(
                json: childJson,
                document: $id.document,
                jsonPointer: ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, jsonKey), key),
              )
              as OpenApiNode;

      nodes[key] = childNode as T;

      // Check if node is referencable and already exists
      if (childNode is Referencable) {
        if (OpenApiGraph.i.openApiNodes.containsKey(childNode.$id.absolutePointer)) {
          continue;
        }
      }

      OpenApiGraph.i.addOpenApiNode(childNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, childNode.$id.absolutePointer, '$jsonKey/$key'));
      childNode.create();
    }

    return nodes;
  }
}
