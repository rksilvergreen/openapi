import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class ServerVariableNode extends OpenApiNode {
  ServerVariableNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final ServerVariable content;

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.relativePath;

    // Validate required: default (string)
    final defaultValue = ValidationUtils.requireField(json, 'default', path);
    ValidationUtils.requireString(defaultValue, ValidationUtils.buildPath(path, 'default'));

    // Validate optional: enum (array of strings)
    if (json.containsKey('enum')) {
      final enumList = ValidationUtils.requireList(json['enum'], ValidationUtils.buildPath(path, 'enum'));
      for (var i = 0; i < enumList.length; i++) {
        ValidationUtils.requireString(enumList[i], ValidationUtils.buildPath(ValidationUtils.buildPath(path, 'enum'), '[$i]'));
      }
    }

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'enum', 'default', 'description'},
      path,
      'Server Variable Object',
    );
  }
  void _createContent() {
    content = ServerVariable._(
      $node: this,
      enum_: json['enum'],
      default_: json['default'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
  }
}

/// Server Variable for server URL template substitution.
class ServerVariable {
  final ServerVariableNode $node;
  final List<String>? enum_;
  final String default_;
  final String? description;
  final Map<String, dynamic>? extensions;

  ServerVariable._({
    required this.$node,
    required this.enum_,
    required this.default_,
    this.description,
    this.extensions,
  });
}
