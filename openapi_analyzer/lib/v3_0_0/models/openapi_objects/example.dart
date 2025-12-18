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
  ExampleNode(super.json, super.document, super.jsonPointer);

  late final String? summary;
  late final String? description;
  late final dynamic value;
  late final String? externalValue;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateSummary(jsonPointer);
    _validateDescription(jsonPointer);
    _validateExternalValue(jsonPointer);
    _validateMutualExclusivity(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateSummary(String jsonPointer) {
    if (json.containsKey('summary')) {
      ValidationUtils.requireString(json['summary'], ValidationUtils.buildPointer([jsonPointer, 'summary']));
    }
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateExternalValue(String jsonPointer) {
    if (json.containsKey('externalValue')) {
      ValidationUtils.requireString(
        json['externalValue'],
        ValidationUtils.buildPointer([jsonPointer, 'externalValue']),
      );
    }
  }

  void _validateMutualExclusivity(String jsonPointer) {
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
  }

  void _validateNoUnknownFields(String jsonPointer) {
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


