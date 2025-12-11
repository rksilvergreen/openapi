import '../openapi_graph.dart';
import 'schema/schema_node.dart';
import 'response.dart';
import 'parameter.dart';
import 'example.dart';
import 'request_body.dart';
import 'header.dart';
import 'security_scheme.dart';
import 'link.dart';
import 'callback.dart';

class ComponentsNode extends OpenApiNode {
  ComponentsNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, SchemaNode>? schemasNodes;
  late final Map<String, ResponseNode>? responsesNodes;
  late final Map<String, ParameterNode>? parametersNodes;
  late final Map<String, ExampleNode>? examplesNodes;
  late final Map<String, RequestBodyNode>? requestBodiesNodes;
  late final Map<String, HeaderNode>? headersNodes;
  late final Map<String, SecuritySchemeNode>? securitySchemesNodes;
  late final Map<String, LinkNode>? linksNodes;
  late final Map<String, CallbackNode>? callbacksNodes;

  late final Components content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = Components._(
      $id: $id,
      extensions: extractExtensions(json),
    );
  }
}

/// Holds a set of reusable objects for different aspects of the OAS.
class Components {
  final ComponentsNode _$node;
  Map<String, SchemaNode>? get schemas => _$node.schemasNodes;
  Map<String, Response>? get responses => _$node.responsesNodes?.map((k,v) => MapEntry(k, v.content));
  Map<String, Parameter>? get parameters => _$node.parametersNodes?.map((k,v) => MapEntry(k, v.content));
  Map<String, Example>? get examples => _$node.examplesNodes?.map((k,v) => MapEntry(k, v.content));
  Map<String, RequestBody>? get requestBodies => _$node.requestBodiesNodes?.map((k,v) => MapEntry(k, v.content));
  Map<String, Header>? get headers => _$node.headersNodes?.map((k,v) => MapEntry(k, v.content));
  Map<String, SecurityScheme>? get securitySchemes => _$node.securitySchemesNodes?.map((k,v) => MapEntry(k, v.content));
  Map<String, Link>? get links => _$node.linksNodes?.map((k,v) => MapEntry(k, v.content));
  Map<String, Callback>? get callbacks => _$node.callbacksNodes?.map((k,v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Components._({
    required NodeId $id,
    this.extensions,
  }) : _$node = OpenApiGraph.i.getOpenApiNode<ComponentsNode>($id);
}
