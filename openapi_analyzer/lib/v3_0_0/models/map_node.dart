import 'dart:collection';

import 'openapi_graph.dart';
import 'node_creation_helpers.dart';
import '../validation/validation_utils.dart';

abstract class MapNode<CHILD_NODE extends OpenApiNode, MAP> extends OpenApiNode
    with InternalNode, MapMixin<String, MAP>
    implements Map<String, MAP> {
  MapNode(Map<String, dynamic> json, String document, String jsonPointer) : super(NodeId(document, jsonPointer), json);

  late final Map<String, MAP> childNodes;
  late final Map<String, dynamic>? extensions;

  @override
  MAP? operator [](Object? key) {
    if (key is! String) return null;
    return childNodes[key];
  }

  @override
  void operator []=(String key, MAP value) {
    childNodes[key] = value;
  }

  @override
  void clear() {
    childNodes.clear();
  }

  @override
  MAP? remove(Object? key) {
    if (key is! String) return null;
    return childNodes.remove(key);
  }

  @override
  Iterable<String> get keys => childNodes.keys;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    for (final key in json.keys) {
      ValidationUtils.requireMap(json[key], ValidationUtils.buildPointer([jsonPointer, key]));
    }
  }

  @override
  void createChildNodes() {
    createMapNode2<CHILD_NODE>()!;
  }

  @override
  void createContent() {
    childNodes = Map.fromIterable(
      $to.where((edge) => edge.to is MAP),
      key: (edge) => (edge as OpenApiEdge).via,
      value: (edge) => (edge as OpenApiEdge).to as MAP,
    );
    extensions = extractExtensions(json);
  }
}
