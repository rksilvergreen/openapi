part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Components {
  final Map<String, Ref<Schema>>? schemas;
  final Map<String, Ref<Response>>? responses;
  final Map<String, Ref<Parameter>>? parameters;
  final Map<String, Ref<Example>>? examples;
  final Map<String, Ref<RequestBody>>? requestBodies;
  final Map<String, Ref<Header>>? headers;
  final Map<String, SecurityScheme>? securitySchemes;
  final Map<String, Ref<Link>>? links;
  final Map<String, Ref<Callback>>? callbacks;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Components({
    this.schemas,
    this.responses,
    this.parameters,
    this.examples,
    this.requestBodies,
    this.headers,
    this.securitySchemes,
    this.links,
    this.callbacks,
    this.extensions = const {},
  });

  factory Components.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final components = _$ComponentsFromJson(_jsonWithoutExtensions(json));
    return components.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ComponentsToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class ComponentsNode extends TreeNode {
  SchemasMapNode? get schemas => $children?['schemas'] as SchemasMapNode?;
  ResponsesMapNode? get responses => $children?['responses'] as ResponsesMapNode?;
  ParametersMapNode? get parameters => $children?['parameters'] as ParametersMapNode?;
  ExamplesMapNode? get examples => $children?['examples'] as ExamplesMapNode?;
  RequestBodiesMapNode? get requestBodies => $children?['requestBodies'] as RequestBodiesMapNode?;
  HeadersMapNode? get headers => $children?['headers'] as HeadersMapNode?;
  SecuritySchemesMapNode? get securitySchemes => $children?['securitySchemes'] as SecuritySchemesMapNode?;
  LinksMapNode? get links => $children?['links'] as LinksMapNode?;
  CallbacksMapNode? get callbacks => $children?['callbacks'] as CallbacksMapNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  ComponentsNode({
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$ComponentsNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}
