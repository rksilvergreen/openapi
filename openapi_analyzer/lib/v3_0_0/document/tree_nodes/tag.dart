part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Tag {
  @JsonKey(required: true, disallowNullValue: true)
  final String name;
  final String? description;
  final ExternalDocumentation? externalDocs;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Tag({
    required this.name,
    this.description,
    this.externalDocs,
    this.extensions = const {},
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final tag = _$TagFromJson(_jsonWithoutExtensions(json));
    return tag.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$TagToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class TagNode extends TreeNode {
  String name;
  String? description;
  ExternalDocumentationNode? get externalDocs => $children?['externalDocs'] as ExternalDocumentationNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  TagNode({
    required this.name,
    this.description,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$TagNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class TagsList extends ListTreeNode<TagNode> {
  List<dynamic> toJson() {
    return map((item) => _$TagNodeToJson(item)).toList();
  }
}

