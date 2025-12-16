import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';

class SecurityRequirementNode extends OpenApiNode {
  SecurityRequirementNode(Map<String, dynamic> json, String document, String jsonPointer)
      : super(NodeId(document, jsonPointer), json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final SecurityRequirement content;

  void create() {
    _validateStructure();
    _createContent();
  }

  void _validateStructure() {
    _structureValidated = true;
    final jsonPointer = $id.jsonPointer;

    // Validate structure: map of string to array of strings
    for (final entry in json.entries) {
      final key = entry.key.toString();
      if (entry.value is List) {
        final list = entry.value as List;
        for (var i = 0; i < list.length; i++) {
          ValidationUtils.requireString(list[i], ValidationUtils.buildPath(ValidationUtils.buildPath(jsonPointer, key), '[$i]'));
        }
      } else if (entry.value != null) {
        OpenApiGraph.i.validationContext.addException(OpenApiValidationException(
          ValidationUtils.buildPath(jsonPointer, key),
          'Security Requirement value must be an array of strings',
          specReference: 'OpenAPI 3.0.0 - Security Requirement Object',
          severity: ValidationSeverity.critical,
        ));
      }
    }
  }
  void _createContent() {
    final requirements = <String, List<String>>{};
    for (final entry in json.entries) {
      final key = entry.key.toString();
      if (entry.value is List) {
        requirements[key] = (entry.value as List).map((e) => e.toString()).toList();
      } else {
        requirements[key] = [];
      }
    }
    content = SecurityRequirement._($node: this, requirements: requirements);
  }
}

/// Lists the required security schemes to execute an operation.
class SecurityRequirement {
  final SecurityRequirementNode $node;
  final Map<String, List<String>> requirements;

  SecurityRequirement._({required this.$node, required this.requirements});
}
