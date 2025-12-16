import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class DiscriminatorNode extends OpenApiNode {
  DiscriminatorNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Discriminator content;

  void create() {
    _validateStructure();
    _createContent();
  }

  void _validateStructure() {
    final path = $id.jsonPointer;

    // Validate required: propertyName
    ValidationUtils.requireString(
      ValidationUtils.requireField(json, 'propertyName', path),
      ValidationUtils.buildPath(path, 'propertyName'),
    );

    // Validate optional: mapping (map of strings to strings)
    if (json.containsKey('mapping')) {
      final mapping = ValidationUtils.requireMap(json['mapping'], ValidationUtils.buildPath(path, 'mapping'));
      for (final entry in mapping.entries) {
        ValidationUtils.requireString(
          entry.value,
          ValidationUtils.buildPath(ValidationUtils.buildPath(path, 'mapping'), entry.key.toString()),
        );
      }
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, {'propertyName', 'mapping'}, path, 'Discriminator Object');

    _structureValidated = true;
  }

  void _createContent() {
    content = Discriminator._(
      $node: this,
      propertyName: json['propertyName'],
      mapping: json['mapping'] != null ? Map<String, String>.from(json['mapping']) : null,
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Discriminator object for polymorphism support.
class Discriminator {
  final DiscriminatorNode $node;
  final String propertyName;
  final Map<String, String>? mapping;
  final Map<String, dynamic>? extensions;

  Discriminator._({required this.$node, required this.propertyName, this.mapping, this.extensions});
}
