import 'openapi_graph.dart';
import '../validation/validation_utils.dart';

typedef NodeFactory<T> = T Function(NodeId id, Map<String, dynamic> json);

mixin Referencable {
  static T getNode<T>(Map<String, dynamic> json, String document, String jsonPointer, NodeFactory<T> factory) {
    if (json.containsKey('\$ref')) {
      final ref = _validateRef(json, jsonPointer);
      final (nodeId, referencedJson) = OpenApiGraph.i.referenceResolver.resolveReference(ref, jsonPointer);
      return factory(nodeId, referencedJson);
    }
    return factory(NodeId(document, jsonPointer), json);
  }

  static String _validateRef(Map<String, dynamic> json, String jsonPointer) {
    final ref = ValidationUtils.requireString(json['\$ref'], ValidationUtils.buildPath(jsonPointer, '\$ref'));
    ValidationUtils.validateNoUnknownFields(json, {'\$ref'}, jsonPointer, 'Reference Object');
    return ref;
  }
}
