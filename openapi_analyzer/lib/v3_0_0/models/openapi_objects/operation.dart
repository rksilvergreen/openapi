import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
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
  OperationNode(super.$id, super.json);

  void create() {
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

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate required: responses (object)
    final responses = ValidationUtils.requireField(json, 'responses', path);
    ValidationUtils.requireMap(responses, ValidationUtils.buildPath(path, 'responses'));

    // Validate optional: tags (array of strings)
    if (json.containsKey('tags')) {
      final tags = ValidationUtils.requireList(json['tags'], ValidationUtils.buildPath(path, 'tags'));
      for (var i = 0; i < tags.length; i++) {
        ValidationUtils.requireString(
          tags[i],
          ValidationUtils.buildPath(ValidationUtils.buildPath(path, 'tags'), '[$i]'),
        );
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

    // Validate optional: externalDocs (object)
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPath(path, 'externalDocs'));
    }

    // Validate optional: operationId (string)
    if (json.containsKey('operationId')) {
      ValidationUtils.requireString(json['operationId'], ValidationUtils.buildPath(path, 'operationId'));
      // Note: uniqueness validation across all operations will be done in semantic validation
    }

    // Validate optional: parameters (array)
    if (json.containsKey('parameters')) {
      ValidationUtils.requireList(json['parameters'], ValidationUtils.buildPath(path, 'parameters'));
    }

    // Validate optional: requestBody (object)
    if (json.containsKey('requestBody')) {
      ValidationUtils.requireMap(json['requestBody'], ValidationUtils.buildPath(path, 'requestBody'));
    }

    // Validate optional: callbacks (object)
    if (json.containsKey('callbacks')) {
      ValidationUtils.requireMap(json['callbacks'], ValidationUtils.buildPath(path, 'callbacks'));
    }

    // Validate optional: deprecated (boolean)
    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }

    // Validate optional: security (array)
    if (json.containsKey('security')) {
      ValidationUtils.requireList(json['security'], ValidationUtils.buildPath(path, 'security'));
    }

    // Validate optional: servers (array)
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPath(path, 'servers'));
    }

    // Validate no unknown fields
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
      path,
      'Operation Object',
    );
  }

  void _createChildNodes() {
    // Create ExternalDocs node
    if (json.containsKey('externalDocs')) {
      final externalDocsJson = json['externalDocs'] as Map<String, dynamic>;
      externalDocsNode = ExternalDocumentationNode(
        NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'externalDocs')),
        externalDocsJson,
      );
      OpenApiGraph.i.addOpenApiNode(externalDocsNode!);
      OpenApiGraph.i.addOpenApiEdge(
        OpenApiEdge($id.absolutePointer, externalDocsNode!.$id.absolutePointer, 'externalDocs'),
      );
      externalDocsNode!.create();
    }

    // Create Parameters nodes
    if (json.containsKey('parameters')) {
      final parametersList = json['parameters'] as List;
      parametersNodes = [];
      for (var i = 0; i < parametersList.length; i++) {
        final parameterJson = parametersList[i] as Map<String, dynamic>;
        final parameterNode = ParameterNode(
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'parameters'), '[$i]'),
          ),
          parameterJson,
        );
        parametersNodes!.add(parameterNode);
        OpenApiGraph.i.addOpenApiNode(parameterNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePointer, parameterNode.$id.absolutePointer, 'parameters'),
        );
        parameterNode.create();
      }
    }

    // Create RequestBody node
    if (json.containsKey('requestBody')) {
      final requestBodyJson = json['requestBody'] as Map<String, dynamic>;

      // Resolve reference if present
      final (nodeId, actualJson, wasReference) = OpenApiGraph.i.referenceResolver.resolveReferenceIfPresent(
        requestBodyJson,
        NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'requestBody')),
        $id.jsonPointer,
      );

      // Check if node already exists (for references)
      if (wasReference && OpenApiGraph.i.openApiNodes.containsKey(nodeId.absolutePointer)) {
        requestBodyNode = OpenApiGraph.i.openApiNodes[nodeId.absolutePointer] as RequestBodyNode;
      } else {
        requestBodyNode = RequestBodyNode(nodeId, actualJson);
        OpenApiGraph.i.addOpenApiNode(requestBodyNode!);
        requestBodyNode!.create();
      }

      OpenApiGraph.i.addOpenApiEdge(
        OpenApiEdge($id.absolutePointer, requestBodyNode!.$id.absolutePointer, 'requestBody'),
      );
    }

    // Create Response nodes
    final responsesJson = json['responses'] as Map<String, dynamic>;
    responseNodes = {};
    for (final entry in responsesJson.entries) {
      final statusCode = entry.key.toString();
      if (statusCode.startsWith('x-')) continue; // Skip extensions

      final responseJson = entry.value as Map<String, dynamic>;
      final responseNode = ResponseNode(
        NodeId(
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'responses'), statusCode),
        ),
        responseJson,
      );
      responseNodes[statusCode] = responseNode;
      OpenApiGraph.i.addOpenApiNode(responseNode);
      OpenApiGraph.i.addOpenApiEdge(
        OpenApiEdge($id.absolutePointer, responseNode.$id.absolutePointer, 'responses/$statusCode'),
      );
      responseNode.create();
    }

    // Create Callback nodes
    if (json.containsKey('callbacks')) {
      final callbacksMap = json['callbacks'] as Map<String, dynamic>;
      callbackNodes = {};
      for (final entry in callbacksMap.entries) {
        final callbackName = entry.key.toString();
        if (callbackName.startsWith('x-')) continue; // Skip extensions

        final callbackJson = entry.value as Map<String, dynamic>;
        final callbackNode = CallbackNode(
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'callbacks'), callbackName),
          ),
          callbackJson,
        );
        callbackNodes![callbackName] = callbackNode;
        OpenApiGraph.i.addOpenApiNode(callbackNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePointer, callbackNode.$id.absolutePointer, 'callbacks/$callbackName'),
        );
        callbackNode.create();
      }
    }

    // Create Security Requirement nodes
    if (json.containsKey('security')) {
      final securityList = json['security'] as List;
      securityRequirementNodes = [];
      for (var i = 0; i < securityList.length; i++) {
        final securityJson = securityList[i] as Map<String, dynamic>;
        final securityNode = SecurityRequirementNode(
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'security'), '[$i]'),
          ),
          securityJson,
        );
        securityRequirementNodes!.add(securityNode);
        OpenApiGraph.i.addOpenApiNode(securityNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, securityNode.$id.absolutePointer, 'security'));
        securityNode.create();
      }
    }

    // Create Server nodes
    if (json.containsKey('servers')) {
      final serversList = json['servers'] as List;
      serverNodes = [];
      for (var i = 0; i < serversList.length; i++) {
        final serverJson = serversList[i] as Map<String, dynamic>;
        final serverNode = ServerNode(
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'servers'), '[$i]'),
          ),
          serverJson,
        );
        serverNodes!.add(serverNode);
        OpenApiGraph.i.addOpenApiNode(serverNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, serverNode.$id.absolutePointer, 'servers'));
        serverNode.create();
      }
    }
  }

  void _createContent() {
    content = Operation._(
      $node: this,
      tags: json['tags'],
      summary: json['summary'],
      description: json['description'],
      operationId: json['operationId'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
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
