import '../openapi_graph.dart';
import 'schema/schema_node.dart';
import 'schema/effective_schema/effective_schema.dart';
import 'example.dart';
import 'encoding.dart';

class MediaTypeNode extends OpenApiNode {
  MediaTypeNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentValidated = false;

  bool get structureValidated => _structureValidated;
  bool get contentValidated => _contentValidated;

  late final SchemaNode? schemaNode;
  late final Map<String, ExampleNode>? examplesNodes;
  late final Map<String, EncodingNode>? encodingNodes;

  late final MediaType content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = MediaType._($id: $id, example: json['example'], extensions: extractExtensions(json));
  }
}

/// Each Media Type Object provides schema and examples for the media type.
class MediaType {
  final MediaTypeNode _$node;
  EffectiveSchema? get schema => _$node.schemaNode?.effective;
  final dynamic example;
  Map<String, Example>? get examples => _$node.examplesNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, Encoding>? get encoding => _$node.encodingNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  MediaType._({required NodeId $id, this.example, this.extensions})
    : _$node = OpenApiRegistry.i.getOpenApiNode<MediaTypeNode>($id);
}
