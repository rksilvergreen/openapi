import '../openapi_graph.dart';
import 'media_type.dart';

class RequestBodyNode extends OpenApiNode {
  RequestBodyNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, MediaTypeNode> contentNodes;

  late final RequestBody content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = RequestBody._(
      $id: $id,
      description: json['description'],
      required_: json['required'],
      extensions: extractExtensions(json),
    );
  }
}

/// Describes a single request body.
class RequestBody {
  final RequestBodyNode _$node;
  final String? description;
  Map<String, MediaType> get content => _$node.contentNodes.map((k, v) => MapEntry(k, v.content));
  final bool required_;
  final Map<String, dynamic>? extensions;

  RequestBody._({required NodeId $id, this.description, this.required_ = false, this.extensions})
    : _$node = OpenApiGraph.i.getOpenApiNode<RequestBodyNode>($id);
}
