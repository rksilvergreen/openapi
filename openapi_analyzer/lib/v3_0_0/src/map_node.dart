import 'dart:collection';
import 'validation/validation_utils.dart';
import 'node.dart';
import 'edge.dart';

abstract class MapNode<CHILD_NODE extends Node, MAP> extends Node
    with InternalNode, MapMixin<String, MAP>
    implements Map<String, MAP> {
  MapNode(super.json, super.document, super.jsonPointer);

  late final Map<String, MAP> _childNodes;
  late final Map<String, dynamic>? extensions;

  @override
  MAP? operator [](Object? key) {
    if (key is! String) return null;
    return _childNodes[key];
  }

  @override
  void operator []=(String key, MAP value) {
    _childNodes[key] = value;
  }

  @override
  void clear() {
    _childNodes.clear();
  }

  @override
  MAP? remove(Object? key) {
    if (key is! String) return null;
    return _childNodes.remove(key);
  }

  @override
  Iterable<String> get keys => _childNodes.keys;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    for (final key in json.keys) {
      ValidationUtils.requireMap(json[key], ValidationUtils.buildPointer([jsonPointer, key]));
    }
  }

  @override
  void createChildNodes() {
    createMapNode<CHILD_NODE>()!;
  }

  @override
  void createContent() {
    _childNodes = Map.fromIterable(
      $to.where((edge) => edge.to is MAP),
      key: (edge) => (edge as Edge).via,
      value: (edge) => (edge as Edge).to as MAP,
    );
    extensions = extractExtensions(json);
  }
}
