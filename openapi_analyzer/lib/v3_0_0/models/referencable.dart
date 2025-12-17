import 'openapi_graph.dart';
import '../validation/validation_utils.dart';

typedef NodeFactory<T> = T Function(NodeId id, Map<String, dynamic> json);

mixin Referencable {}
