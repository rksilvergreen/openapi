import '../openapi_graph.dart';
import 'path_item.dart';

class CallbackNode extends OpenApiNode {
  CallbackNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, PathItemNode> expressionsNodes;

  late final Callback content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Callback._($id: $id, extensions: extractExtensions(json));
  }
}

/// A map of possible out-of band callbacks related to the parent operation.
class Callback {
  final CallbackNode _$node;
  Map<String, PathItem> get expressions => _$node.expressionsNodes.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Callback._({required NodeId $id, this.extensions}) : _$node = OpenApiGraph.i.getOpenApiNode<CallbackNode>($id);
}
