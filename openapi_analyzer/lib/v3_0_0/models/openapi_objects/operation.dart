import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'external_documentation.dart';
import 'request_body.dart';
import 'security_requirement.dart';
import 'server.dart';
import 'responses_map.dart';
import 'callbacks_map.dart';
import 'parameters_list.dart';
import 'security_requirements_list.dart';
import 'server_list.dart';

abstract class Operation {
  ExternalDocumentation? get externalDocs;
  ParametersList? get parameters;
  RequestBody? get requestBody;
  ResponsesMap get responses;
  CallbacksMap? get callbacks;
  SecurityRequirementsList? get security;
  ServerList? get servers;
}

class OperationNode extends OpenApiNode with InternalNode implements Operation {
  OperationNode(super.json, super.document, super.jsonPointer);

  late final List<String>? tags;
  late final String? summary;
  late final String? description;
  late final String? operationId;
  late final ExternalDocumentationNode? externalDocs;
  late final ParametersListNode? parameters;
  late final RequestBodyNode? requestBody;
  late final ResponsesMapNode responses;
  late final CallbacksMapNode? callbacks;
  late final SecurityRequirementsListNode security;
  late final ServerListNode servers;
  late final Map<String, dynamic>? extensions;

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
    createNode<ExternalDocumentationNode>(jsonKey: 'externalDocs');
    createNode<ParametersListNode>(jsonKey: 'parameters');
    createNode<RequestBodyNode>(jsonKey: 'requestBody');
    createNode<ResponsesMapNode>(jsonKey: 'responses', required: true);
    createNode<CallbacksMapNode>(jsonKey: 'callbacks');
    createNode<SecurityRequirementNode>(jsonKey: 'security');
    createNode<ServerNode>(jsonKey: 'servers');
  }

  @override
  void createContent() {
    tags = json['tags'] != null ? List<String>.from(json['tags']) : null;
    summary = json['summary'];
    description = json['description'];
    operationId = json['operationId'];
    externalDocs = $to.to<ExternalDocumentationNode>('externalDocs');
    parameters = $to.to<ParametersListNode>('parameters');
    requestBody = $to.to<RequestBodyNode>('requestBody');
    responses = $to.to<ResponsesMapNode>('responses')!;
    callbacks = $to.to<CallbacksMapNode>('callbacks');
    security = $to.to<SecurityRequirementsListNode>('security')!;
    servers = $to.to<ServerListNode>('servers')!;
    extensions = extractExtensions(json);
  }
}
