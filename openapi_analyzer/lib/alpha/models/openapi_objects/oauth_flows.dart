import '../openapi_graph.dart';
import 'oauth_flow.dart';

class OAuthFlowsNode extends OpenApiNode {
  OAuthFlowsNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final OAuthFlowNode? implicitNode;
  late final OAuthFlowNode? passwordNode;
  late final OAuthFlowNode? clientCredentialsNode;
  late final OAuthFlowNode? authorizationCodeNode;

  late final OAuthFlows content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = OAuthFlows._($id: $id, extensions: extractExtensions(json));
  }
}

/// Allows configuration of the supported OAuth Flows.
class OAuthFlows {
  final OAuthFlowsNode _$node;
  OAuthFlow? get implicit => _$node.implicitNode?.content;
  OAuthFlow? get password => _$node.passwordNode?.content;
  OAuthFlow? get clientCredentials => _$node.clientCredentialsNode?.content;
  OAuthFlow? get authorizationCode => _$node.authorizationCodeNode?.content;
  final Map<String, dynamic>? extensions;

  OAuthFlows._({required NodeId $id, this.extensions}) : _$node = OpenApiGraph.i.getOpenApiNode<OAuthFlowsNode>($id);
}
