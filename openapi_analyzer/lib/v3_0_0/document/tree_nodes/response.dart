part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Response {
  final String? description;
  final Map<String, Ref<Header>>? headers;
  final Map<String, MediaType>? content;
  final Map<String, Ref<Link>>? links;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Response({
    this.description,
    this.headers,
    this.content,
    this.links,
    this.extensions = const {},
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final response = _$ResponseFromJson(_jsonWithoutExtensions(json));
    return response.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ResponseToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class ResponseNode extends TreeNode {
  String? description;
  HeadersMapNode? get headers => $children?['headers'] as HeadersMapNode?;
  MediaTypesMapNode? get content => $children?['content'] as MediaTypesMapNode?;
  LinksMapNode? get links => $children?['links'] as LinksMapNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? extensions;

  ResponseNode({
    this.description,
    this.extensions,
  });

  Map<String, dynamic> toJson() {
    final json = _$ResponseNodeToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class ResponsesMapNode extends MapTreeNode<RefNode<ResponseNode>> {
  final Map<String, dynamic> extensions;

  ResponsesMapNode({this.extensions = const {}});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = entry.value.toJson();
    }
    json.addAll(extensions);
    return json;
  }
}
