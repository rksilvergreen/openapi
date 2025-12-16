import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../referencable.dart';
import 'server.dart';

class LinkNode extends OpenApiNode with Referencable {
  LinkNode._(super.$id, super.json);

  factory LinkNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<LinkNode>(
        json,
        document,
        jsonPointer,
        (nodeId, json) => LinkNode._(nodeId, json),
      );

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final ServerNode? serverNode;

  late final Link content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // All fields are optional
    if (json.containsKey('operationRef')) {
      ValidationUtils.requireString(json['operationRef'], ValidationUtils.buildPath(jsonPointer, 'operationRef'));
    }

    if (json.containsKey('operationId')) {
      ValidationUtils.requireString(json['operationId'], ValidationUtils.buildPath(jsonPointer, 'operationId'));
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
      ValidationUtils.requireMap(json['parameters'], ValidationUtils.buildPath(jsonPointer, 'parameters'));
    }

    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(jsonPointer, 'description'));
    }

    if (json.containsKey('server')) {
      ValidationUtils.requireMap(json['server'], ValidationUtils.buildPath(jsonPointer, 'server'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'operationRef', 'operationId', 'parameters', 'requestBody', 'description', 'server'},
      jsonPointer,
      'Link Object',
    );

    _structureValidated = true;
  }

  void _createChildNodes() {
    // Create Server node
    if (json.containsKey('server')) {
      final serverJson = json['server'] as Map<String, dynamic>;
      serverNode = ServerNode(serverJson, $id.document, ValidationUtils.buildPath($id.jsonPointer, 'server'));
      OpenApiGraph.i.addOpenApiNode(serverNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, serverNode!.$id.absolutePointer, 'server'));
      serverNode!.create();
    }
  }


  void _createContent() {
    content = Link._(
      $node: this,
      operationRef: json['operationRef'],
      operationId: json['operationId'],
      parameters: json['parameters'] != null ? Map<String, dynamic>.from(json['parameters']) : null,
      requestBody: json['requestBody'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Link object represents a possible design-time link for a response.
class Link {
  final LinkNode $node;
  final String? operationRef;
  final String? operationId;
  final Map<String, dynamic>? parameters;
  final dynamic requestBody;
  final String? description;
  Server? get server => $node.serverNode?.content;
  final Map<String, dynamic>? extensions;

  Link._({
    required this.$node,
    this.operationRef,
    this.operationId,
    this.parameters,
    this.requestBody,
    this.description,
    this.extensions,
  });
}
