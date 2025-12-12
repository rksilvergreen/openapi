import '../openapi_graph.dart';
import 'enums.dart';
import 'oauth_flows.dart';

class SecuritySchemeNode extends OpenApiNode {
  SecuritySchemeNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final OAuthFlowsNode? flowsNode;

  late final SecurityScheme content;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createContent() {
    content = SecurityScheme._(
      $id: $id,
      type: SecuritySchemeType.values.firstWhere((e) => e.value == json['type']),
      description: json['description'],
      name: json['name'],
      in_: json['in'] != null ? SecuritySchemeIn.values.firstWhere((e) => e.value == json['in']) : null,
      scheme: json['scheme'],
      bearerFormat: json['bearerFormat'],
      openIdConnectUrl: json['openIdConnectUrl'],
      extensions: extractExtensions(json),
    );
  }
}

/// Defines a security scheme that can be used by the operations.
class SecurityScheme {
  final SecuritySchemeNode _$node;
  final SecuritySchemeType type;
  final String? description;
  final String? name;
  final SecuritySchemeIn? in_;
  final String? scheme;
  final String? bearerFormat;
  OAuthFlows? get flows => _$node.flowsNode?.content;
  final String? openIdConnectUrl;
  final Map<String, dynamic>? extensions;

  SecurityScheme._({
    required NodeId $id,
    required this.type,
    this.description,
    this.name,
    this.in_,
    this.scheme,
    this.bearerFormat,
    this.openIdConnectUrl,
    this.extensions,
  }) : _$node = OpenApiGraph.i.getOpenApiNode<SecuritySchemeNode>($id);
}
