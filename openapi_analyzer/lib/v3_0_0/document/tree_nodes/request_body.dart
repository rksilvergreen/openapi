part of '../document.dart';

@CopyWith()
@JsonSerializable()
class RequestBody extends TreeNode {
  final String? description;
  final bool required;
  final MediaTypesMap content;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;
  final String $name;

  RequestBody({
    this.description,
    required this.required,
    required this.content,
    this.extensions,
    required this.$name,
  });

  factory RequestBody.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final requestBody = _$RequestBodyFromJson(_jsonWithoutExtensions(json));
    return requestBody.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable(createFactory: false)
class RequestBodiesMap extends MapTreeNode<RequestBody> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  RequestBodiesMap(Map<String, RequestBody> requestBodies, {this.extensions}) : super(requestBodies);

  factory RequestBodiesMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return RequestBodiesMap(map.map((key, value) => MapEntry(key, RequestBody.fromJson(value))), extensions: extensions);
  }
}

