import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'external_documentation.dart';
import 'parameter.dart';
import 'request_body.dart';
import 'response.dart';
import 'callback.dart';
import 'security_requirement.dart';
import 'server.dart';
import 'responses_map.dart';
import 'callbacks_map.dart';

abstract class Operation {
  ExternalDocumentation? get externalDocs;
  List<Parameter>? get parameters;
  RequestBody? get requestBody;
  ResponsesMap get responses;
  CallbacksMap get callbacks;
  List<SecurityRequirement>? get security;
  List<Server>? get servers;
}

class OperationNode extends OpenApiNode with InternalNode implements Operation {
  OperationNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final ExternalDocumentationNode? externalDocs;
  late final List<ParameterNode>? parameters;
  late final RequestBodyNode? requestBody;
  late final ResponsesMapNode responses;
  late final CallbacksMapNode callbacks;
  late final List<SecurityRequirementNode>? security;
  late final List<ServerNode>? servers;

  late final Operation content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateResponses(jsonPointer);
    _validateTags(jsonPointer);
    _validateSummary(jsonPointer);
    _validateDescription(jsonPointer);
    _validateExternalDocs(jsonPointer);
    _validateOperationId(jsonPointer);
    _validateParameters(jsonPointer);
    _validateRequestBody(jsonPointer);
    _validateCallbacks(jsonPointer);
    _validateDeprecated(jsonPointer);
    _validateSecurity(jsonPointer);
    _validateServers(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateResponses(String jsonPointer) {
    final responses = ValidationUtils.requireField(json, 'responses', jsonPointer);
    ValidationUtils.requireMap(responses, ValidationUtils.buildPointer([jsonPointer, 'responses']));
  }

  void _validateTags(String jsonPointer) {
    if (json.containsKey('tags')) {
      final tags = ValidationUtils.requireList(json['tags'], ValidationUtils.buildPointer([jsonPointer, 'tags']));
      for (var i = 0; i < tags.length; i++) {
        ValidationUtils.requireString(tags[i], ValidationUtils.buildPointer([jsonPointer, 'tags', '[$i]']));
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

  void _validateExternalDocs(String jsonPointer) {
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPointer([jsonPointer, 'externalDocs']));
    }
  }

  void _validateOperationId(String jsonPointer) {
    if (json.containsKey('operationId')) {
      ValidationUtils.requireString(json['operationId'], ValidationUtils.buildPointer([jsonPointer, 'operationId']));
      // Note: uniqueness validation across all operations will be done in semantic validation
    }
  }

  void _validateParameters(String jsonPointer) {
    if (json.containsKey('parameters')) {
      ValidationUtils.requireList(json['parameters'], ValidationUtils.buildPointer([jsonPointer, 'parameters']));
    }
  }

  void _validateRequestBody(String jsonPointer) {
    if (json.containsKey('requestBody')) {
      ValidationUtils.requireMap(json['requestBody'], ValidationUtils.buildPointer([jsonPointer, 'requestBody']));
    }
  }

  void _validateCallbacks(String jsonPointer) {
    if (json.containsKey('callbacks')) {
      ValidationUtils.requireMap(json['callbacks'], ValidationUtils.buildPointer([jsonPointer, 'callbacks']));
    }
  }

  void _validateDeprecated(String jsonPointer) {
    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPointer([jsonPointer, 'deprecated']));
    }
  }

  void _validateSecurity(String jsonPointer) {
    if (json.containsKey('security')) {
      ValidationUtils.requireList(json['security'], ValidationUtils.buildPointer([jsonPointer, 'security']));
    }
  }

  void _validateServers(String jsonPointer) {
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPointer([jsonPointer, 'servers']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {
        'tags',
        'summary',
        'description',
        'externalDocs',
        'operationId',
        'parameters',
        'requestBody',
        'responses',
        'callbacks',
        'deprecated',
        'security',
        'servers',
      },
      jsonPointer,
      'Operation Object',
    );
  }

  @override
  void createChildNodes() {
    _createExternalDocsNode();
    _createParametersNodes();
    _createRequestBodyNode();
    _createResponseNodes();
    _createCallbackNodes();
    _createSecurityRequirementNodes();
    _createServerNodes();
  }

  void _createExternalDocsNode() {
    externalDocsNode = createNode<ExternalDocumentationNode>(
      jsonKey: 'externalDocs',
      factory: (json, document, jsonPointer) => ExternalDocumentationNode(json, document, jsonPointer),
    );
  }

  void _createParametersNodes() {
    parametersNodes = createListNode<ParameterNode>(
      jsonKey: 'parameters',
      factory: (json, document, jsonPointer) => ParameterNode(json, document, jsonPointer),
    );
  }

  void _createRequestBodyNode() {
    requestBodyNode = createNode<RequestBodyNode>(
      jsonKey: 'requestBody',
      factory: (json, document, jsonPointer) => RequestBodyNode(json, document, jsonPointer),
    );
  }

  void _createResponseNodes() {
    responseNodes = createMapNode<ResponseNode>(
      jsonKey: 'responses',
      required: true,
      factory: (json, document, jsonPointer) => ResponseNode(json, document, jsonPointer),
    )!;
  }

  void _createCallbackNodes() {
    callbackNodes = createMapNode<CallbackNode>(
      jsonKey: 'callbacks',
      factory: (json, document, jsonPointer) => CallbackNode(json, document, jsonPointer),
    );
  }

  void _createSecurityRequirementNodes() {
    securityRequirementNodes = createListNode<SecurityRequirementNode>(
      jsonKey: 'security',
      factory: (json, document, jsonPointer) => SecurityRequirementNode(json, document, jsonPointer),
    );
  }

  void _createServerNodes() {
    serverNodes = createListNode<ServerNode>(
      jsonKey: 'servers',
      factory: (json, document, jsonPointer) => ServerNode(json, document, jsonPointer),
    );
  }

  @override
  void createContent() {
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
    // String jsonPointer = paths.content.paths.entries.firstWhere((entry) => entry.value == pathItem).key;
    // return jsonPointer.split('/').last;
  }
}
