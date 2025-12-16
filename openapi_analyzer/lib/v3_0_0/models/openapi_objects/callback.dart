import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'path_item.dart';

class CallbackNode extends OpenApiNode {
  CallbackNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, PathItemNode> expressionsNodes;

  late final Callback content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    final path = $id.jsonPointer;

    // Callback is a map of runtime expressions to PathItem objects
    // All fields should be runtime expressions or extension fields
    for (final key in json.keys) {
      final keyStr = key.toString();
      if (!keyStr.startsWith('x-')) {
        // Runtime expression validation (should be a valid expression or path)
        // For now, just ensure the value is a map
        ValidationUtils.requireMap(json[key], ValidationUtils.buildPath(path, keyStr));
      }
    }

    _structureValidated = true;
  }

  void _createChildNodes() {
    expressionsNodes = {};

    for (final entry in json.entries) {
      final expression = entry.key.toString();
      if (expression.startsWith('x-')) continue; // Skip extensions

      final pathItemJson = entry.value as Map<String, dynamic>;
      final pathItemNode = PathItemNode(
        NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, expression)),
        pathItemJson,
      );
      expressionsNodes[expression] = pathItemNode;
      OpenApiGraph.i.addOpenApiNode(pathItemNode);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, pathItemNode.$id.absolutePointer, expression));
      pathItemNode.create();
    }
  }

  void _createContent() {
    content = Callback._($node: this, extensions: extractExtensions(json));
    _contentCreated = true;
  }
}

/// A map of possible out-of band callbacks related to the parent operation.
class Callback {
  final CallbackNode $node;
  Map<String, PathItem> get expressions => $node.expressionsNodes.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Callback._({required this.$node, this.extensions});
}
