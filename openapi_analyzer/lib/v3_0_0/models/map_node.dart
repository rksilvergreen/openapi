import 'openapi_graph.dart';
import 'node_creation_helpers.dart';
import '../validation/validation_utils.dart';
import '../../../validation_exception.dart';

abstract class MapNode<
  NODE extends MapNode<NODE, CHILD_NODE, CONTENT, CHILD_CONTENT>,
  CHILD_NODE extends OpenApiNode,
  CONTENT extends MapContent<NODE, CHILD_NODE, CONTENT, CHILD_CONTENT>,
  CHILD_CONTENT
>
    extends OpenApiNode
    with InternalNode {
  MapNode(Map<String, dynamic> json, String document, String jsonPointer) : super(NodeId(document, jsonPointer), json);

  CHILD_NODE Function(Map<String, dynamic> json, String document, String jsonPointer) get childNodeFactory;
  CONTENT Function(NODE $node, Map<String, dynamic>? extensions) get contentFactory;

  late final Map<String, CHILD_NODE> childNodes;

  late final CONTENT content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    for (final key in json.keys) {
      ValidationUtils.requireMap(json[key], ValidationUtils.buildPointer([jsonPointer, key]));
    }
  }

  @override
  void createChildNodes() {
    childNodes = createMapNode2<CHILD_NODE>(factory: childNodeFactory)!;
  }

  @override
  void createContent() {
    content = contentFactory(this as NODE, extractExtensions(json));
  }
}

abstract class MapContent<
  NODE extends MapNode<NODE, CHILD_NODE, CONTENT, CHILD_CONTENT>,
  CHILD_NODE extends OpenApiNode,
  CONTENT extends MapContent<NODE, CHILD_NODE, CONTENT, CHILD_CONTENT>,
  CHILD_CONTENT
> {
  final NODE $node;
  final Map<String, dynamic>? extensions;
  MapContent({required this.$node, this.extensions});

  Map<String, CHILD_CONTENT> get children => $node.childNodes.map((k, v) => MapEntry(k, v.content));
  operator [](String key) => children[key];
}

class TableNode extends OpenApiNode {
  TableNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);
}

class Table {}

class TablesNode extends MapNode<TablesNode, TableNode, Tables, Table> {
  TablesNode(Map<String, dynamic> json, String document, String jsonPointer) : super(json, document, jsonPointer);

  @override
  TableNode Function(Map<String, dynamic> json, String document, String jsonPointer) get childNodeFactory =>
      (Map<String, dynamic> json, String document, String jsonPointer) => TableNode(json, document, jsonPointer);

  @override
  Tables Function(TablesNode $node, Map<String, dynamic>? extensions) get contentFactory =>
      (TablesNode $node, Map<String, dynamic>? extensions) => Tables._($node: $node, extensions: extensions);
}

class Tables extends MapContent<TablesNode, TableNode, Tables, Table> {
  Tables._({required super.$node, super.extensions});
}
