import 'dart:collection';

import 'openapi_graph.dart';
import '../validation/validation_utils.dart';

abstract class ListNode<CHILD_NODE extends OpenApiNode, LIST> extends OpenApiNode
    with InternalNode, ListMixin<LIST>
    implements List<LIST> {
  ListNode(super.json, super.document, super.jsonPointer);

  late final List<LIST> childNodes;

  @override
  int get length => childNodes.length;

  @override
  set length(int newLength) {
    childNodes.length = newLength;
  }

  @override
  LIST operator [](int index) => childNodes[index];

  @override
  void operator []=(int index, LIST value) {
    childNodes[index] = value;
  }

  @override
  List<LIST> toList({bool growable = true}) => childNodes.toList(growable: growable);

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    final jsonList = json.values.toList();
    for (var i = 0; i < jsonList.length; i++) {
      ValidationUtils.requireMap(jsonList[i], ValidationUtils.buildPointer([jsonPointer, '[$i]']));
    }
  }

  @override
  void createChildNodes() {
    final jsonList = json.values.toList();
    for (var i = 0; i < jsonList.length; i++) {
      final itemJson = jsonList[i] as Map<String, dynamic>;
      final jsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, '[$i]']);

      late final CHILD_NODE childNode;
      if (itemJson.containsKey('\$ref')) {
        final ref = ValidationUtils.requireString(
          itemJson['\$ref'],
          ValidationUtils.buildPointer([jsonPointer, '\$ref']),
        );
        ValidationUtils.validateNoUnknownFields(itemJson, {'\$ref'}, jsonPointer, 'Reference Object');
        final (referencedJson, referencedDocument, referencedJsonPointer) = OpenApiGraph.i.referenceResolver
            .resolveReference(ref, jsonPointer);
        childNode = Node.ofType<CHILD_NODE>(referencedJson, referencedDocument, referencedJsonPointer);
      } else {
        childNode = Node.ofType<CHILD_NODE>(itemJson, $id.document, jsonPointer);
      }

      final exists = OpenApiGraph.i.openApiNodes.containsKey(childNode.$id.absolutePointer);
      final CHILD_NODE registeredNode;
      if (exists) {
        registeredNode = OpenApiGraph.i.openApiNodes[childNode.$id.absolutePointer] as CHILD_NODE;
      } else {
        OpenApiGraph.i.addOpenApiNode(childNode);
        childNode.create();
        registeredNode = childNode;
      }
      OpenApiGraph.i.addOpenApiEdge(this, registeredNode, '[$i]');
    }
  }

  @override
  void createContent() {
    childNodes = $to.where((edge) => edge.to is LIST).map((edge) => (edge as OpenApiEdge).to as LIST).toList();
  }
}
