import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'external_documentation.dart';
import '../node_creation_helpers.dart';

abstract class Tag {
  String get name;
  String? get description;
  ExternalDocumentation? get externalDocs;
  Map<String, dynamic>? get extensions;
}

class TagNode extends OpenApiNode with InternalNode implements Tag {
  TagNode(super.json, super.document, super.jsonPointer);

  late final String name;
  late final String? description;
  late final ExternalDocumentationNode? externalDocs;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateName(jsonPointer);
    _validateDescription(jsonPointer);
    _validateExternalDocs(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateName(String jsonPointer) {
    final name = ValidationUtils.requireField(json, 'name', jsonPointer);
    ValidationUtils.requireNonEmptyString(name, ValidationUtils.buildPointer([jsonPointer, 'name']));
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateExternalDocs(String jsonPointer) {
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPointer([jsonPointer, 'externalDocs']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(json, {'name', 'description', 'externalDocs'}, jsonPointer, 'Tag Object');
  }

  @override
  void createChildNodes() {
    createNode<ExternalDocumentationNode>(jsonKey: 'externalDocs');
  }

  @override
  void createContent() {
    name = json['name'];
    description = json['description'];
    externalDocs = $to.to<ExternalDocumentationNode>('externalDocs');
    extensions = extractExtensions(json);
  }
}
