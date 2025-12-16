import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import 'path_item.dart';

class PathsNode extends OpenApiNode {
  PathsNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, PathItemNode> pathItemNodes;

  late final Paths content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate keys are valid path patterns (start with / or are extension fields)
    for (final key in json.keys) {
      final keyStr = key.toString();
      
      // Skip extension fields
      if (keyStr.startsWith('x-')) {
        continue;
      }

      // Validate path starts with /
      if (!keyStr.startsWith('/')) {
        OpenApiGraph.i.validationContext.addException(OpenApiValidationException(
          ValidationUtils.buildPath(path, keyStr),
          'Path must start with "/"',
          specReference: 'OpenAPI 3.0.0 - Paths Object',
          severity: ValidationSeverity.critical,
        ));
      }

      // Validate value is object (will be PathItem or Reference)
      ValidationUtils.requireMap(json[key], ValidationUtils.buildPath(path, keyStr));
    }
  }
  void _createChildNodes() {
    pathItemNodes = {};
    
    for (final entry in json.entries) {
      final key = entry.key.toString();
      
      // Skip extension fields
      if (key.startsWith('x-')) {
        continue;
      }

      // Create PathItem node for each path
      final pathItemJson = entry.value as Map<String, dynamic>;
      final pathItemNode = PathItemNode(
        pathItemJson,
        $id.document,
        ValidationUtils.buildPath($id.jsonPointer, key),
      );
      pathItemNodes[key] = pathItemNode;
      if (!OpenApiGraph.i.openApiNodes.containsKey(pathItemNode.$id.absolutePointer)) {
        OpenApiGraph.i.addOpenApiNode(pathItemNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, pathItemNode.$id.absolutePointer, key));
        pathItemNode.create();
      }
    }
  }

  void _createContent() {
    content = Paths._($node: this, extensions: extractExtensions(json));
    _contentCreated = true;
  }
}

class Paths {
  final PathsNode $node;

  Map<String, PathItem> get paths => $node.pathItemNodes.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;
  Paths._({required this.$node, this.extensions});
}
