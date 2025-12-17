import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class DiscriminatorNode extends OpenApiNode with LeafNode {
  DiscriminatorNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final Discriminator content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate required: propertyName
    ValidationUtils.requireString(
      ValidationUtils.requireField(json, 'propertyName', jsonPointer),
      ValidationUtils.buildPointer([jsonPointer, 'propertyName']),
    );

    // Validate optional: mapping (map of strings to strings)
    if (json.containsKey('mapping')) {
      final mapping = ValidationUtils.requireMap(
        json['mapping'],
        ValidationUtils.buildPointer([jsonPointer, 'mapping']),
      );
      for (final entry in mapping.entries) {
        ValidationUtils.requireString(
          entry.value,
          ValidationUtils.buildPointer([jsonPointer, 'mapping', entry.key.toString()]),
        );
      }
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, {'propertyName', 'mapping'}, jsonPointer, 'Discriminator Object');
  }

  @override
  void createContent() {
    content = Discriminator._(
      $node: this,
      propertyName: json['propertyName'],
      mapping: json['mapping'] != null ? Map<String, String>.from(json['mapping']) : null,
      extensions: extractExtensions(json),
    );
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
