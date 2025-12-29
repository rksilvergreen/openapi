part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Callback extends TreeNode {
  final PathsMap expressions;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Callback({
    required this.expressions,
    this.extensions,
  });

  factory Callback.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final callback = _$CallbackFromJson(_jsonWithoutExtensions(json));
    return callback.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable()
class CallbacksMap extends MapTreeNode<Callback> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  CallbacksMap(Map<String, Callback> callbacks, {this.extensions}) : super(callbacks);

  factory CallbacksMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return CallbacksMap(map.map((key, value) => MapEntry(key, Callback.fromJson(value))), extensions: extensions);
  }
}

