import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import '../node_creation_helpers.dart';
import 'headers_map.dart';
import 'media_types_map.dart';
import 'links_map.dart';

abstract class Response {
  String? get description;
  HeadersMap? get headers;
  MediaTypesMap? get content;
  LinksMap? get links;
  Map<String, dynamic>? get extensions;
}

class ResponseNode extends OpenApiNode with InternalNode, Referencable implements Response {
  ResponseNode(super.json, super.document, super.jsonPointer);

  late final String? description;
  late final HeadersMapNode? headers;
  late final MediaTypesMapNode? content;
  late final LinksMapNode? links;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateDescription(jsonPointer);
    _validateHeaders(jsonPointer);
    _validateContent(jsonPointer);
    _validateLinks(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateDescription(String jsonPointer) {
    final description = ValidationUtils.requireField(json, 'description', jsonPointer);
    ValidationUtils.requireString(description, ValidationUtils.buildPointer([jsonPointer, 'description']));
  }

  void _validateHeaders(String jsonPointer) {
    if (json.containsKey('headers')) {
      ValidationUtils.requireMap(json['headers'], ValidationUtils.buildPointer([jsonPointer, 'headers']));
    }
  }

  void _validateContent(String jsonPointer) {
    if (json.containsKey('content')) {
      ValidationUtils.requireMap(json['content'], ValidationUtils.buildPointer([jsonPointer, 'content']));
    }
  }

  void _validateLinks(String jsonPointer) {
    if (json.containsKey('links')) {
      ValidationUtils.requireMap(json['links'], ValidationUtils.buildPointer([jsonPointer, 'links']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'description', 'headers', 'content', 'links'},
      jsonPointer,
      'Response Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<HeadersMapNode>(jsonKey: 'headers');
    createNode<MediaTypesMapNode>(jsonKey: 'content');
    createNode<LinksMapNode>(jsonKey: 'links');
  }

  @override
  void createContent() {
    description = json['description'];
    headers = $to.to<HeadersMapNode>('headers');
    content = $to.to<MediaTypesMapNode>('content');
    links = $to.to<LinksMapNode>('links');
    extensions = extractExtensions(json);
  }
}
