import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'enums.dart';
import 'header.dart';

class EncodingNode extends OpenApiNode with InternalNode {
  EncodingNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final Map<String, HeaderNode>? headersNodes;

  late final Encoding content;

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
    _createHeadersNodes();
  }

  void _createHeadersNodes() {
    headersNodes = createMapNode<HeaderNode>(
      jsonKey: 'headers',
      factory: (json, document, jsonPointer) => HeaderNode(json, document, jsonPointer),
    );
  }

  @override
  void createContent() {
    content = Encoding._(
      $node: this,
      contentType: json['contentType'],
      style: json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null,
      explode: json['explode'],
      allowReserved: json['allowReserved'] ?? false,
      extensions: extractExtensions(json),
    );
  }
}

class Encoding {
  final EncodingNode $node;
  final String? contentType;
  Map<String, Header>? get headers => $node.headersNodes?.map((k, v) => MapEntry(k, v.content));
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final Map<String, dynamic>? extensions;

  Encoding._(Map<String, dynamic> arguments)
    : $node = arguments['$node'],
      contentType = arguments['contentType'],
      style = arguments['style'],
      explode = arguments['explode'],
      allowReserved = arguments['allowReserved'] ?? false,
      extensions = arguments['extensions'];
}

// /// A single encoding definition applied to a single schema property.
// class Encoding {
//   final EncodingNode $node;
//   final String? contentType;
//   Map<String, Header>? get headers => $node.headersNodes?.map((k, v) => MapEntry(k, v.content));
//   final ParameterStyle? style;
//   final bool? explode;
//   final bool allowReserved;
//   final Map<String, dynamic>? extensions;

//   Encoding._({
//     required this.$node,
//     this.contentType,
//     this.style,
//     this.explode,
//     this.allowReserved = false,
//     this.extensions,
//   });
// }
