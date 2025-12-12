import '../openapi_graph.dart';

class LicenseNode extends OpenApiNode {
  LicenseNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final License content;

  void _validateStructure() {}
  void _createContent() {
    content = License._($node: this, name: json['name'], url: json['url'], extensions: extractExtensions(json));
  }
}

/// License information for the exposed API.
class License {
  final LicenseNode $node;

  final String name;
  final String? url;
  final Map<String, dynamic>? extensions;

  License._({required this.$node, required this.name, this.url, this.extensions});
}
