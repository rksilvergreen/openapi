import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
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

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.relativePath;

    // Validate optional HTTP method fields (objects)
    final httpMethods = ['get', 'put', 'post', 'delete', 'options', 'head', 'patch', 'trace'];
    for (final method in httpMethods) {
      if (json.containsKey(method)) {
        ValidationUtils.requireMap(json[method], ValidationUtils.buildPath(path, method));
      }
    }

    // Validate optional: summary (string)
    if (json.containsKey('summary')) {
      ValidationUtils.requireString(json['summary'], ValidationUtils.buildPath(path, 'summary'));
    }

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate optional: servers (array)
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPath(path, 'servers'));
    }

    // Validate optional: parameters (array)
    if (json.containsKey('parameters')) {
      ValidationUtils.requireList(json['parameters'], ValidationUtils.buildPath(path, 'parameters'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'get', 'put', 'post', 'delete', 'options', 'head', 'patch', 'trace', 
       'summary', 'description', 'servers', 'parameters', '\$ref'},
      path,
      'Path Item Object',
    );
  }
  void _createChildNodes() {
    // Create Operation nodes for each HTTP method
    final httpMethods = ['get', 'put', 'post', 'delete', 'options', 'head', 'patch', 'trace'];
    
    for (final method in httpMethods) {
      if (json.containsKey(method)) {
        final operationJson = json[method] as Map<String, dynamic>;
        final operationNode = OperationNode(
          NodeId($id.document, ValidationUtils.buildPath($id.relativePath, method)),
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
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, operationNode.$id.absolutePath, method));
      }
    }

    // Create Servers nodes
    if (json.containsKey('servers')) {
      final serversList = json['servers'] as List;
      serversNodes = [];
      for (var i = 0; i < serversList.length; i++) {
        final serverJson = serversList[i] as Map<String, dynamic>;
        final serverNode = ServerNode(
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'servers'), '[$i]')),
          serverJson
        );
        serversNodes!.add(serverNode);
        OpenApiGraph.i.addOpenApiNode(serverNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, serverNode.$id.absolutePath, 'servers'));
      }
    }

    // Create Parameters nodes
    if (json.containsKey('parameters')) {
      final parametersList = json['parameters'] as List;
      parametersNodes = [];
      for (var i = 0; i < parametersList.length; i++) {
        final parameterJson = parametersList[i] as Map<String, dynamic>;
        final parameterNode = ParameterNode(
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'parameters'), '[$i]')),
          parameterJson
        );
        parametersNodes!.add(parameterNode);
        OpenApiGraph.i.addOpenApiNode(parameterNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, parameterNode.$id.absolutePath, 'parameters'));
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
