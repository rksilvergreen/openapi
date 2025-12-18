import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';

abstract class SecurityRequirement {
  Map<String, List<String>> get requirements;
}

class SecurityRequirementNode extends OpenApiNode with LeafNode implements SecurityRequirement {
  SecurityRequirementNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final Map<String, List<String>> requirements;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate structure: map of string to array of strings
    for (final entry in json.entries) {
      final key = entry.key.toString();
      if (entry.value is List) {
        final list = entry.value as List;
        for (var i = 0; i < list.length; i++) {
          ValidationUtils.requireString(list[i], ValidationUtils.buildPointer([jsonPointer, key, '[$i]']));
        }
      } else if (entry.value != null) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([jsonPointer, key]),
            'Security Requirement value must be an array of strings',
            specReference: 'OpenAPI 3.0.0 - Security Requirement Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
  }

  @override
  void createContent() {
    requirements = json['requirements'];
  }
}
