import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import '../node_creation_helpers.dart';
import 'operation.dart';
import 'server.dart';
import 'parameter.dart';

class PathItemNode extends OpenApiNode with InternalNode, Referencable {
  PathItemNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

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

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateHttpMethods(jsonPointer);
    _validateSummary(jsonPointer);
    _validateDescription(jsonPointer);
    _validateServers(jsonPointer);
    _validateParameters(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateHttpMethods(String jsonPointer) {
    final httpMethods = ['get', 'put', 'post', 'delete', 'options', 'head', 'patch', 'trace'];
    for (final method in httpMethods) {
      if (json.containsKey(method)) {
        ValidationUtils.requireMap(json[method], ValidationUtils.buildPointer([jsonPointer, method]));
      }
    }
  }

  void _validateSummary(String jsonPointer) {
    if (json.containsKey('summary')) {
      ValidationUtils.requireString(json['summary'], ValidationUtils.buildPointer([jsonPointer, 'summary']));
    }
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateServers(String jsonPointer) {
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPointer([jsonPointer, 'servers']));
    }
  }

  void _validateParameters(String jsonPointer) {
    if (json.containsKey('parameters')) {
      ValidationUtils.requireList(json['parameters'], ValidationUtils.buildPointer([jsonPointer, 'parameters']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {
        'get',
        'put',
        'post',
        'delete',
        'options',
        'head',
        'patch',
        'trace',
        'summary',
        'description',
        'servers',
        'parameters',
        '\$ref',
      },
      jsonPointer,
      'Path Item Object',
    );
  }

  @override
  void createChildNodes() {
    _createOperationNodes();
    _createServersNodes();
    _createParametersNodes();
  }

  void _createOperationNodes() {
    final httpMethods = ['get', 'put', 'post', 'delete', 'options', 'head', 'patch', 'trace'];

    for (final method in httpMethods) {
      if (json.containsKey(method)) {
        final operationJson = json[method] as Map<String, dynamic>;
        final operationNode = OperationNode(
          operationJson,
          $id.document,
          ValidationUtils.buildPointer([$id.jsonPointer, method]),
        );

        switch (method) {
          case 'get':
            getNode = operationNode;
            break;
          case 'put':
            putNode = operationNode;
            break;
          case 'post':
            postNode = operationNode;
            break;
          case 'delete':
            deleteNode = operationNode;
            break;
          case 'options':
            optionsNode = operationNode;
            break;
          case 'head':
            headNode = operationNode;
            break;
          case 'patch':
            patchNode = operationNode;
            break;
          case 'trace':
            traceNode = operationNode;
            break;
        }

        OpenApiGraph.i.addOpenApiNode(operationNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, operationNode.$id.absolutePointer, method));
        operationNode.create();
      }
    }
  }

  void _createServersNodes() {
    serversNodes = createListNode<ServerNode>(
      jsonKey: 'servers',
      factory: (json, document, jsonPointer) => ServerNode(json, document, jsonPointer),
    );
  }

  void _createParametersNodes() {
    parametersNodes = createListNode<ParameterNode>(
      jsonKey: 'parameters',
      factory: (json, document, jsonPointer) => ParameterNode(json, document, jsonPointer),
    );
  }

  @override
  void createContent() {
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
