import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../referencable.dart';
import 'enums.dart';
import 'schema/schema_node.dart';
import 'schema/effective_schema/effective_schema.dart';
import 'example.dart';
import 'media_type.dart';

class HeaderNode extends OpenApiNode with Referencable {
  HeaderNode._(super.$id, super.json);

  factory HeaderNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<HeaderNode>(json, document, jsonPointer, (nodeId, json) => HeaderNode._(nodeId, json));

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final SchemaNode? schemaNode;
  late final Map<String, ExampleNode>? examplesNodes;
  late final Map<String, MediaTypeNode>? contentNodes;

  late final Header content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    final path = $id.jsonPointer;

    // All fields are optional
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    if (json.containsKey('required')) {
      ValidationUtils.requireBool(json['required'], ValidationUtils.buildPath(path, 'required'));
    }

    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }

    if (json.containsKey('allowEmptyValue')) {
      ValidationUtils.requireBool(json['allowEmptyValue'], ValidationUtils.buildPath(path, 'allowEmptyValue'));
    }

    if (json.containsKey('style')) {
      ValidationUtils.validateEnum(
        ValidationUtils.requireString(json['style'], ValidationUtils.buildPath(path, 'style')),
        ['simple'],
        ValidationUtils.buildPath(path, 'style'),
      );
    }

    if (json.containsKey('explode')) {
      ValidationUtils.requireBool(json['explode'], ValidationUtils.buildPath(path, 'explode'));
    }

    if (json.containsKey('allowReserved')) {
      ValidationUtils.requireBool(json['allowReserved'], ValidationUtils.buildPath(path, 'allowReserved'));
    }

    if (json.containsKey('schema')) {
      ValidationUtils.requireMap(json['schema'], ValidationUtils.buildPath(path, 'schema'));
    }

    if (json.containsKey('examples')) {
      ValidationUtils.requireMap(json['examples'], ValidationUtils.buildPath(path, 'examples'));
    }

    if (json.containsKey('content')) {
      ValidationUtils.requireMap(json['content'], ValidationUtils.buildPath(path, 'content'));
    }

    // Validate mutual exclusivity: example and examples cannot both be present
    if (json.containsKey('example') && json.containsKey('examples')) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          path,
          'Header Object cannot have both "example" and "examples"',
          specReference: 'OpenAPI 3.0.0 - Header Object',
          severity: ValidationSeverity.critical,
        ),
      );
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {
        'description',
        'required',
        'deprecated',
        'allowEmptyValue',
        'style',
        'explode',
        'allowReserved',
        'schema',
        'example',
        'examples',
        'content',
      },
      path,
      'Header Object',
    );

    _structureValidated = true;
  }

  void _createChildNodes() {
    // Create Schema node (with RootEdge)
    if (json.containsKey('schema')) {
      final schemaJson = json['schema'] as Map<String, dynamic>;
      schemaNode = SchemaNode(schemaJson, $id.document, ValidationUtils.buildPath($id.jsonPointer, 'schema'));
      if (!OpenApiGraph.i.schemaNodes.containsKey(schemaNode!.$id.absolutePointer)) {
        OpenApiGraph.i.addSchemaNode(schemaNode!);
        OpenApiGraph.i.addSchemaStructuralEdge(RootEdge($id.absolutePointer, schemaNode!.$id.absolutePointer));
        schemaNode!.create();
      }
    }

    // Create Example nodes
    if (json.containsKey('examples')) {
      final examplesMap = json['examples'] as Map<String, dynamic>;
      examplesNodes = {};
      for (final entry in examplesMap.entries) {
        final exampleName = entry.key.toString();
        if (exampleName.startsWith('x-')) continue;

        final exampleJson = entry.value as Map<String, dynamic>;
        final exampleNode = ExampleNode(
          exampleJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'examples'), exampleName),
        );
        examplesNodes![exampleName] = exampleNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(exampleNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(exampleNode);
          OpenApiGraph.i.addOpenApiEdge(
            OpenApiEdge($id.absolutePointer, exampleNode.$id.absolutePointer, 'examples/$exampleName'),
          );
          exampleNode.create();
        }
      }
    }

    // Create Content nodes (MediaType)
    if (json.containsKey('content')) {
      final contentMap = json['content'] as Map<String, dynamic>;
      contentNodes = {};
      for (final entry in contentMap.entries) {
        final mediaType = entry.key.toString();
        final mediaTypeJson = entry.value as Map<String, dynamic>;
        final mediaTypeNode = MediaTypeNode(
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'content'), mediaType),
          ),
          mediaTypeJson,
        );
        contentNodes![mediaType] = mediaTypeNode;
        OpenApiGraph.i.addOpenApiNode(mediaTypeNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePointer, mediaTypeNode.$id.absolutePointer, 'content/$mediaType'),
        );
        mediaTypeNode.create();
      }
    }
  }

  void _createContent() {
    content = Header._(
      $node: this,
      description: json['description'],
      required_: json['required'],
      deprecated: json['deprecated'],
      allowEmptyValue: json['allowEmptyValue'],
      style: json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null,
      explode: json['explode'],
      allowReserved: json['allowReserved'],
      example: json['example'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Header Object follows the structure of the Parameter Object.
class Header {
  final HeaderNode $node;
  final String? description;
  final bool required_;
  final bool deprecated;
  final bool allowEmptyValue;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  EffectiveSchema? get schema => $node.schemaNode?.effective;
  final dynamic example;
  Map<String, Example>? get examples => $node.examplesNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, MediaType>? get content => $node.contentNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Header._({
    required this.$node,
    this.description,
    this.required_ = false,
    this.deprecated = false,
    this.allowEmptyValue = false,
    this.style,
    this.explode,
    this.allowReserved = false,
    this.example,
    this.extensions,
  });
}
