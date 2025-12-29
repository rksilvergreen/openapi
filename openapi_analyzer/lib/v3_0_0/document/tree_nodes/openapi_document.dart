part of '../document.dart';

@CopyWith()
@JsonSerializable()
class OpenApiDocument extends TreeNode {
  final String openapi;
  final Info info;
  final ServerList? servers;
  final PathsMap paths;
  final Components? components;
  final SecurityRequirementsList? security;
  final TagsList? tags;
  final ExternalDocumentation? externalDocs;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  OpenApiDocument({
    required this.openapi,
    required this.info,
    this.servers,
    required this.paths,
    this.components,
    this.security,
    this.tags,
    this.externalDocs,
    this.extensions,
  });

  factory OpenApiDocument.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final document = _$OpenApiDocumentFromJson(_jsonWithoutExtensions(json));
    return document.copyWith(extensions: extensions);
  }
}

