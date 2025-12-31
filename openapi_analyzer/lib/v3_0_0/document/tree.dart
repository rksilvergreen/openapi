part of 'document.dart';

class Edge {
  final Type type;
  final String key;

  const Edge(this.type, this.key);

  int get hashCode => Object.hash(type, key);
  bool operator ==(Object other) => identical(this, other) || other is Edge && type == other.type && key == other.key;
}

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

  Map<String, TreeNodeRecord> _snatchNodes(
    TreeNode node,
    String newPointer, {
    Map<String, TreeNodeRecord>? collectedNodes,
  }) {
    collectedNodes ??= {};

    // Get the record
    final record = nodes[node.$id];
    if (record == null) {
      throw Exception('Node [${node.runtimeType}][${node.$id}] not found in tree [$id]');
    }

    // Collect the node
    collectedNodes[node.$id] = record;

    // Set the new pointer for this node
    record.pointer = newPointer;

    // Process children recursively (get, set pointer, remove)
    final children = record.children;
    for (final child in children.entries) {
      final childPointer = buildPointer([newPointer, child.key]);
      _snatchNodes(nodes[child.value]!.node, childPointer, collectedNodes: collectedNodes);
    }

    // Remove from parent's children map
    final parent = record.parent;
    if (parent != null) {
      nodes[parent]!.children.removeWhere((key, value) => value == node.$id);
    }

    // Remove from nodes map
    nodes.remove(node.$id);

    return collectedNodes;
  }

  Tree removeSubTree({required TreeNode node}) {
    final subTreeRoot = node;
    final pointer = '/';
    return Tree._(nodes: _snatchNodes(subTreeRoot, pointer));
  }

  Tree? replaceTree({required Tree subTree}) {
    Tree? oldTree;
    if (root != null) {
      oldTree = removeSubTree(node: root!);
    }
    final subTreeRoot = subTree.root!;
    final pointer = '/';
    final subTreeNodes = subTree._snatchNodes(subTreeRoot, pointer);
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
    final subTreeRoot = subTree.root!;
    final pointer = buildPointer([parentRecord.pointer, via]);
    final subTreeNodes = subTree._snatchNodes(subTreeRoot, pointer);
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
