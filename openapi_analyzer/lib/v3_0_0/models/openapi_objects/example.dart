import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';

class ExampleNode extends OpenApiNode {
  ExampleNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Example content;

  void create() {
    _validateStructure();
    if (!_handleRef()) {
      _createContent();
    }
  }

  void _validateStructure() {
    final path = $id.jsonPointer;

    // Check for $ref - if present, only validate $ref
    if (json.containsKey('\$ref')) {
      final refValue = ValidationUtils.requireString(json['\$ref'], ValidationUtils.buildPath(path, '\$ref'));
      ValidationUtils.validateRefFormat(refValue, ValidationUtils.buildPath(path, '\$ref'));
      ValidationUtils.validateNoUnknownFields(json, {'\$ref'}, path, 'Reference Object');
      _structureValidated = true;
      return;
    }

    // All fields are optional
    if (json.containsKey('summary')) {
      ValidationUtils.requireString(json['summary'], ValidationUtils.buildPath(path, 'summary'));
    }

    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    if (json.containsKey('externalValue')) {
      ValidationUtils.requireString(json['externalValue'], ValidationUtils.buildPath(path, 'externalValue'));
    }

    // Validate mutual exclusivity: value and externalValue cannot both be present
    if (json.containsKey('value') && json.containsKey('externalValue')) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          path,
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
      path,
      'Example Object',
    );

    _structureValidated = true;
  }

  /// Handles $ref resolution. Returns true if $ref was present, false otherwise.
  bool _handleRef() {
    if (!json.containsKey('\$ref')) {
      return false;
    }

    final ref = json['\$ref'] as String;
    final resolved = OpenApiGraph.i.referenceResolver.parseReference(ref, $id.jsonPointer);

    // Load document
    Map<dynamic, dynamic> targetDoc;
    if (resolved.isExternal) {
      targetDoc = OpenApiGraph.i.referenceResolver.loadExternalDocument(resolved.documentPath);
    } else {
      targetDoc = OpenApiGraph.i.getLoadedDocument($id.document);
    }

    // Resolve pointer within document
    final targetJson = OpenApiGraph.i.referenceResolver.resolvePointer(targetDoc, resolved.jsonPointer);

    if (targetJson == null) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          $id.jsonPointer,
          'Reference not found: $ref',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        ),
      );
      return true;
    }

    return true;
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
