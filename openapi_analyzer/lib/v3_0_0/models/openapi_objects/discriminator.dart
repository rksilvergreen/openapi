import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

abstract class Discriminator {
  String get propertyName;
  Map<String, String>? get mapping;
  Map<String, dynamic>? get extensions;
}

class DiscriminatorNode extends OpenApiNode with LeafNode implements Discriminator {
  DiscriminatorNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String propertyName;
  late final Map<String, String>? mapping;
  late final Map<String, dynamic>? extensions;

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
    propertyName = json['propertyName'];
    mapping = json['mapping'] != null ? Map<String, String>.from(json['mapping']) : null;
    extensions = extractExtensions(json);
  }
}
