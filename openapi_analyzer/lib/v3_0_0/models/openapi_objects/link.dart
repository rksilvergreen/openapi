import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../referencable.dart';
import 'server.dart';
import '../node_creation_helpers.dart';

abstract class Link {
  String? get operationRef;
  String? get operationId;
  Map<String, dynamic>? get parameters;
  dynamic get requestBody;
  String? get description;
  Server? get server;
  Map<String, dynamic>? get extensions;
}

class LinkNode extends OpenApiNode with InternalNode, Referencable implements Link {
  LinkNode(super.json, super.document, super.jsonPointer);

  late final String? operationRef;
  late final String? operationId;
  late final Map<String, dynamic>? parameters;
  late final dynamic requestBody;
  late final String? description;
  late final ServerNode? server;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateOperationRef(jsonPointer);
    _validateOperationId(jsonPointer);
    _validateMutualExclusivity(jsonPointer);
    _validateParameters(jsonPointer);
    _validateDescription(jsonPointer);
    _validateServer(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateOperationRef(String jsonPointer) {
    if (json.containsKey('operationRef')) {
      ValidationUtils.requireString(json['operationRef'], ValidationUtils.buildPointer([jsonPointer, 'operationRef']));
    }
  }

  void _validateOperationId(String jsonPointer) {
    if (json.containsKey('operationId')) {
      ValidationUtils.requireString(json['operationId'], ValidationUtils.buildPointer([jsonPointer, 'operationId']));
    }
  }

  void _validateMutualExclusivity(String jsonPointer) {
    if (json.containsKey('operationRef') && json.containsKey('operationId')) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          jsonPointer,
          'Link Object cannot have both "operationRef" and "operationId"',
          specReference: 'OpenAPI 3.0.0 - Link Object',
          severity: ValidationSeverity.critical,
        ),
      );
    }
  }

  void _validateParameters(String jsonPointer) {
    if (json.containsKey('parameters')) {
      ValidationUtils.requireMap(json['parameters'], ValidationUtils.buildPointer([jsonPointer, 'parameters']));
    }
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateServer(String jsonPointer) {
    if (json.containsKey('server')) {
      ValidationUtils.requireMap(json['server'], ValidationUtils.buildPointer([jsonPointer, 'server']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'operationRef', 'operationId', 'parameters', 'requestBody', 'description', 'server'},
      jsonPointer,
      'Link Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<ServerNode>(jsonKey: 'server');
  }

  @override
  void createContent() {
    operationRef = json['operationRef'];
    operationId = json['operationId'];
    parameters = json['parameters'] != null ? Map<String, dynamic>.from(json['parameters']) : null;
    requestBody = json['requestBody'];
    description = json['description'];
    server = $to.to<ServerNode>('server');
    extensions = extractExtensions(json);
  }
}
