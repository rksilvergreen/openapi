part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class RequestBody {
  final String? description;
  @JsonKey(required: true, disallowNullValue: true)
  final bool required;
  @JsonKey(required: true, disallowNullValue: true)
  final Map<String, MediaType> content;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  RequestBody({
    this.description,
    required this.required,
    required this.content,
    this.extensions = const {},
  });

  factory RequestBody.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final requestBody = _$RequestBodyFromJson(_jsonWithoutExtensions(json));
    return requestBody.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$RequestBodyToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class RequestBodyNode extends TreeNode {
  String? description;
  bool required;
  MediaTypesMapNode? get content => $children?['content'] as MediaTypesMapNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  RequestBodyNode({
    this.description,
    required this.required,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$RequestBodyNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class RequestBodiesMapNode extends MapTreeNode<RefNode<RequestBodyNode>> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = entry.value.toJson();
    }
    return json;
  }
}
