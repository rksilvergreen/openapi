import 'schema.dart';
import 'dart:collection';
import '../../list_node.dart';

abstract class SchemasList implements ListBase<Schema> {}

class SchemasListNode extends ListNode<SchemaNode, Schema> implements SchemasList {
  SchemasListNode(super.json, super.document, super.jsonPointer);
}
