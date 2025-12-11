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
  bool _contentValidated = false;

  bool get structureValidated => _structureValidated;
  bool get contentValidated => _contentValidated;

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
      $id: $id,
      summary: json['summary'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
  }
}

/// Describes the operations available on a single path.
class PathItem {
  final PathItemNode _$node;
  final String? summary;
  final String? description;
  Operation? get get_ => _$node.getNode?.content;
  Operation? get put => _$node.putNode?.content;
  Operation? get post => _$node.postNode?.content;
  Operation? get delete => _$node.deleteNode?.content;
  Operation? get options => _$node.optionsNode?.content;
  Operation? get head => _$node.headNode?.content;
  Operation? get patch => _$node.patchNode?.content;
  Operation? get trace => _$node.traceNode?.content;
  List<Server>? get servers => _$node.serversNodes?.map((server) => server.content).toList();
  List<Parameter>? get parameters => _$node.parametersNodes?.map((parameter) => parameter.content).toList();
  final Map<String, dynamic>? extensions;

  PathItem._({required NodeId $id, this.summary, this.description, this.extensions})
    : _$node = OpenApiRegistry.i.getOpenApiNode<PathItemNode>($id);
}
