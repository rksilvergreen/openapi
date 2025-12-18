import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

abstract class XML {
  String? get name;
  String? get namespace;
  String? get prefix;
  bool get attribute;
  bool get wrapped;
  Map<String, dynamic>? get extensions;
}

class XMLNode extends OpenApiNode with LeafNode implements XML {
  XMLNode(Map<String, dynamic> json, String document, String jsonPointer) : super(NodeId(document, jsonPointer), json);

  late final String? name;
  late final String? namespace;
  late final String? prefix;
  late final bool attribute;
  late final bool wrapped;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // All fields are optional
    if (json.containsKey('name')) {
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPointer([jsonPointer, 'name']));
    }

    if (json.containsKey('namespace')) {
      ValidationUtils.requireString(json['namespace'], ValidationUtils.buildPointer([jsonPointer, 'namespace']));
    }

    if (json.containsKey('prefix')) {
      ValidationUtils.requireString(json['prefix'], ValidationUtils.buildPointer([jsonPointer, 'prefix']));
    }

    if (json.containsKey('attribute')) {
      ValidationUtils.requireBool(json['attribute'], ValidationUtils.buildPointer([jsonPointer, 'attribute']));
    }

    if (json.containsKey('wrapped')) {
      ValidationUtils.requireBool(json['wrapped'], ValidationUtils.buildPointer([jsonPointer, 'wrapped']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'name', 'namespace', 'prefix', 'attribute', 'wrapped'},
      jsonPointer,
      'XML Object',
    );
  }

  @override
  void createContent() {
    name = json['name'];
    namespace = json['namespace'];
    prefix = json['prefix'];
    attribute = json['attribute'] ?? false;
    wrapped = json['wrapped'] ?? false;
    extensions = extractExtensions(json);
  }
}
