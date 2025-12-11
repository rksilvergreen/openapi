import '../openapi_graph.dart';

class DiscriminatorNode extends OpenApiNode {
  DiscriminatorNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Discriminator content;

  void _validateStructure() {}
  void _createContent() {
    content = Discriminator._(
      $id: $id,
      propertyName: json['propertyName'],
      mapping: json['mapping'] != null ? Map<String, String>.from(json['mapping']) : null,
      extensions: extractExtensions(json),
    );
  }
}

/// Discriminator object for polymorphism support.
class Discriminator {
  final DiscriminatorNode _$node;
  final String propertyName;
  final Map<String, String>? mapping;
  final Map<String, dynamic>? extensions;

  Discriminator._({required NodeId $id, required this.propertyName, this.mapping, this.extensions})
    : _$node = OpenApiGraph.i.getOpenApiNode<DiscriminatorNode>($id);
}
