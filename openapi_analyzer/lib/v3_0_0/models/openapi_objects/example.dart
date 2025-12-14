import '../openapi_graph.dart';

class ExampleNode extends OpenApiNode {
  ExampleNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Example content;

  void _validateStructure() {}
  void _createContent() {
    content = Example._(
      $node: this,
      summary: json['summary'],
      description: json['description'],
      value: json['value'],
      externalValue: json['externalValue'],
      extensions: extractExtensions(json),
    );
  }
}

/// Example object for media type examples.
class Example {
  final ExampleNode $node;
  final String? summary;
  final String? description;
  final dynamic value;
  final String? externalValue;
  final Map<String, dynamic>? extensions;

  Example._({required this.$node, this.summary, this.description, this.value, this.externalValue, this.extensions});
}
