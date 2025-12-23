import '../validation/validation_utils.dart';
import '../node.dart';
import '../edge.dart';
import 'enums.dart';
import 'headers_map.dart';
import 'package:openapi_analyzer/v3_0_0/objects/encoding.dart';
import '../map_node.dart';

class EncodingNode extends Node with InternalNode implements Encoding {
  EncodingNode(super.json, super.document, super.jsonPointer);

  late final String? contentType;
  late final HeadersMapNode? headers;
  late final ParameterStyle? style;
  late final bool? explode;
  late final bool allowReserved;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateContentType(jsonPointer);
    _validateHeaders(jsonPointer);
    _validateStyle(jsonPointer);
    _validateExplode(jsonPointer);
    _validateAllowReserved(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateContentType(String jsonPointer) {
    if (json.containsKey('contentType')) {
      ValidationUtils.requireString(json['contentType'], ValidationUtils.buildPointer([jsonPointer, 'contentType']));
    }
  }

  void _validateHeaders(String jsonPointer) {
    if (json.containsKey('headers')) {
      ValidationUtils.requireMap(json['headers'], ValidationUtils.buildPointer([jsonPointer, 'headers']));
    }
  }

  void _validateStyle(String jsonPointer) {
    if (json.containsKey('style')) {
      ValidationUtils.validateEnum(
        ValidationUtils.requireString(json['style'], ValidationUtils.buildPointer([jsonPointer, 'style'])),
        ['form', 'spaceDelimited', 'pipeDelimited', 'deepObject'],
        ValidationUtils.buildPointer([jsonPointer, 'style']),
      );
    }
  }

  void _validateExplode(String jsonPointer) {
    if (json.containsKey('explode')) {
      ValidationUtils.requireBool(json['explode'], ValidationUtils.buildPointer([jsonPointer, 'explode']));
    }
  }

  void _validateAllowReserved(String jsonPointer) {
    if (json.containsKey('allowReserved')) {
      ValidationUtils.requireBool(json['allowReserved'], ValidationUtils.buildPointer([jsonPointer, 'allowReserved']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'contentType', 'headers', 'style', 'explode', 'allowReserved'},
      jsonPointer,
      'Encoding Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<HeadersMapNode>(jsonKey: 'headers');
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

class EncodingsMapNode extends MapNode<EncodingNode, Encoding> implements EncodingsMap {
  EncodingsMapNode(super.json, super.document, super.jsonPointer);
}

