part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Tag extends TreeNode {
  final String name;
  final String? description;
  final ExternalDocumentation? externalDocs;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Tag({
    required this.name,
    this.description,
    this.externalDocs,
    this.extensions,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final tag = _$TagFromJson(_jsonWithoutExtensions(json));
    return tag.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable(createFactory: false)
class TagsList extends ListTreeNode<Tag> {
  TagsList(List<Tag> tags) : super(tags);

  factory TagsList.fromJson(List<dynamic> json) {
    return TagsList(json.map((i) => Tag.fromJson(i)).toList());
  }
}

