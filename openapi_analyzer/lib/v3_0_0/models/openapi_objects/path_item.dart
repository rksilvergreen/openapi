import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import 'operation.dart';
import 'server.dart';
import 'parameter.dart';

class PathItemNode extends OpenApiNode with Referencable {
  PathItemNode._(super.$id, super.json);

  factory PathItemNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<PathItemNode>(
        json,
        document,
        jsonPointer,
        (nodeId, json) => PathItemNode._(nodeId, json),
      );

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

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    _structureValidated = true;
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
        ValidationUtils.requireMap(json[method], ValidationUtils.buildPath(jsonPointer, method));
      }
    }
  }

  void _validateSummary(String jsonPointer) {
    if (json.containsKey('summary')) {
      ValidationUtils.requireString(json['summary'], ValidationUtils.buildPath(jsonPointer, 'summary'));
    }
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(jsonPointer, 'description'));
    }
  }

  void _validateServers(String jsonPointer) {
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPath(jsonPointer, 'servers'));
    }
  }

  void _validateParameters(String jsonPointer) {
    if (json.containsKey('parameters')) {
      ValidationUtils.requireList(json['parameters'], ValidationUtils.buildPath(jsonPointer, 'parameters'));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'get', 'put', 'post', 'delete', 'options', 'head', 'patch', 'trace', 
       'summary', 'description', 'servers', 'parameters', '\$ref'},
      jsonPointer,
      'Path Item Object',
    );
  }

  void _createChildNodes() {
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
          NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, method)),
          operationJson
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
    if (json.containsKey('servers')) {
      final serversList = json['servers'] as List;
      serversNodes = [];
      for (var i = 0; i < serversList.length; i++) {
        final serverJson = serversList[i] as Map<String, dynamic>;
        final serverNode = ServerNode(
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'servers'), '[$i]')),
          serverJson,
        );
        serversNodes!.add(serverNode);
        OpenApiGraph.i.addOpenApiNode(serverNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, serverNode.$id.absolutePointer, 'servers'));
        serverNode.create();
      }
    }
  }

  void _createParametersNodes() {
    if (json.containsKey('parameters')) {
      final parametersList = json['parameters'] as List;
      parametersNodes = [];
      for (var i = 0; i < parametersList.length; i++) {
        final parameterJson = parametersList[i] as Map<String, dynamic>;
        final parameterNode = ParameterNode(
          parameterJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'parameters'), '[$i]'),
        );
        parametersNodes!.add(parameterNode);
        if (!OpenApiGraph.i.openApiNodes.containsKey(parameterNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(parameterNode);
          OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, parameterNode.$id.absolutePointer, 'parameters'));
          parameterNode.create();
        }
      }
    }
  }

  void _createContent() {
    content = PathItem._(
      $node: this,
      summary: json['summary'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
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
