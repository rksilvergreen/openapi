import '../openapi_graph.dart';
import 'operation.dart';
import 'server.dart';
import 'parameter.dart';

class PathItemNode extends OpenApiNode {
  PathItemNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final OperationNode? getNode;
  late final OperationNode? putNode;
  late final OperationNode? postNode;
  late final OperationNode? deleteNode;
  late final OperationNode? optionsNode;
  late final OperationNode? headNode;
  late final OperationNode? patchNode;
  late final OperationNode? traceNode;
  late final List<ServerNode>? serversNodes;
  late final List<ParameterNode>? parametersNodes;

  late final PathItem content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = PathItem._(
      $node: this,
      summary: json['summary'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
  }
}

/// Describes the operations available on a single path.
class PathItem {
  final PathItemNode $node;
  final String? summary;
  final String? description;
  Operation? get get_ => $node.getNode?.content;
  Operation? get put => $node.putNode?.content;
  Operation? get post => $node.postNode?.content;
  Operation? get delete => $node.deleteNode?.content;
  Operation? get options => $node.optionsNode?.content;
  Operation? get head => $node.headNode?.content;
  Operation? get patch => $node.patchNode?.content;
  Operation? get trace => $node.traceNode?.content;
  List<Server>? get servers => $node.serversNodes?.map((server) => server.content).toList();
  List<Parameter>? get parameters => $node.parametersNodes?.map((parameter) => parameter.content).toList();
  final Map<String, dynamic>? extensions;

  PathItem._({required this.$node, this.summary, this.description, this.extensions});
}
