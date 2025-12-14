import '../openapi_graph.dart';
import 'path_item.dart';

class PathsNode extends OpenApiNode {
  PathsNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, PathItemNode> pathItemNodes;

  late final Paths content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Paths._($node: this, extensions: extractExtensions(json));
  }
}

class Paths {
  final PathsNode $node;

  Map<String, PathItem> get paths => $node.pathItemNodes.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;
  Paths._({required this.$node, this.extensions});
}
