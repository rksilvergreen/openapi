part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class MediaType {
  final Map<String, Schema>? schema;
  final dynamic example;
  final Map<String, Example>? examples;
  final Map<String, Encoding>? encoding;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  MediaType({
    this.schema,
    this.example,
    this.examples,
    this.encoding,
    this.extensions = const {},
  });

  factory MediaType.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final mediaType = _$MediaTypeFromJson(_jsonWithoutExtensions(json));
    return mediaType.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$MediaTypeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class MediaTypeNode extends TreeNode {
  SchemasMap? get schema => $children?['schema'] as SchemasMap?;
  dynamic example;
  ExamplesMapNode? get examples => $children?['examples'] as ExamplesMapNode?;
  EncodingsMapNode? get encoding => $children?['encoding'] as EncodingsMapNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  MediaTypeNode({
    this.example,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$MediaTypeNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class MediaTypesMapNode extends MapTreeNode<MediaTypeNode> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$MediaTypeNodeToJson(entry.value);
    }
    return json;
  }
}
