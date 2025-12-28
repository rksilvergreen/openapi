import 'package:uuid/uuid.dart';
import 'document.dart';
import 'tree_node.dart';
import 'edge.dart';

class Tree {
  late String id;
  Document? document;

  Tree({String? id, this.root}) {
    setId(id);
  }

  Map<String, TreeNode> nodes = {};
  List<Edge> edges = [];

  TreeNode? root;

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

  void syncNodes() {
    // clear all nodes and edges from the map/list
    // go to the root and all its children recursively and add them to the map/list
  }

  void addNode({required TreeNode node, required TreeNode parent, required String via}) {
    if (!verifyNode(parent)) {
      throw Exception('Can\'t add node because parent [${parent.$id?.jsonPointer}] is not found in tree [$id]');
    }
    if (node.$id != null) {
      throw Exception('Node of type [${node.runtimeType}] already has an id [${node.$id?.jsonPointer}]');
    }
    final jsonPointer = buildPointer([parent.$id!.jsonPointer, via]);
    node.$id = NodeId(this, jsonPointer);
    nodes[jsonPointer] = node;
    final edge = Edge(parent, node, via);
    edges.add(edge);
    parent.$children.add(edge);
    node.$parent = edge;
  }

  void removeNode({required TreeNode node}) {
    if (!verifyNode(node)) {
      throw Exception('Can\'t remove node [${node.$id?.jsonPointer}] because it is not found in tree [$id]');
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
