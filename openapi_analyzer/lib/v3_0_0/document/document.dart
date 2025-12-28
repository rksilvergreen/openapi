import 'tree.dart';

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
