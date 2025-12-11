

import '../openapi_graph.dart';
import 'external_documentation.dart';
import 'parameter.dart';
import 'request_body.dart';
import 'response.dart';
import 'callback.dart';
import 'security_requirement.dart';
import 'server.dart';

class OperationNode extends OpenApiNode {
  OperationNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentValidated = false;

  bool get structureValidated => _structureValidated;
  bool get contentValidated => _contentValidated;

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
      $id: $id,
      tags: json['tags'],
      summary: json['summary'],
      description: json['description'],
      operationId: json['operationId'],
      extensions: extractExtensions(json),
    );
  }
}
/// Describes a single API operation on a path.
class Operation  {
  final OperationNode _$node;
  final List<String>? tags;
  final String? summary;
  final String? description;
  ExternalDocumentation? get externalDocs => _$node.externalDocsNode.content;
  final String? operationId;
  List<Parameter>? get parameters => _$node.parametersNodes?.map((parameter) => parameter.content).toList();
  RequestBody? get requestBody => _$node.requestBodyNode?.content;
  Map<String, Response> get responses => _$node.responseNodes.map((k,v) => MapEntry(k, v.content));
  Map<String, Callback>? get callbacks => _$node.callbackNodes?.map((k,v) => MapEntry(k, v.content));
  List<SecurityRequirement>? get security => _$node.securityRequirementNodes?.map((securityRequirement) => securityRequirement.content).toList();
  List<Server>? get servers => _$node.serverNodes?.map((server) => server.content).toList();
  final Map<String, dynamic>? extensions;

  Operation._({required NodeId $id, this.tags, this.summary, this.description, this.operationId, this.extensions})
    : _$node = OpenApiRegistry.i.getOpenApiNode<OperationNode>($id);
  }
