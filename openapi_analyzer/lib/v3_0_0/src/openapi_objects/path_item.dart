import '../validation/validation_utils.dart';
import '../referencable.dart';
import '../node.dart';
import '../edge.dart';
import 'operation.dart';
import 'server.dart';
import 'parameter.dart';
import 'package:openapi_analyzer/v3_0_0/objects/path_item.dart';
import 'package:openapi_analyzer/v3_0_0/objects/server.dart';
import 'package:openapi_analyzer/v3_0_0/objects/parameter.dart';
import '../map_node.dart';
import '../openapi_graph.dart';
import '../../../validation_exception.dart';

class PathItemNode extends Node with InternalNode, Referencable implements PathItem {
  PathItemNode(super.json, super.document, super.jsonPointer);

  late final String? summary;
  late final String? description;
  late final OperationNode? get_;
  late final OperationNode? put;
  late final OperationNode? post;
  late final OperationNode? delete;
  late final OperationNode? options;
  late final OperationNode? head;
  late final OperationNode? patch;
  late final OperationNode? trace;
  late final ServerList? servers;
  late final ParametersList? parameters;
  late final Map<String, dynamic>? extensions;

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
    createNode<OperationNode>(jsonKey: 'get');
    createNode<OperationNode>(jsonKey: 'put');
    createNode<OperationNode>(jsonKey: 'post');
    createNode<OperationNode>(jsonKey: 'delete');
    createNode<OperationNode>(jsonKey: 'options');
    createNode<OperationNode>(jsonKey: 'head');
    createNode<OperationNode>(jsonKey: 'patch');
    createNode<OperationNode>(jsonKey: 'trace');
    createNode<ServerNode>(jsonKey: 'servers');
    createNode<ParameterNode>(jsonKey: 'parameters');
  }

  @override
  void createContent() {
    summary = json['summary'];
    description = json['description'];
    get_ = $to.to<OperationNode>('get');
    put = $to.to<OperationNode>('put');
    post = $to.to<OperationNode>('post');
    delete = $to.to<OperationNode>('delete');
    options = $to.to<OperationNode>('options');
    head = $to.to<OperationNode>('head');
    patch = $to.to<OperationNode>('patch');
    trace = $to.to<OperationNode>('trace');
    servers = $to.to<ServerListNode>('servers');
    parameters = $to.to<ParametersListNode>('parameters');
    extensions = extractExtensions(json);
  }
}

class PathsMapNode extends MapNode<PathItemNode, PathItem> implements PathsMap {
  PathsMapNode(super.json, super.document, super.jsonPointer);

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    _validateFormat(jsonPointer);
    super.validateStructure();
  }

  void _validateFormat(String jsonPointer) {
    for (final key in json.keys) {
      final keyStr = key.toString();
      if (!keyStr.startsWith('/')) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([jsonPointer, keyStr]),
            'Path must start with "/"',
            specReference: 'OpenAPI 3.0.0 - Paths Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }
}
