part of 'document.dart';

abstract class MapTreeNode<CHILD_NODE extends TreeNode> extends TreeNode with MapMixin<String, CHILD_NODE> {
  late final Map<String, CHILD_NODE> _childNodes;

  MapTreeNode(Map<String, CHILD_NODE> childNodes) : _childNodes = childNodes;

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
}
