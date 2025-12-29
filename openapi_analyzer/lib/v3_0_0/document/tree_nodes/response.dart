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

  Response({this.description, this.headers, this.content, this.links, this.extensions});

  factory Response.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final response = _$ResponseFromJson(_jsonWithoutExtensions(json));
    return response.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable(createFactory: false, createToJson: false)
class ResponsesMap extends MapTreeNode<Response> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  ResponsesMap(Map<String, Response> responses, {this.extensions}) : super(responses);

  factory ResponsesMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return ResponsesMap(map.map((key, value) => MapEntry(key, Response.fromJson(value))), extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$ResponseToJson(entry.value);
    }
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}
