part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class OpenApiDocument {
  @JsonKey(required: true, disallowNullValue: true)
  final String openapi;
  @JsonKey(required: true, disallowNullValue: true)
  final Info info;
  final List<Server>? servers;
  @JsonKey(required: true, disallowNullValue: true)
  final Map<String, Ref<PathItem>> paths;
  final Components? components;
  final List<Ref<SecurityRequirement>>? security;
  final List<Tag>? tags;
  final ExternalDocumentation? externalDocs;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  OpenApiDocument({
    required this.openapi,
    required this.info,
    this.servers,
    required this.paths,
    this.components,
    this.security,
    this.tags,
    this.externalDocs,
    this.extensions = const {},
  });

  factory OpenApiDocument.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final document = _$OpenApiDocumentFromJson(_jsonWithoutExtensions(json));
    return document.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$OpenApiDocumentToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class OpenApiDocumentNode extends TreeNode {
  String openapi;
  InfoNode? get info => $children?['info'] as InfoNode?;
  ServerList? get servers => $children?['servers'] as ServerList?;
  PathsMapNode? get paths => $children?['paths'] as PathsMapNode?;
  ComponentsNode? get components => $children?['components'] as ComponentsNode?;
  SecurityRequirementsList? get security => $children?['security'] as SecurityRequirementsList?;
  TagsList? get tags => $children?['tags'] as TagsList?;
  ExternalDocumentationNode? get externalDocs => $children?['externalDocs'] as ExternalDocumentationNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  OpenApiDocumentNode({
    required this.openapi,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$OpenApiDocumentNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

