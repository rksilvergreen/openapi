import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import 'enums.dart';
import 'schema/schema_node.dart';
import 'schema/effective_schema/effective_schema.dart';
import 'example.dart';
import 'media_type.dart';

class ParameterNode extends OpenApiNode {
  ParameterNode(super.$id, super.json);

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final SchemaNode? schemaNode;
  late final Map<String, ExampleNode>? examplesNodes;
  late final Map<String, MediaTypeNode>? contentNodes;

  late final Parameter content;

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate required: name (string)
    final name = ValidationUtils.requireField(json, 'name', path);
    ValidationUtils.requireString(name, ValidationUtils.buildPath(path, 'name'));

    // Validate required: in (enum: query, header, path, cookie)
    final inValue = ValidationUtils.requireField(json, 'in', path);
    ValidationUtils.requireString(inValue, ValidationUtils.buildPath(path, 'in'));
    ValidationUtils.validateEnum(inValue as String, ['query', 'header', 'path', 'cookie'], 
        ValidationUtils.buildPath(path, 'in'));

    // If in=path, required must be true
    if (inValue == 'path') {
      if (!json.containsKey('required') || json['required'] != true) {
        OpenApiGraph.i.validationContext.addException(OpenApiValidationException(
          ValidationUtils.buildPath(path, 'required'),
          'Parameter with in=path must have required=true',
          specReference: 'OpenAPI 3.0.0 - Parameter Object',
          severity: ValidationSeverity.critical,
        ));
      }
    }

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate optional: required (boolean)
    if (json.containsKey('required')) {
      ValidationUtils.requireBool(json['required'], ValidationUtils.buildPath(path, 'required'));
    }

    // Validate optional: deprecated (boolean)
    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }

    // Validate optional: allowEmptyValue (boolean)
    if (json.containsKey('allowEmptyValue')) {
      ValidationUtils.requireBool(json['allowEmptyValue'], ValidationUtils.buildPath(path, 'allowEmptyValue'));
    }

    // Validate optional: schema (object)
    if (json.containsKey('schema')) {
      ValidationUtils.requireMap(json['schema'], ValidationUtils.buildPath(path, 'schema'));
    }

    // Validate optional: style (string)
    if (json.containsKey('style')) {
      ValidationUtils.requireString(json['style'], ValidationUtils.buildPath(path, 'style'));
    }

    // Validate optional: explode (boolean)
    if (json.containsKey('explode')) {
      ValidationUtils.requireBool(json['explode'], ValidationUtils.buildPath(path, 'explode'));
    }

    // Validate optional: allowReserved (boolean)
    if (json.containsKey('allowReserved')) {
      ValidationUtils.requireBool(json['allowReserved'], ValidationUtils.buildPath(path, 'allowReserved'));
    }

    // Validate optional: examples (object)
    if (json.containsKey('examples')) {
      ValidationUtils.requireMap(json['examples'], ValidationUtils.buildPath(path, 'examples'));
    }

    // Validate optional: content (object)
    if (json.containsKey('content')) {
      ValidationUtils.requireMap(json['content'], ValidationUtils.buildPath(path, 'content'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'name', 'in', 'description', 'required', 'deprecated', 'allowEmptyValue', 
       'style', 'explode', 'allowReserved', 'schema', 'example', 'examples', 'content'},
      path,
      'Parameter Object',
    );
  }
  void _createChildNodes() {
    // Create Schema node (with RootEdge)
    if (json.containsKey('schema')) {
      final schemaJson = json['schema'] as Map<String, dynamic>;
      schemaNode = SchemaNode(
        NodeId($id.document, ValidationUtils.buildPath($id.jsonPointer, 'schema')),
        schemaJson
      );
      OpenApiGraph.i.addSchemaNode(schemaNode!);
      OpenApiGraph.i.addSchemaStructuralEdge(RootEdge($id.absolutePointer, schemaNode!.$id.absolutePointer));
      schemaNode!.create();
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
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'examples'), exampleName)),
          exampleJson,
        );
        examplesNodes![exampleName] = exampleNode;
        OpenApiGraph.i.addOpenApiNode(exampleNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, exampleNode.$id.absolutePointer, 'examples/$exampleName'));
        exampleNode.create();
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
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'content'), mediaType)),
          mediaTypeJson,
        );
        contentNodes![mediaType] = mediaTypeNode;
        OpenApiGraph.i.addOpenApiNode(mediaTypeNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, mediaTypeNode.$id.absolutePointer, 'content/$mediaType'));
        mediaTypeNode.create();
      }
    }
  }

  void _createContent() {
    content = Parameter._(
      $node: this,
      name: json['name'],
      in_: ParameterLocation.values.firstWhere((e) => e.value == json['in']),
      description: json['description'],
      required_: json['required'],
      deprecated: json['deprecated'],
      allowEmptyValue: json['allowEmptyValue'],
      style: json['style'] != null
          ? ParameterStyle.values.firstWhere((e) => e.value == json['style'])
          : null,
      explode: json['explode'],
      allowReserved: json['allowReserved'],
      example: json['example'],
      content: json['content'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Describes a single operation parameter.
class Parameter {
  final ParameterNode $node;
  final String name;
  final ParameterLocation in_;
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
  final Map<String, MediaType>? content;
  final Map<String, dynamic>? extensions;

  Parameter._({
    required this.$node,
    required this.name,
    required this.in_,
    this.description,
    this.required_ = false,
    this.deprecated = false,
    this.allowEmptyValue = false,
    this.style,
    this.explode,
    this.allowReserved = false,
    this.example,
    this.content,
    this.extensions,
  });
}
