part of 'document.dart';

class Tree {
  late String id;
  Document? _document;
  Map<String, TreeNode?> _nodes = {};
  Map<String, List<String>> _children = {};
  Map<String, String> _parents = {};

  Tree({String? id, Object? root}) {
    setId(id);
    if (root != null) {
      setRoot(root);
    }
  }

  Document? get document => _document;
  TreeNode? get root => _nodes['/'];
  UnmodifiableMapView<String, TreeNode?> get nodes => UnmodifiableMapView(_nodes);
  UnmodifiableMapView<String, List<String>> get children => UnmodifiableMapView(_children);
  UnmodifiableMapView<String, String> get parents => UnmodifiableMapView(_parents);

  void setId([String? id]) {
    id ??= Uuid().v4();
    this.id = id;
  }

  TreeNode? getNode(String pointer) => nodes[pointer];

  void setRoot(Object object) {
    if (root != null) {
      throw Exception('Tree [${this.id}] already has a root');
    }
    _addNode(parent: null, object: object, via: null);
  }

  void _addNode({TreeNode? parent, required Object? object, String? via}) {
    late final String pointer;

    if (parent == null && via == null) {
      pointer = '/';
    } else if (parent != null && via != null) {
      final parentPointer = parent._$id.pointer;
      pointer = buildPointer([parentPointer, via]);
      children[parentPointer]!.add(pointer);
      parents[pointer] = parentPointer;
    }

    final id = TreeNodeId(this, pointer);
    late final TreeNode? node;

    if (object == null) {
      node = null;
    } else if (object is Encoding) {
      node = EncodingNode(
        $id: id,
        contentType: object.contentType,
        style: object.style,
        explode: object.explode,
        allowReserved: object.allowReserved,
      );
      _addNode(parent: node, object: object.headers!, via: 'headers');
    }

    nodes[pointer] = node;
  }

  void _removeNode(TreeNode node) {
    final pointer = node._$id.pointer;
    nodes.remove(pointer);
    if (parents.containsKey(pointer)) {
      final parentPointer = parents[pointer]!;
      children[parentPointer]!.remove(pointer);
      parents.remove(pointer);
    }
    if (children.containsKey(pointer)) {
      for (final childPointer in children[pointer]!.keys) {
        children[parentPointer]!.remove(childPointer);
        parents.remove(childPointer);
      }
      children.remove(pointer);
    }
  }

  void addSubTree({required Tree subtree, required TreeNode parent, required String via}) {
    if (!_verifyNode(parent)) {
      throw Exception('Can\'t add subtree because parent [${parent._$id?.pointer}] is not found in tree [_$id]');
    }
    if (subtree.root == null) {
      throw Exception('Can\'t add subtree because it has no root');
    }

    final subtreeRoot = subtree.root!;
    final rootJsonPointer = buildPointer([parent._$id!.pointer, via]);

    // Update all node IDs in the subtree to point to this tree and update pointers
    _updateNodeIds(subtreeRoot, this, rootJsonPointer);

    // Add all edges from the subtree to this tree
    edges.addAll(subtree.edges);

    // Create edge from parent to subtree root
    final edge = Edge(parent, subtreeRoot, via);
    edges.add(edge);
    parent.$children.add(edge);
    subtreeRoot.$parent = edge;
  }

  Tree removeSubTree({required TreeNode subTreeRoot}) {
    if (!_verifyNode(subTreeRoot)) {
      throw Exception('Can\'t remove node [${subTreeRoot._$id?.pointer}] because it is not found in tree [_$id]');
    }

    // Remove the parent edge if it exists
    if (subTreeRoot.$parent != null) {
      final parent = subTreeRoot.$parent!.parent;
      parent.$children.remove(subTreeRoot.$parent);
      edges.remove(subTreeRoot.$parent);
      subTreeRoot.$parent = null;
    }

    // If the removed node was the root, clear the root
    if (root == subTreeRoot) {
      root = null;
    }

    // Collect all nodes and edges in the subtree and remove them from current tree
    final subtreeNodes = <TreeNode>{};
    final subtreeEdges = <Edge>[];

    void tearOffRecursive(TreeNode n) {
      subtreeNodes.add(n);
      // Remove node from current tree's nodes map
      nodes.remove(n._$id!.pointer);
      for (final edge in n.$children) {
        subtreeEdges.add(edge);
        // Remove edge from current tree's edges list
        edges.remove(edge);
        tearOffRecursive(edge.child);
      }
    }

    tearOffRecursive(subTreeRoot);

    // Create a new tree with the removed node as root
    final newTree = Tree(root: subTreeRoot);

    // Update all node IDs to reflect the new tree and new json pointers
    _updateNodeIds(subTreeRoot, newTree, '/');

    // Add all edges to the new tree
    newTree.edges.addAll(subtreeEdges);

    return newTree;
  }

  void _updateNodeIds(TreeNode node, Tree targetTree, String pointer) {
    node.setId(targetTree, pointer);
    targetTree.nodes[pointer] = node;
    for (final edge in node.$children) {
      final childPointer = buildPointer([pointer, edge.via]);
      _updateNodeIds(edge.child, targetTree, childPointer);
    }
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
