import '../openapi_graph.dart';

class ContactNode extends OpenApiNode {
  ContactNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Contact content;

  void _validateStructure() {}
  void _createContent() {
    content = Contact._(
      $node: this,
      name: json['name'],
      url: json['url'],
      email: json['email'],
      extensions: extractExtensions(json),
    );
  }
}

/// Contact information for the exposed API.
class Contact {
  final ContactNode $node;
  final String? name;
  final String? url;
  final String? email;
  final Map<String, dynamic>? extensions;

  Contact._({required this.$node, required this.name, this.url, this.email, this.extensions});
}
