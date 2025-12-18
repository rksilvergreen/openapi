import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import 'paths_map.dart';
import '../node_creation_helpers.dart';

abstract class Callback {
  PathsMap get expressions;
  Map<String, dynamic>? get extensions;
}

class CallbackNode extends OpenApiNode with InternalNode, Referencable implements Callback {
  CallbackNode(super.json, super.document, super.jsonPointer);

  late final PathsMapNode expressions;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    _validateExpressions(jsonPointer);
  }

  void _validateExpressions(String jsonPointer) {
    for (final key in json.keys) {
      final keyStr = key.toString();
      ValidationUtils.requireMap(json[key], ValidationUtils.buildPointer([jsonPointer, keyStr]));
    }
  }

  @override
  void createChildNodes() {
    createNode<PathsMapNode>(jsonKey: 'expressions', required: true);
  }

  @override
  void createContent() {
    expressions = $to.to<PathsMapNode>('expressions')!;
    extensions = extractExtensions(json);
  }
}
