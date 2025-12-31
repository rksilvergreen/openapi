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
  Map<Edge, String> children = {};

  TreeNodeRecord({required this.node, required this.pointer});
}

abstract class Tree {
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
  TreeNode? get root => _nodes.values.firstWhereOrNull((record) => record.pointer == '/')?.node;
  UnmodifiableMapView<String, TreeNodeRecord?> get nodes => UnmodifiableMapView(_nodes);

  void setId([String? id]) {
    id ??= Uuid().v4();
    this.id = id;
  }

  @visibleForOverriding
  (TreeNode, List<(Edge, Object)>)? goodMethod(Object object) {
    if (object is Encoding) {

return 

      return (
        EncodingNode(
          contentType: object.contentType,
          style: object.style,
          explode: object.explode,
          allowReserved: object.allowReserved,
        ),
        [(const Edge(HeadersMap, 'headers'), object.headers!)],
      );
    }
    return null;
  }

  TreeNodeRecord _createNode({required String pointer, required Object object}) {
    // late final TreeNode node;
    final Map<Edge, TreeNodeRecord> children = {};

    void createChild(Edge edge, Object object) {
      children[edge] = _createNode(pointer: buildPointer([pointer, edge.key]), object: object);
    }

    final (node, edges) = goodMethod(object)!;
    for (final (edge, obj) in edges) {
      createChild(edge, obj);
    }

    // if (object is Encoding) {
    //   node = EncodingNode(
    //     contentType: object.contentType,
    //     style: object.style,
    //     explode: object.explode,
    //     allowReserved: object.allowReserved,
    //   );
    //   createChild(const Edge(HeadersMap, 'headers'), object.headers!);
    // }

    node._$tree = this;
    _nodes[node.$id] = TreeNodeRecord(node: node, pointer: pointer);
    for (final child in children.entries) {
      _nodes[node.$id]!.children[child.key] = child.value.node.$id;
      child.value.parent = node.$id;
    }
    return _nodes[node.$id]!;
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
      final childPointer = buildPointer([newPointer, child.key.key]);
      _snatchNodes(nodes[child.value]!.node, childPointer, collectedNodes: collectedNodes);
    }

    // Remove from parent's children map
    final parent = record.parent;
    if (parent != null) {
      _nodes[parent]!.children.removeWhere((key, value) => value == node.$id);
    }

    // Remove from nodes map
    _nodes.remove(node.$id);

    return collectedNodes;
  }

  Tree removeSubTree({required TreeNode node}) {
    final subTreeRoot = node;
    final pointer = '/';
    return Tree._(nodes: _snatchNodes(subTreeRoot, pointer));
  }

  Tree? replaceTree({required Tree subTree}) {
    Tree? oldTree;
    final root = this.root;
    if (root != null) {
      oldTree = removeSubTree(node: root);
    }
    final subTreeRoot = subTree.root!;
    final pointer = '/';
    final subTreeNodes = subTree._snatchNodes(subTreeRoot, pointer);
    for (final node in subTreeNodes.entries) {
      node.value.node._$tree = this;
    }
    _nodes.addAll(subTreeNodes);
    return oldTree;
  }

  Tree? addSubTree({required TreeNode parent, required String via, required Tree subTree}) {
    final parentRecord = nodes[parent.$id];
    if (parentRecord == null) {
      throw Exception(
        'Can\'t add subtree because parent [${parent.runtimeType}][${parent.$id}] is not found in tree [$id]',
      );
    }
    final subTreeRoot = subTree.root;
    if (subTreeRoot == null) {
      throw Exception('Can\'t add subtree because subTree has no root in tree [$id]');
    }
    final edge = Edge(subTreeRoot.runtimeType, via);
    if (!parentRecord.children.containsKey(edge)) {
      throw Exception(
        'Can\'t add subtree because edge [$via] with type [${subTreeRoot.runtimeType}] not found for parent [${parent.runtimeType}][${parent.$id}] in tree [$id]',
      );
    }

    Tree? oldTree;
    final child = nodes[parentRecord.children[edge]]?.node;
    if (child != null) {
      oldTree = removeSubTree(node: child);
    }

    final pointer = buildPointer([parentRecord.pointer, via]);
    final subTreeNodes = subTree._snatchNodes(subTreeRoot, pointer);
    for (final node in subTreeNodes.entries) {
      node.value.node._$tree = this;
    }
    _nodes.addAll(subTreeNodes);
    subTreeNodes[subTreeRoot.$id]!.parent = parent.$id;
    parentRecord.children[edge] = subTreeRoot.$id;

    return oldTree;
  }

  Tree? replaceSubTree({required TreeNode node, required Tree subTree}) {
    final nodeRecord = nodes[node.$id];
    if (nodeRecord == null) {
      throw Exception(
        'Can\'t replace subtree because node [${node.runtimeType}][${node.$id}] is not found in tree [$id]',
      );
    }
    final subTreeRoot = subTree.root;
    if (subTreeRoot == null) {
      throw Exception('Can\'t replace subtree because subTree has no root in tree [$id]');
    }
    if (node.runtimeType != subTreeRoot.runtimeType) {
      throw Exception(
        'Can\'t replace subtree because node [${node.runtimeType}][${node.$id}] has type [${node.runtimeType}] but subTree root has type [${subTreeRoot.runtimeType}] in tree [$id]',
      );
    }

    final pointer = nodeRecord.pointer;
    final parentId = nodeRecord.parent;
    final parentRecord = parentId != null ? nodes[parentId] : null;
    final edge = parentRecord?.children.entries.firstWhereOrNull((entry) => entry.value == node.$id)?.key;

    final oldTree = removeSubTree(node: node);

    final subTreeNodes = subTree._snatchNodes(subTreeRoot, pointer);
    for (final node in subTreeNodes.entries) {
      node.value.node._$tree = this;
    }
    _nodes.addAll(subTreeNodes);

    // Reconnect to parent if it exists
    subTreeNodes[subTreeRoot.$id]!.parent = parentId;
    if (parentRecord != null && edge != null) {
      parentRecord.children[edge] = subTreeRoot.$id;
    }

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
