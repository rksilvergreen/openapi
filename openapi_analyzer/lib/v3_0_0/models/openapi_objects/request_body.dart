import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import '../referencable.dart';
import 'media_types_map.dart';

abstract class RequestBody {
  String? get description;
  bool get required;
  MediaTypesMap get content;
  Map<String, dynamic>? get extensions;
}

class RequestBodyNode extends OpenApiNode with InternalNode, Referencable implements RequestBody {
  RequestBodyNode(super.json, super.document, super.jsonPointer);

  late final String? description;
  late final bool required;
  late final MediaTypesMapNode content;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateContent(jsonPointer);
    _validateDescription(jsonPointer);
    _validateRequired(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateContent(String jsonPointer) {
    final content = ValidationUtils.requireField(json, 'content', jsonPointer);
    ValidationUtils.requireMap(content, ValidationUtils.buildPointer([jsonPointer, 'content']));
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateRequired(String jsonPointer) {
    if (json.containsKey('required')) {
      ValidationUtils.requireBool(json['required'], ValidationUtils.buildPointer([jsonPointer, 'required']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'description', 'content', 'required'},
      jsonPointer,
      'Request Body Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<MediaTypesMapNode>(jsonKey: 'content');
  }

  @override
  void createContent() {
    description = json['description'];
    required = json['required'];
    content = $to.to<MediaTypesMapNode>('content')!;
    extensions = extractExtensions(json);
  }
}
