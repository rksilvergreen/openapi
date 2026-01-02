import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'json_helpers.dart';
part 'object_to_node_extension.dart';
part 'referenceable.dart';
part 'json_constructor_extension.dart';
part 'parseable.dart';
part 'tree.dart';
part 'tree_node.dart';
part 'map_tree_node.dart';
part 'list_tree_node.dart';
part 'tree_nodes/encoding.dart';
part 'tree_nodes/header.dart';
part 'tree_nodes/parameter.dart';
part 'tree_nodes/operation.dart';
part 'tree_nodes/callback.dart';
part 'tree_nodes/components.dart';
part 'tree_nodes/contact.dart';
part 'tree_nodes/discriminator.dart';
part 'tree_nodes/example.dart';
part 'tree_nodes/external_documentation.dart';
part 'tree_nodes/info.dart';
part 'tree_nodes/license.dart';
part 'tree_nodes/link.dart';
part 'tree_nodes/media_type.dart';
part 'tree_nodes/oauth_flow.dart';
part 'tree_nodes/path_item.dart';
part 'tree_nodes/request_body.dart';
part 'tree_nodes/response.dart';
part 'tree_nodes/security_requirement.dart';
part 'tree_nodes/security_scheme.dart';
part 'tree_nodes/server.dart';
part 'tree_nodes/server_variable.dart';
part 'tree_nodes/tag.dart';
part 'tree_nodes/xml.dart';
part 'tree_nodes/openapi_document.dart';
part 'tree_nodes/schema.dart';
part '_gen/document.g.dart';

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
    tree._document = this;
    tree.id = id;
  }

  Tree removeTree({String? newId}) {
    if (this.tree == null) {
      throw Exception('Tree not found in document [_$id]');
    }
    final tree = this.tree!;
    this.tree = null;
    tree._document = null;
    tree.setId(newId);
    return tree;
  }

  Tree replaceTree({String? oldTreeNewId, required Tree newTree}) {
    final tree = removeTree(newId: oldTreeNewId);
    setTree(newTree);
    return tree;
  }
}
