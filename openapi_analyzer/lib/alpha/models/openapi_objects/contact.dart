import '../openapi_graph.dart';

class ContactNode extends OpenApiNode {
  ContactNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentValidated = false;

  bool get structureValidated => _structureValidated;
  bool get contentValidated => _contentValidated;

  late final Contact content;

  void _validateStructure() {}
  void _createContent() {
    content = Contact._(
      $id: $id,
      name: json['name'],
      url: json['url'],
      email: json['email'],
      extensions: extractExtensions(json),
    );
  }
}

/// Contact information for the exposed API.
class Contact {
  final ContactNode _$node;
  final String? name;
  final String? url;
  final String? email;
  final Map<String, dynamic>? extensions;

  Contact._({required NodeId $id, required this.name, this.url, this.email, this.extensions})
    : _$node = OpenApiRegistry.i.getOpenApiNode<ContactNode>($id);
}
