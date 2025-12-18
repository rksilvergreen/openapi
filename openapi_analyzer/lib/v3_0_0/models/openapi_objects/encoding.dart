import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'enums.dart';
import 'header.dart';
import 'headers_map.dart';

abstract class Encoding {
  String? get contentType;
  HeadersMap? get headers;
  ParameterStyle? get style;
  bool? get explode;
  bool get allowReserved;
  Map<String, dynamic>? get extensions;
}

class EncodingNode extends OpenApiNode with InternalNode implements Encoding {
  EncodingNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String? contentType;
  late final HeadersMapNode? headers;
  late final ParameterStyle? style;
  late final bool? explode;
  late final bool allowReserved;
  late final Map<String, dynamic>? extensions;

  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // All fields are optional
    if (json.containsKey('contentType')) {
      ValidationUtils.requireString(json['contentType'], ValidationUtils.buildPointer([jsonPointer, 'contentType']));
    }

    if (json.containsKey('headers')) {
      ValidationUtils.requireMap(json['headers'], ValidationUtils.buildPointer([jsonPointer, 'headers']));
    }

    if (json.containsKey('style')) {
      ValidationUtils.validateEnum(
        ValidationUtils.requireString(json['style'], ValidationUtils.buildPointer([jsonPointer, 'style'])),
        ['form', 'spaceDelimited', 'pipeDelimited', 'deepObject'],
        ValidationUtils.buildPointer([jsonPointer, 'style']),
      );
    }

    if (json.containsKey('explode')) {
      ValidationUtils.requireBool(json['explode'], ValidationUtils.buildPointer([jsonPointer, 'explode']));
    }

    if (json.containsKey('allowReserved')) {
      ValidationUtils.requireBool(json['allowReserved'], ValidationUtils.buildPointer([jsonPointer, 'allowReserved']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'contentType', 'headers', 'style', 'explode', 'allowReserved'},
      jsonPointer,
      'Encoding Object',
    );
  }

  @override
  void createChildNodes() {
    createMapNode<HeadersMapNode>(jsonKey: 'headers');
  }

  @override
  void createContent() {
    contentType = json['contentType'];
    headers = $to.to<HeadersMapNode>('headers');
    style = json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null;
    explode = json['explode'];
    allowReserved = json['allowReserved'] ?? false;
    extensions = extractExtensions(json);
  }
}
