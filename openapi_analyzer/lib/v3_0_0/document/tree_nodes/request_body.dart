part of '../document.dart';

@CopyWith()
@JsonSerializable()
class RequestBody extends TreeNode {
  final String? description;
  final bool required;
  final MediaTypesMap content;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  RequestBody({this.description, required this.required, required this.content, this.extensions});

  factory RequestBody.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final requestBody = _$RequestBodyFromJson(_jsonWithoutExtensions(json));
    return requestBody.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$RequestBodyToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class RequestBodiesMap extends MapTreeNode<RequestBody> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  RequestBodiesMap(Map<String, RequestBody> requestBodies, {this.extensions}) : super(requestBodies);

  factory RequestBodiesMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return RequestBodiesMap(
      map.map((key, value) => MapEntry(key, RequestBody.fromJson(value))),
      extensions: extensions,
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$RequestBodyToJson(entry.value);
    }
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}
