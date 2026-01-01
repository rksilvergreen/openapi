part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Callback {
  @JsonKey(required: true, disallowNullValue: true)
  final Map<String, Ref<PathItem>> expressions;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Callback({
    required this.expressions,
    this.extensions = const {},
  });

  factory Callback.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final callback = _$CallbackFromJson(_jsonWithoutExtensions(json));
    return callback.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$CallbackToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class CallbackNode extends TreeNode {
  PathsMapNode? get expressions => $children?['expressions'] as PathsMapNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  CallbackNode({
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$CallbackNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class CallbacksMapNode extends MapTreeNode<RefNode<CallbackNode>> {
  final Map<String, dynamic> extensions;

  CallbacksMapNode({this.extensions = const {}});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = entry.value.toJson();
    }
    json.addAll(extensions);
    return json;
  }
}
