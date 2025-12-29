import 'dart:collection';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:uuid/uuid.dart';

part 'json_helpers.dart';
part 'edge.dart';
part 'tree.dart';
part 'tree_node.dart';
part 'map_tree_node.dart';
part 'list_tree_node.dart';
part 'tree_nodes/encoding.dart';
part 'tree_nodes/header.dart';
part 'tree_nodes/parameter.dart';
part 'tree_nodes/operation.dart';

class Document {
  final String id;
  Tree? tree;

  Document({required this.id, this.tree}) {
    if (tree != null) {
      setTree(tree!);
    }
  }

  void setTree(Tree tree) {
    this.tree = tree;
    tree.document = this;
    tree.id = id;
  }

  Tree removeTree({String? newId}) {
    if (this.tree == null) {
      throw Exception('Tree not found in document [$id]');
    }
    final tree = this.tree!;
    this.tree = null;
    tree.document = null;
    tree.setId(newId);
    return tree;
  }

  Tree replaceTree({String? oldTreeNewId, required Tree newTree}) {
    final tree = removeTree(newId: oldTreeNewId);
    setTree(newTree);
    return tree;
  }
}
