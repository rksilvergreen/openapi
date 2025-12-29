import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../validation_exception.dart';
import '../doc_node.dart';
import '../document/list_doc_node.dart';

class SecurityRequirementDocNode extends DocNode with DocLeafNode {
  SecurityRequirementDocNode(super.json);

  late final Map<String, List<String>> requirements;

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;

    _validateRequirements(jsonPointer);
  }

  void _validateRequirements(String jsonPointer) {
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

class SecurityRequirementsListDocNode extends ListDocNode<SecurityRequirementDocNode> {
  SecurityRequirementsListDocNode(super.json);
}
