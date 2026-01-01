part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Header extends TreeNode {
  final String? description;
  final bool required_;
  final bool deprecated;
  final bool allowEmptyValue;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final Map<String, Schema>? schema;
  final dynamic example;
  final Map<String, Example>? examples;
  final Map<String, MediaType>? content;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Header({
    this.description,
    required this.required_,
    required this.deprecated,
    required this.allowEmptyValue,
    this.style,
    this.explode,
    required this.allowReserved,
    this.schema,
    this.example,
    this.examples,
    this.content,
    this.extensions = const {},
  });

  factory Header.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final header = _$HeaderFromJson(_jsonWithoutExtensions(json));
    return header.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$HeaderToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class HeaderNode extends TreeNode {
  String? description;
  bool required_;
  bool deprecated;
  bool allowEmptyValue;
  ParameterStyle? style;
  bool? explode;
  bool allowReserved;
  SchemasMapNode? get schema => $children?['schema'] as SchemasMapNode?;
  ExamplesMapNode? get examples => $children?['examples'] as ExamplesMapNode?;
  MediaTypesMapNode? get content => $children?['content'] as MediaTypesMapNode?;
  Map<String, dynamic> extensions;

  HeaderNode({
    this.description,
    required this.required_,
    required this.deprecated,
    required this.allowEmptyValue,
    this.style,
    this.explode,
    required this.allowReserved,
    this.extensions = const {},
  });
}

@JsonSerializable(createFactory: false, createToJson: false)
class HeadersMapNode extends MapTreeNode<HeaderNode> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    final children = $children ?? <String, HeaderNode>{};
    for (final entry in children.entries) {
      json[entry.key] = _$HeaderNodeToJson(entry.value);
    }
    return json;
  }
}
