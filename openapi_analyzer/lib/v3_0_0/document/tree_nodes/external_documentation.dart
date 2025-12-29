part of '../document.dart';

@CopyWith()
@JsonSerializable()
class ExternalDocumentation extends TreeNode {
  final String? description;
  final String url;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  ExternalDocumentation({
    this.description,
    required this.url,
    this.extensions,
  });

  factory ExternalDocumentation.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final externalDocs = _$ExternalDocumentationFromJson(_jsonWithoutExtensions(json));
    return externalDocs.copyWith(extensions: extensions);
  }
}

