part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Response extends TreeNode {
  final String? description;
  final HeadersMap? headers;
  final MediaTypesMap? content;
  final LinksMap? links;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;
  final String $name;

  Response({
    this.description,
    this.headers,
    this.content,
    this.links,
    this.extensions,
    required this.$name,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final response = _$ResponseFromJson(_jsonWithoutExtensions(json));
    return response.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable()
class ResponsesMap extends MapTreeNode<Response> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  ResponsesMap(Map<String, Response> responses, {this.extensions}) : super(responses);

  factory ResponsesMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return ResponsesMap(map.map((key, value) => MapEntry(key, Response.fromJson(value))), extensions: extensions);
  }
}

