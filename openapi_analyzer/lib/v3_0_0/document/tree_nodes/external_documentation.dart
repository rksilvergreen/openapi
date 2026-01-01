part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class ExternalDocumentation {
  final String? description;
  @JsonKey(required: true, disallowNullValue: true)
  final String url;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  ExternalDocumentation({
    this.description,
    required this.url,
    this.extensions = const {},
  });

  factory ExternalDocumentation.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final externalDocs = _$ExternalDocumentationFromJson(_jsonWithoutExtensions(json));
    return externalDocs.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ExternalDocumentationToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class ExternalDocumentationNode extends TreeNode {
  String? description;
  String url;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  ExternalDocumentationNode({
    this.description,
    required this.url,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$ExternalDocumentationNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

