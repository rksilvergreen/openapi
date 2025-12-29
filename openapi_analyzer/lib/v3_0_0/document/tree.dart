part of 'document.dart';

class Tree {
  late String id;
  Document? document;
  TreeNode? root;

  Tree({String? id, this.root}) {
    setId(id);
    if (root != null) {
      addNode(node: root!);
    }
  }

  Map<String, TreeNode> nodes = {};
  List<Edge> edges = [];

  void setId([String? id]) {
    id ??= Uuid().v4();
    this.id = id;
  }

  TreeNode? getNode(String jsonPointer) => nodes[jsonPointer];

  bool verifyNode(TreeNode node) {
    if (node.$id != null && node.$id!.document == id) {
      final existingNode = getNode(node.$id!.jsonPointer);
      if (existingNode != null) {
        return true;
      }
    }
    return false;
  }

  void addNode({TreeNode? parent, required TreeNode node, String? via}) {
    if ((parent == null) != (via == null)) {
      throw Exception(
        'addNode: parent and via must be both null or both not null. parent: ${parent != null}, via: ${via != null}',
      );
    }
    if (parent == null && via == null) {
      _setRoot(node);
    }
    else {
      _addNode(parent: parent!, node: node, via: via!);
    }
    if (node is Encoding) {
      addNode(parent: node, node: node.headers, via: 'headers');
    }
    if (node is HeadersMap) {
      for (final entry in node.entries) {
        addNode(parent: node, node: entry.value, via: entry.key);
      }
    }
  }

  void _setRoot(TreeNode root) {
    final jsonPointer = '/';
    root.setId(this, jsonPointer);
    nodes[jsonPointer] = root;
  }

  void _addNode({required TreeNode parent, required TreeNode node, required String via}) {
    if (!verifyNode(parent)) {
      throw Exception(
        'Can\'t add node [${node.runtimeType}] [${node.$id?.jsonPointer}] because parent [${parent.runtimeType}] [${parent.$id?.jsonPointer}] is not found in tree [$id]',
      );
    }
    if (verifyNode(node)) {
      throw Exception(
        'Can\'t add node [${node.runtimeType}] [${node.$id?.jsonPointer}] because it already exists in tree [${node.$id?.tree.id}]',
      );
    }
    final jsonPointer = buildPointer([parent.$id!.jsonPointer, via]);
    node.setId(this, jsonPointer);
    nodes[jsonPointer] = node;
    final edge = Edge(parent, node, via);
    edges.add(edge);
    parent.$children.add(edge);
    node.$parent = edge;
  }

  TreeNode removeNode({required TreeNode node}) {
    if (!verifyNode(node)) {
      throw Exception(
        'Can\'t remove node [${node.runtimeType}] [${node.$id?.jsonPointer}] because it is not found in tree [$id]',
      );
    }
    // remove parent edge
    if (node.$parent != null) {
      final edge = node.$parent!;
      // remove parent reference from node
      node.$parent = null;
      // remove edge from parent's children
      final parent = edge.parent;
      parent.$children.remove(edge);
      // remove edge from edges list
      edges.remove(edge);
    }

    // remove all child edges
    if (node.$children.isNotEmpty) {
      for (final edge in node.$children) {
        // remove parent reference from child
        final child = edge.child;
        child.$parent = null;
        // remove edge from node's children
        node.$children.remove(edge);
        // remove edge from edges list
        edges.remove(edge);
      }
    }
    // remove node from nodes map
    nodes.remove(node.$id!.jsonPointer);
    // remove node id
    node.$id = null;
    return node;
  }

  TreeNode replaceNode({required TreeNode oldNode, required TreeNode newNode}) {
    if (!verifyNode(oldNode)) {
      throw Exception(
        'Can\'t replace node [${oldNode.runtimeType}] [${oldNode.$id?.jsonPointer}] because it is not found in tree [$id]',
      );
    }
    if (verifyNode(newNode)) {
      throw Exception(
        'Can\'t replace node [${oldNode.runtimeType}] [${oldNode.$id?.jsonPointer}] with node [${newNode.runtimeType}] [${newNode.$id?.jsonPointer}] because it already exists in tree [$id]',
      );
    }
    String jsonPointer = oldNode.$id!.jsonPointer;
    Edge? parentEdge = oldNode.$parent;
    List<Edge> childEdges = oldNode.$children;
    // update parent reference
    parentEdge?.child = newNode;
    // update child references
    for (final edge in childEdges) {
      edge.parent = newNode;
    }
    // update new node id
    newNode.setId(this, jsonPointer);
    // update new node parent edge
    newNode.$parent = parentEdge;
    // update new node child edges
    newNode.$children.addAll(childEdges);
    // update nodes map
    nodes[jsonPointer] = newNode;

    // remove old node parent edge
    oldNode.$parent = null;
    // remove old node child edges
    oldNode.$children.clear();
    // remove old node id
    oldNode.$id = null;
    return oldNode;
  }

  void addSubTree({required Tree subtree, required TreeNode parent, required String via}) {
    if (!verifyNode(parent)) {
      throw Exception('Can\'t add subtree because parent [${parent.$id?.jsonPointer}] is not found in tree [$id]');
    }
    if (subtree.root == null) {
      throw Exception('Can\'t add subtree because it has no root');
    }

    final subtreeRoot = subtree.root!;
    final rootJsonPointer = buildPointer([parent.$id!.jsonPointer, via]);

    // Update all node IDs in the subtree to point to this tree and update jsonPointers
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
    if (!verifyNode(subTreeRoot)) {
      throw Exception('Can\'t remove node [${subTreeRoot.$id?.jsonPointer}] because it is not found in tree [$id]');
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
      nodes.remove(n.$id!.jsonPointer);
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

  void _updateNodeIds(TreeNode node, Tree targetTree, String jsonPointer) {
    node.setId(targetTree, jsonPointer);
    targetTree.nodes[jsonPointer] = node;
    for (final edge in node.$children) {
      final childPointer = buildPointer([jsonPointer, edge.via]);
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
