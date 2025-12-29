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
  final SchemasMap? schema;
  final dynamic example;
  final ExamplesMap? examples;
  final MediaTypesMap? content;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

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
    this.extensions,
  });

  factory Header.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final header = _$HeaderFromJson(_jsonWithoutExtensions(json));
    return header.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable()
class HeadersMap extends MapTreeNode<Header> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  HeadersMap(Map<String, Header> headers, {this.extensions}) : super(headers);

  factory HeadersMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return HeadersMap(map.map((key, value) => MapEntry(key, Header.fromJson(value))), extensions: extensions);
  }
}