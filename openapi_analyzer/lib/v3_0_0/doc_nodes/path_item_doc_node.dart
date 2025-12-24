import '../validation/validation_utils.dart';
import '../referencable.dart';
import '../doc_node.dart';
import '../edge.dart';
import 'operation_doc_node.dart';
import 'server_doc_node.dart';
import 'parameter_doc_node.dart';
import '../map_doc_node.dart';
import '../openapi_graph.dart';
import '../../validation_exception.dart';

class PathItemDocNode extends DocNode with DocInternalNode, Referencable {
  PathItemDocNode(super.json);

  late final String? summary;
  late final String? description;
  late final OperationDocNode? get_;
  late final OperationDocNode? put;
  late final OperationDocNode? post;
  late final OperationDocNode? delete;
  late final OperationDocNode? options;
  late final OperationDocNode? head;
  late final OperationDocNode? patch;
  late final OperationDocNode? trace;
  late final ServerListDocNode? servers;
  late final ParametersListDocNode? parameters;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;

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
    createNode<OperationDocNode>(jsonKey: 'get');
    createNode<OperationDocNode>(jsonKey: 'put');
    createNode<OperationDocNode>(jsonKey: 'post');
    createNode<OperationDocNode>(jsonKey: 'delete');
    createNode<OperationDocNode>(jsonKey: 'options');
    createNode<OperationDocNode>(jsonKey: 'head');
    createNode<OperationDocNode>(jsonKey: 'patch');
    createNode<OperationDocNode>(jsonKey: 'trace');
    createNode<ServerDocNode>(jsonKey: 'servers');
    createNode<ParameterDocNode>(jsonKey: 'parameters');
  }

  @override
  void createContent() {
    summary = json['summary'];
    description = json['description'];
    get_ = $to.to<OperationDocNode>('get');
    put = $to.to<OperationDocNode>('put');
    post = $to.to<OperationDocNode>('post');
    delete = $to.to<OperationDocNode>('delete');
    options = $to.to<OperationDocNode>('options');
    head = $to.to<OperationDocNode>('head');
    patch = $to.to<OperationDocNode>('patch');
    trace = $to.to<OperationDocNode>('trace');
    servers = $to.to<ServerListDocNode>('servers');
    parameters = $to.to<ParametersListDocNode>('parameters');
    extensions = extractExtensions(json);
  }
}

class PathsMapDocNode extends MapDocNode<PathItemDocNode> {
  PathsMapDocNode(super.json);

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;
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
