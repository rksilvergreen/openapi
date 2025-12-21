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

class XMLNode extends Node with LeafNode implements XML {
  XMLNode(super.json, super.document, super.jsonPointer);

  late final String? name;
  late final String? namespace;
  late final String? prefix;
  late final bool attribute;
  late final bool wrapped;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateName(jsonPointer);
    _validateNamespace(jsonPointer);
    _validatePrefix(jsonPointer);
    _validateAttribute(jsonPointer);
    _validateWrapped(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateName(String jsonPointer) {
    if (json.containsKey('name')) {
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPointer([jsonPointer, 'name']));
    }
  }

  void _validateNamespace(String jsonPointer) {
    if (json.containsKey('namespace')) {
      ValidationUtils.requireString(json['namespace'], ValidationUtils.buildPointer([jsonPointer, 'namespace']));
    }
  }

  void _validatePrefix(String jsonPointer) {
    if (json.containsKey('prefix')) {
      ValidationUtils.requireString(json['prefix'], ValidationUtils.buildPointer([jsonPointer, 'prefix']));
    }
  }

  void _validateAttribute(String jsonPointer) {
    if (json.containsKey('attribute')) {
      ValidationUtils.requireBool(json['attribute'], ValidationUtils.buildPointer([jsonPointer, 'attribute']));
    }
  }

  void _validateWrapped(String jsonPointer) {
    if (json.containsKey('wrapped')) {
      ValidationUtils.requireBool(json['wrapped'], ValidationUtils.buildPointer([jsonPointer, 'wrapped']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
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
