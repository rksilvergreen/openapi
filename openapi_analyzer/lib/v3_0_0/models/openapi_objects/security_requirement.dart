import '../openapi_graph.dart';

class SecurityRequirementNode extends OpenApiNode {
  SecurityRequirementNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final SecurityRequirement content;

  void _validateStructure() {}
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
