import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../referencable.dart';

abstract class Example {
  String? get summary;
  String? get description;
  dynamic get value;
  String? get externalValue;
  Map<String, dynamic>? get extensions;
}

class ExampleNode extends OpenApiNode with LeafNode, Referencable implements Example {
  ExampleNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String? summary;
  late final String? description;
  late final dynamic value;
  late final String? externalValue;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // All fields are optional
    if (json.containsKey('summary')) {
      ValidationUtils.requireString(json['summary'], ValidationUtils.buildPointer([jsonPointer, 'summary']));
    }

    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }

    if (json.containsKey('externalValue')) {
      ValidationUtils.requireString(
        json['externalValue'],
        ValidationUtils.buildPointer([jsonPointer, 'externalValue']),
      );
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
  }

  @override
  void createContent() {
    summary = json['summary'];
    description = json['description'];
    value = json['value'];
    externalValue = json['externalValue'];
    extensions = extractExtensions(json);
  }
}


