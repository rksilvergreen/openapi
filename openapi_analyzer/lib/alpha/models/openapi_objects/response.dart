import '../openapi_graph.dart';
import 'header.dart';
import 'media_type.dart';
import 'link.dart';

class ResponseNode extends OpenApiNode {
  ResponseNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, HeaderNode>? headersNodes;
  late final Map<String, MediaTypeNode>? contentNodes;
  late final Map<String, LinkNode>? linksNodes;

  late final Response content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Response._($id: $id, description: json['description'], extensions: extractExtensions(json));
  }
}

/// Describes a single response from an API Operation.
class Response {
  final ResponseNode _$node;
  final String description;
  Map<String, Header>? get headers => _$node.headersNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, MediaType>? get content => _$node.contentNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, Link>? get links => _$node.linksNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Response._({required NodeId $id, required this.description, this.extensions})
    : _$node = OpenApiGraph.i.getOpenApiNode<ResponseNode>($id);
}
