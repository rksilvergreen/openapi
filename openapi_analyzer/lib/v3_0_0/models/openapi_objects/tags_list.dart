import 'tag.dart';
import 'dart:collection';
import '../list_node.dart';

abstract class TagsList implements ListBase<Tag> {}

class TagsListNode extends ListNode<TagNode, Tag> implements TagsList {
  TagsListNode(super.json, super.document, super.jsonPointer);
}

