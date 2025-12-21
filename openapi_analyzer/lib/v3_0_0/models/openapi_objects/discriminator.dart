import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

abstract class Discriminator {
  String get propertyName;
  Map<String, String>? get mapping;
  Map<String, dynamic>? get extensions;
}

class DiscriminatorNode extends Node with LeafNode implements Discriminator {
  DiscriminatorNode(super.json, super.document, super.jsonPointer);

  late final String propertyName;
  late final Map<String, String>? mapping;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validatePropertyName(jsonPointer);
    _validateMapping(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validatePropertyName(String jsonPointer) {
    ValidationUtils.requireString(
      ValidationUtils.requireField(json, 'propertyName', jsonPointer),
      ValidationUtils.buildPointer([jsonPointer, 'propertyName']),
    );
  }

  void _validateMapping(String jsonPointer) {
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
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(json, {'propertyName', 'mapping'}, jsonPointer, 'Discriminator Object');
  }

  @override
  void createContent() {
    propertyName = json['propertyName'];
    mapping = json['mapping'] != null ? Map<String, String>.from(json['mapping']) : null;
    extensions = extractExtensions(json);
  }
}
