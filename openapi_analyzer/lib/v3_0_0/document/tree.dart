part of 'document.dart';

class TreeNodeRecord {
  final TreeNode node;
  String pointer;
  String? parent;
  Map<String, String> children = {};

  TreeNodeRecord({required this.node, required this.pointer});
}

class Tree {
  late String id;
  Document? _document;
  Map<String, TreeNodeRecord> _nodes = {};

  Tree._({String? id, required Map<String, TreeNodeRecord> nodes}) {
    setId(id);
    for (final node in nodes.entries) {
      node.value.node._$tree = this;
    }
    _nodes = nodes;
  }

  Tree.fromObject({String? id, required Object root}) {
    setId(id);
    _createNode(pointer: '/', object: root);
  }

  Document? get document => _document;
  TreeNode? get root => _nodes['/'];
  UnmodifiableMapView<String, TreeNodeRecord?> get nodes => UnmodifiableMapView(_nodes);

  void setId([String? id]) {
    id ??= Uuid().v4();
    this.id = id;
  }

  TreeNode? getNode(String pointer) => nodes[pointer];

  TreeNodeRecord _createNode({required String pointer, required Object? object}) {
    late final TreeNode node;
    final Map<String, TreeNodeRecord> children = {};

    void createChild(String key, Object? object) {
      children[key] = _createNode(pointer: buildPointer([pointer, key]), object: object);
    }

    if (object is Encoding) {
      node = EncodingNode(
        contentType: object.contentType,
        style: object.style,
        explode: object.explode,
        allowReserved: object.allowReserved,
      );
      createChild('headers', object.headers!);
    }

    node._$tree = this;
    nodes[node.$id] = TreeNodeRecord(node: node, pointer: pointer);
    for (final child in children.entries) {
      nodes[node.$id]!.children[child.key] = child.value.node.$id;
      child.value.parent = node.$id;
    }
    return nodes[node.$id]!;
  }

  Map<String, TreeNodeRecord> _getNodes(TreeNode node, {Map<String, TreeNodeRecord>? nodes}) {
    nodes ??= {};
    final record = this.nodes[node.$id];
    if (record == null) {
      throw Exception('Node [${node.runtimeType}][${node.$id}] not found in tree [$id]');
    }
    nodes[node.$id] = record;
    final children = record.children;
    for (final child in children.entries) {
      _getNodes(nodes[child.value]!.node, nodes: nodes);
    }
    return nodes;
  }

  void _removeNodes(TreeNode node) {
    final record = this.nodes[node.$id];
    if (record == null) {
      throw Exception('Node [${node.runtimeType}][${node.$id}] not found in tree [$id]');
    }
    final parent = record.parent;
    if (parent != null) {
      nodes[parent]!.children.removeWhere((key, value) => value == node.$id);
    }
    final children = record.children;
    for (final child in children.entries) {
      _removeNodes(nodes[child.value]!.node);
    }
    nodes.remove(node.$id);
  }

  void _setPointer(TreeNode node, String pointer) {
    final record = nodes[node.$id];
    if (record == null) {
      throw Exception('Node [${node.runtimeType}][${node.$id}] not found in tree [$id]');
    }
    record.pointer = pointer;
    final children = record.children;
    for (final child in children.entries) {
      _setPointer(nodes[child.value]!.node, buildPointer([pointer, child.key]));
    }
  }

  Tree removeSubTree({required TreeNode node}) {
    final nodes = _getNodes(node);
    _setPointer(node, '/');
    _removeNodes(node);
    return Tree._(nodes: nodes);
  }

  Tree? replaceTree({required Tree subTree}) {
    Tree? oldTree;
    if (root != null) {
      oldTree = removeSubTree(node: root!);
    }
    final pointer = '/';
    final subTreeRoot = subTree.root!;
    final subTreeNodes = subTree._getNodes(subTreeRoot);
    subTree._setPointer(subTreeRoot, pointer);
    subTree._removeNodes(subTreeRoot);
    for (final node in subTreeNodes.entries) {
      node.value.node._$tree = this;
    }
    nodes.addAll(subTreeNodes);
    return oldTree;
  }

  Tree? addSubTree({required TreeNode parent, required String via, required Tree subTree}) {
    final parentRecord = nodes[parent.$id];
    if (parentRecord == null) {
      throw Exception(
        'Can\'t add subtree because parent [${parent.runtimeType}][${parent.$id}] is not found in tree [$id]',
      );
    }
    Tree? oldTree;
    final child = nodes[parentRecord.children[via]]?.node;
    if (child != null) {
      oldTree = removeSubTree(node: child);
    }
    final pointer = buildPointer([parentRecord.pointer, via]);
    final subTreeRoot = subTree.root!;
    final subTreeNodes = subTree._getNodes(subTreeRoot);
    subTree._setPointer(subTreeRoot, pointer);
    subTree._removeNodes(subTreeRoot);
    for (final node in subTreeNodes.entries) {
      node.value.node._$tree = this;
    }
    nodes.addAll(subTreeNodes);

    subTreeNodes[subTreeRoot.$id]!.parent = parent.$id;
    nodes[parent.$id]!.children[via] = subTreeRoot.$id;

    return oldTree;
  }

  static String buildPointer(List<String> segments) {
    if (segments.isEmpty) {
      return '/';
    }

    // Filter out empty segments but keep '/'
    final filtered = segments.where((s) => s.isNotEmpty || s == '/').toList();
    if (filtered.isEmpty) {
      return '/';
    }

    // If first segment is empty or '/', start with '/'
    if (filtered.first.isEmpty || filtered.first == '/') {
      if (filtered.length == 1) {
        return '/';
      }
      return '/${filtered.skip(1).join('/')}';
    }

    return filtered.join('/');
  }
}
