import '../openapi_graph.dart';
import 'server.dart';

class LinkNode extends OpenApiNode {
  LinkNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final ServerNode? serverNode;

  late final Link content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Link._(
      $id: $id,
      operationRef: json['operationRef'],
      operationId: json['operationId'],
      parameters: json['parameters'] != null ? Map<String, dynamic>.from(json['parameters']) : null,
      requestBody: json['requestBody'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
  }
}

/// Link object represents a possible design-time link for a response.
class Link {
  final LinkNode _$node;
  final String? operationRef;
  final String? operationId;
  final Map<String, dynamic>? parameters;
  final dynamic requestBody;
  final String? description;
  Server? get server => _$node.serverNode?.content;
  final Map<String, dynamic>? extensions;

  Link._({
    required NodeId $id,
    this.operationRef,
    this.operationId,
    this.parameters,
    this.requestBody,
    this.description,
    this.extensions,
  }) : _$node = OpenApiGraph.i.getOpenApiNode<LinkNode>($id);
}
