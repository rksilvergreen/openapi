part of 'document.dart';

abstract class MapTreeNode<CHILD_NODE extends TreeNode> extends TreeNode with MapMixin<String, CHILD_NODE> {
  late final Map<String, CHILD_NODE> _nodes;

  MapTreeNode(this._nodes);

  @override
  CHILD_NODE? operator [](Object? key) {
    if (key is! String) return null;
    return _nodes[key];
  }

  @override
  void operator []=(String key, CHILD_NODE value) {
    _nodes[key] = value;
  }

  @override
  void clear() {
    _nodes.clear();
  }

  @override
  CHILD_NODE? remove(Object? key) {
    if (key is! String) return null;
    return _nodes.remove(key);
  }

  @override
  Iterable<String> get keys => _nodes.keys;
}
