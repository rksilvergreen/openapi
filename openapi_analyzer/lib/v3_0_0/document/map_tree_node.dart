part of 'document.dart';

abstract class MapTreeNode<CHILD_NODE extends TreeNode> extends TreeNode with MapMixin<String, CHILD_NODE> {
  Map<String, CHILD_NODE> get _map => $children?.cast<String, CHILD_NODE>() ?? {};

  @override
  CHILD_NODE? operator [](Object? key) {
    if (key is! String) return null;
    return _map[key];
  }

  @override
  void operator []=(String key, CHILD_NODE value) => throw UnsupportedError('Unmodifiable map');

  @override
  void clear() => throw UnsupportedError('Unmodifiable map');

  @override
  CHILD_NODE? remove(Object? key) => throw UnsupportedError('Unmodifiable map');

  @override
  Iterable<String> get keys => _map.keys;

  @override
  Map<String, CHILD_NODE>? get $children =>
      $tree?.nodes[$id]?.children.map((k, v) => MapEntry(k.key, $tree!.nodes[v]!.node as CHILD_NODE));
}
