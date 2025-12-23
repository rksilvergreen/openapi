import '../validation/validation_utils.dart';
import '../node.dart';
import 'package:openapi_analyzer/v3_0_0/objects/server.dart';

class ServerVariableNode extends Node with LeafNode implements ServerVariable {
  ServerVariableNode(super.json, super.document, super.jsonPointer);

  late final List<String>? enum_;
  late final String default_;
  late final String? description;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateDefault(jsonPointer);
    _validateEnum(jsonPointer);
    _validateDescription(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateDefault(String jsonPointer) {
    final defaultValue = ValidationUtils.requireField(json, 'default', jsonPointer);
    ValidationUtils.requireString(defaultValue, ValidationUtils.buildPointer([jsonPointer, 'default']));
  }

  void _validateEnum(String jsonPointer) {
    if (json.containsKey('enum')) {
      final enumList = ValidationUtils.requireList(json['enum'], ValidationUtils.buildPointer([jsonPointer, 'enum']));
      for (var i = 0; i < enumList.length; i++) {
        ValidationUtils.requireString(enumList[i], ValidationUtils.buildPointer([jsonPointer, 'enum', '[$i]']));
      }
    }
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
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
