import '../validation/validation_utils.dart';
import 'external_documentation_doc_node.dart';
import '../doc_node.dart';
import '../edge.dart';
import '../list_doc_node.dart';

class TagDocNode extends DocNode with DocInternalNode {
  TagDocNode(super.json);

  late final String name;
  late final String? description;
  late final ExternalDocumentationDocNode? externalDocs;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;

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
    createNode<ExternalDocumentationDocNode>(jsonKey: 'externalDocs');
  }

  @override
  void createContent() {
    name = json['name'];
    description = json['description'];
    externalDocs = $to.to<ExternalDocumentationDocNode>('externalDocs');
    extensions = extractExtensions(json);
  }
}

class TagsListDocNode extends ListDocNode<TagDocNode> {
  TagsListDocNode(super.json);
}
