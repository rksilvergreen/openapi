import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

abstract class ServerVariable {
  List<String>? get enum_;
  String get default_;
  String? get description;
  Map<String, dynamic>? get extensions;
}

class ServerVariableNode extends OpenApiNode with LeafNode {
  ServerVariableNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final List<String>? enum_;
  late final String default_;
  late final String? description;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate required: default (string)
    final defaultValue = ValidationUtils.requireField(json, 'default', jsonPointer);
    ValidationUtils.requireString(defaultValue, ValidationUtils.buildPointer([jsonPointer, 'default']));

    // Validate optional: enum (array of strings)
    if (json.containsKey('enum')) {
      final enumList = ValidationUtils.requireList(json['enum'], ValidationUtils.buildPointer([jsonPointer, 'enum']));
      for (var i = 0; i < enumList.length; i++) {
        ValidationUtils.requireString(enumList[i], ValidationUtils.buildPointer([jsonPointer, 'enum', '[$i]']));
      }
    }

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'enum', 'default', 'description'},
      jsonPointer,
      'Server Variable Object',
    );
  }

  @override
  void createContent() {
    enum_ = json['enum'];
    default_ = json['default'];
    description = json['description'];
    extensions = extractExtensions(json);
  }
}
