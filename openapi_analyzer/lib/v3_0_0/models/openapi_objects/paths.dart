import '../openapi_graph.dart';
import '../node_creation_helpers.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import 'path_item.dart';

class PathsNode extends OpenApiNode with InternalNode {
  PathsNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final Map<String, PathItemNode> pathItemNodes;

  late final Paths content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate keys are valid path patterns (start with / or are extension fields)
    for (final key in json.keys) {
      final keyStr = key.toString();

      // Validate path starts with /
      if (!keyStr.startsWith('/')) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([jsonPointer, keyStr]),
            'Path must start with "/"',
            specReference: 'OpenAPI 3.0.0 - Paths Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }

      // Validate value is object (will be PathItem or Reference)
      ValidationUtils.requireMap(json[key], ValidationUtils.buildPointer([jsonPointer, keyStr]));
    }
  }

  @override
  void createChildNodes() {
    pathItemNodes = createMapNode2<PathItemNode>(
      factory: (json, document, jsonPointer) => PathItemNode(json, document, jsonPointer),
    )!;
  }

  @override
  void createContent() {
    content = Paths._($node: this, extensions: extractExtensions(json));
  }
}

class Paths {
  final PathsNode $node;

  Map<String, PathItem> get paths => $node.pathItemNodes.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;
  Paths._({required this.$node, this.extensions});
}
