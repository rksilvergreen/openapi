import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'enums.dart';
import 'header.dart';

class EncodingNode extends OpenApiNode {
  EncodingNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, HeaderNode>? headersNodes;

  late final Encoding content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    final path = $id.jsonPointer;

    // All fields are optional
    if (json.containsKey('contentType')) {
      ValidationUtils.requireString(json['contentType'], ValidationUtils.buildPath(path, 'contentType'));
    }

    if (json.containsKey('headers')) {
      ValidationUtils.requireMap(json['headers'], ValidationUtils.buildPath(path, 'headers'));
    }

    if (json.containsKey('style')) {
      ValidationUtils.validateEnum(
        ValidationUtils.requireString(json['style'], ValidationUtils.buildPath(path, 'style')),
        ['form', 'spaceDelimited', 'pipeDelimited', 'deepObject'],
        ValidationUtils.buildPath(path, 'style'),
      );
    }

    if (json.containsKey('explode')) {
      ValidationUtils.requireBool(json['explode'], ValidationUtils.buildPath(path, 'explode'));
    }

    if (json.containsKey('allowReserved')) {
      ValidationUtils.requireBool(json['allowReserved'], ValidationUtils.buildPath(path, 'allowReserved'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'contentType', 'headers', 'style', 'explode', 'allowReserved'},
      path,
      'Encoding Object',
    );

    _structureValidated = true;
  }

  void _createChildNodes() {
    // Create Header nodes
    if (json.containsKey('headers')) {
      final headersMap = json['headers'] as Map<String, dynamic>;
      headersNodes = {};
      for (final entry in headersMap.entries) {
        final headerName = entry.key.toString();
        if (headerName.startsWith('x-')) continue;

        final headerJson = entry.value as Map<String, dynamic>;
        final headerNode = HeaderNode(
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'headers'), headerName),
          ),
          headerJson,
        );
        headersNodes![headerName] = headerNode;
        OpenApiGraph.i.addOpenApiNode(headerNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePointer, headerNode.$id.absolutePointer, 'headers/$headerName'),
        );
        headerNode.create();
      }
    }
  }

  void _createContent() {
    content = Encoding._(
      $node: this,
      contentType: json['contentType'],
      style: json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null,
      explode: json['explode'],
      allowReserved: json['allowReserved'] ?? false,
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// A single encoding definition applied to a single schema property.
class Encoding {
  final EncodingNode $node;
  final String? contentType;
  Map<String, Header>? get headers => $node.headersNodes?.map((k, v) => MapEntry(k, v.content));
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final Map<String, dynamic>? extensions;

  Encoding._({
    required this.$node,
    this.contentType,
    this.style,
    this.explode,
    this.allowReserved = false,
    this.extensions,
  });
}
