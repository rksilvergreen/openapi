import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import 'path_item.dart';

class CallbackNode extends OpenApiNode with InternalNode, Referencable {
  CallbackNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final Map<String, PathItemNode> expressionsNodes;

  late final Callback content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    for (final key in json.keys) {
      final keyStr = key.toString();
      ValidationUtils.requireMap(json[key], ValidationUtils.buildPointer([jsonPointer, keyStr]));
    }
  }

  @override
  void createChildNodes() {
    expressionsNodes = {};

    for (final entry in json.entries) {
      final expression = entry.key.toString();

      final pathItemJson = entry.value as Map<String, dynamic>;
      final pathItemNode = PathItemNode(
        pathItemJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, expression]),
      );
      expressionsNodes[expression] = pathItemNode;
      if (!OpenApiGraph.i.openApiNodes.containsKey(pathItemNode.$id.absolutePointer)) {
        OpenApiGraph.i.addOpenApiNode(pathItemNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, pathItemNode.$id.absolutePointer, expression));
        pathItemNode.create();
      }
    }
  }

  @override
  void createContent() {
    content = Callback._($node: this, extensions: extractExtensions(json));
  }
}

/// A map of possible out-of band callbacks related to the parent operation.
class Callback {
  final CallbackNode $node;
  Map<String, PathItem> get expressions => $node.expressionsNodes.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Callback._({required this.$node, this.extensions});
}
