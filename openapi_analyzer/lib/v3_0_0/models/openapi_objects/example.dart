import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../referencable.dart';

class ExampleNode extends OpenApiNode with Referencable {
  ExampleNode._(super.$id, super.json);

  factory ExampleNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<ExampleNode>(json, document, jsonPointer, (nodeId, json) => ExampleNode._(nodeId, json));

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Example content;

  void create() {
    _validateStructure();
    _createContent();
  }

  void _validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // All fields are optional
    if (json.containsKey('summary')) {
      ValidationUtils.requireString(json['summary'], ValidationUtils.buildPointer([jsonPointer, 'summary']));
    }

    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }

    if (json.containsKey('externalValue')) {
      ValidationUtils.requireString(json['externalValue'], ValidationUtils.buildPointer([jsonPointer, 'externalValue']));
    }

    // Validate mutual exclusivity: value and externalValue cannot both be present
    if (json.containsKey('value') && json.containsKey('externalValue')) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          jsonPointer,
          'Example Object cannot have both "value" and "externalValue"',
          specReference: 'OpenAPI 3.0.0 - Example Object',
          severity: ValidationSeverity.critical,
        ),
      );
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'summary', 'description', 'value', 'externalValue'},
      jsonPointer,
      'Example Object',
    );

    _structureValidated = true;
  }

  void _createContent() {
    content = Example._(
      $node: this,
      summary: json['summary'],
      description: json['description'],
      value: json['value'],
      externalValue: json['externalValue'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
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
