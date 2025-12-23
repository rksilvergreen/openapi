import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import 'path_item.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class PathsMap implements MapBase<String, PathItem> {
  Map<String, dynamic>? get extensions;
}

class PathsMapNode extends MapNode<PathItemNode, PathItem> implements PathsMap {
  PathsMapNode(super.json, super.document, super.jsonPointer);

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    _validateFormat(jsonPointer);
    super.validateStructure();
  }

  void _validateFormat(String jsonPointer) {
    for (final key in json.keys) {
      final keyStr = key.toString();
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
    }
  }
}

// abstract class Paths {
//   Map<String, PathItem> get paths;
//   Map<String, dynamic>? get extensions;
// }

// class PathsNode extends Node with InternalNode implements Paths {
//   PathsNode(Map<String, dynamic> json, String document, String jsonPointer)
//     : super(NodeId(document, jsonPointer), json);

//   late final Map<String, PathItem> paths;
//   late final Map<String, dynamic>? extensions;

//   @override
//   void validateStructure() {
//     final jsonPointer = $id.jsonPointer;

//     // Validate keys are valid path patterns (start with / or are extension fields)
//     for (final key in json.keys) {
//       final keyStr = key.toString();

//       // Validate path starts with /
//       if (!keyStr.startsWith('/')) {
//         OpenApiGraph.i.validationContext.addException(
//           OpenApiValidationException(
//             ValidationUtils.buildPointer([jsonPointer, keyStr]),
//             'Path must start with "/"',
//             specReference: 'OpenAPI 3.0.0 - Paths Object',
//             severity: ValidationSeverity.critical,
//           ),
//         );
//       }

//       // Validate value is object (will be PathItem or Reference)
//       ValidationUtils.requireMap(json[key], ValidationUtils.buildPointer([jsonPointer, keyStr]));
//     }
//   }

//   @override
//   void createChildNodes() {
//     createMapNode2<PathItemNode>(factory: (json, document, jsonPointer) => PathItemNode(json, document, jsonPointer))!;
//   }

//   @override
//   void createContent() {
//     paths = Map.fromIterable(
//       $to.where((edge) => edge.to is PathItemNode),
//       key: (edge) => (edge as OpenApiEdge).via,
//       value: (edge) => (edge as OpenApiEdge).to as PathItemNode,
//     );
//     extensions = extractExtensions(json);
//   }
// }
