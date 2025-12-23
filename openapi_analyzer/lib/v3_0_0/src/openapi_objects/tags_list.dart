import 'tag.dart';
import 'dart:collection';
import '../list_node.dart';
import 'package:openapi_analyzer/v3_0_0/objects/tag.dart';

class TagsListNode extends ListNode<TagNode, Tag> implements TagsList {
  TagsListNode(super.json, super.document, super.jsonPointer);
}

