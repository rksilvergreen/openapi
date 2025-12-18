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
  LinkNode(Map<String, dynamic> json, String document, String jsonPointer) : super(NodeId(document, jsonPointer), json);

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

    // All fields are optional
    if (json.containsKey('operationRef')) {
      ValidationUtils.requireString(json['operationRef'], ValidationUtils.buildPointer([jsonPointer, 'operationRef']));
    }

    if (json.containsKey('operationId')) {
      ValidationUtils.requireString(json['operationId'], ValidationUtils.buildPointer([jsonPointer, 'operationId']));
    }

    // Validate mutual exclusivity: operationRef and operationId cannot both be present
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

    if (json.containsKey('parameters')) {
      ValidationUtils.requireMap(json['parameters'], ValidationUtils.buildPointer([jsonPointer, 'parameters']));
    }

    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }

    if (json.containsKey('server')) {
      ValidationUtils.requireMap(json['server'], ValidationUtils.buildPointer([jsonPointer, 'server']));
    }

    // Validate no unknown fields
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
