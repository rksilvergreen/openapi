import 'external_documentation.dart';
import '../node.dart';
import '../list_node.dart';

class Tag extends Node {
  final String name;
  final String? description;
  final ExternalDocumentation? externalDocs;
  final Map<String, dynamic>? extensions;

  Tag({required this.name, this.description, this.externalDocs, this.extensions});
}

class TagsList extends ListNode<Tag> {}

