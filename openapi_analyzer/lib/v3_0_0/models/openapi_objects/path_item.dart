import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import '../node_creation_helpers.dart';
import 'operation.dart';
import 'server.dart';
import 'parameter.dart';

abstract class PathItem {
  Operation? get get_;
  Operation? get put;
  Operation? get post;
  Operation? get delete;
  Operation? get options;
  Operation? get head;
  Operation? get patch;
  Operation? get trace;
  List<Server>? get servers;
  List<Parameter>? get parameters;
  Map<String, dynamic>? get extensions;
}

class PathItemNode extends OpenApiNode with InternalNode, Referencable implements PathItem {
  PathItemNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String? summary;
  late final String? description;
  late final OperationNode? get_;
  late final OperationNode? put;
  late final OperationNode? postNode;
  late final OperationNode? deleteNode;
  late final OperationNode? optionsNode;
  late final OperationNode? headNode;
  late final OperationNode? patchNode;
  late final OperationNode? traceNode;
  late final List<ServerNode>? serversNodes;
  late final List<ParameterNode>? parametersNodes;
  late final Map<String, dynamic>? extensions;

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
    createListNode<ServerNode>(
      jsonKey: 'servers',
      factory: (json, document, jsonPointer) => ServerNode(json, document, jsonPointer),
    );
  }

  void _createParametersNodes() {
    createListNode<ParameterNode>(
      jsonKey: 'parameters',
      factory: (json, document, jsonPointer) => ParameterNode(json, document, jsonPointer),
    );
  }

  @override
  void createContent() {
    summary = json['summary'];
    description = json['description'];
    getNode = $to<OperationNode>('get');
    putNode = $to<OperationNode>('put');
    postNode = $to<OperationNode>('post');
    deleteNode = $to<OperationNode>('delete');
    optionsNode = $to<OperationNode>('options');
    headNode = $to<OperationNode>('head');
    patchNode = $to<OperationNode>('patch');
    traceNode = $to<OperationNode>('trace');
    servers = $to<ServerNode>('servers');
    parameters = $to.where((edge) => edge.to is Parameter).map((edge) => edge.to as Parameter).toList();
    extensions = extractExtensions(json);
  }
}
