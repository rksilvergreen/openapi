import '../openapi_graph.dart';
import 'external_documentation.dart';
import 'parameter.dart';
import 'request_body.dart';
import 'response.dart';
import 'callback.dart';
import 'security_requirement.dart';
import 'server.dart';
// import 'path_item.dart';
// import 'paths.dart';

class OperationNode extends OpenApiNode {
  OperationNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final ExternalDocumentationNode? externalDocsNode;
  late final List<ParameterNode>? parametersNodes;
  late final RequestBodyNode? requestBodyNode;
  late final Map<String, ResponseNode> responseNodes;
  late final Map<String, CallbackNode>? callbackNodes;
  late final List<SecurityRequirementNode>? securityRequirementNodes;
  late final List<ServerNode>? serverNodes;

  late final Operation content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Operation._(
      $node: this,
      tags: json['tags'],
      summary: json['summary'],
      description: json['description'],
      operationId: json['operationId'],
      extensions: extractExtensions(json),
    );
  }
}

/// Describes a single API operation on a path.
class Operation {
  final OperationNode $node;
  final List<String>? tags;
  final String? summary;
  final String? description;
  ExternalDocumentation? get externalDocs => $node.externalDocsNode?.content;
  final String? operationId;
  List<Parameter>? get parameters => $node.parametersNodes?.map((parameter) => parameter.content).toList();
  RequestBody? get requestBody => $node.requestBodyNode?.content;
  Map<String, Response> get responses => $node.responseNodes.map((k, v) => MapEntry(k, v.content));
  Map<String, Callback>? get callbacks => $node.callbackNodes?.map((k, v) => MapEntry(k, v.content));
  List<SecurityRequirement>? get security =>
      $node.securityRequirementNodes?.map((securityRequirement) => securityRequirement.content).toList();
  List<Server>? get servers => $node.serverNodes?.map((server) => server.content).toList();
  final Map<String, dynamic>? extensions;

  Operation._({required this.$node, this.tags, this.summary, this.description, this.operationId, this.extensions});

  String get $name {
    return '';
    // if (operationId != null) return operationId!;
    // final pathItem = OpenApiGraph.i.getOpenApiNodeParents($node).first as PathItemNode;
    // String verb = pathItem.getNode == $node
    //     ? 'get'
    //     : pathItem.putNode == $node
    //     ? 'put'
    //     : pathItem.postNode == $node
    //     ? 'post'
    //     : pathItem.deleteNode == $node
    //     ? 'delete'
    //     : pathItem.optionsNode == $node
    //     ? 'options'
    //     : pathItem.headNode == $node
    //     ? 'head'
    //     : pathItem.patchNode == $node
    //     ? 'patch'
    //     : pathItem.traceNode == $node
    //     ? 'trace'
    //     : '';
    // ;

    // final paths = OpenApiGraph.i.getOpenApiNodeParents(pathItem).first as PathsNode;
    // String path = paths.content.paths.entries.firstWhere((entry) => entry.value == pathItem).key;
    // return path.split('/').last;
  }
}
