import 'dart:collection';
import 'validation/validation_utils.dart';
import 'doc_node.dart';
import 'edge.dart';

abstract class MapDocNode<CHILD_NODE extends DocNode> extends DocNode with DocInternalNode, MapMixin<String, CHILD_NODE> {
  MapDocNode(super.json, super.document, super.jsonPointer);

  late final Map<String, CHILD_NODE> _childNodes;
  late final Map<String, dynamic>? extensions;

  @override
  CHILD_NODE? operator [](Object? key) {
    if (key is! String) return null;
    return _childNodes[key];
  }

  @override
  void operator []=(String key, CHILD_NODE value) {
    _childNodes[key] = value;
  }

  @override
  void clear() {
    _childNodes.clear();
  }

  @override
  CHILD_NODE? remove(Object? key) {
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
    createMapDocNode<CHILD_NODE>()!;
  }

  @override
  void createContent() {
    _childNodes = Map.fromIterable(
      $to.where((edge) => edge.to is CHILD_NODE),
      key: (edge) => (edge as Edge).via,
      value: (edge) => (edge as Edge).to as CHILD_NODE,
    );
    extensions = extractExtensions(json);
  }
}
