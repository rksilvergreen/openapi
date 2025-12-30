part of '../document.dart';

@CopyWith()
@JsonSerializable()
class PathItem extends TreeNode {
  final Operation? get_;
  final Operation? put;
  final Operation? post;
  final Operation? delete;
  final Operation? options;
  final Operation? head;
  final Operation? patch;
  final Operation? trace;
  final ServerList? servers;
  final ParametersList? parameters;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  PathItem({
    this.get_,
    this.put,
    this.post,
    this.delete,
    this.options,
    this.head,
    this.patch,
    this.trace,
    this.servers,
    this.parameters,
    this.extensions,
  });

  factory PathItem.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final pathItem = _$PathItemFromJson(_jsonWithoutExtensions(json));
    return pathItem.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$PathItemToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class PathsMap extends MapTreeNode<PathItem> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  PathsMap(Map<String, PathItem> paths, {this.extensions}) : super(paths);

  factory PathsMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return PathsMap(map.map((key, value) => MapEntry(key, PathItem.fromJson(value))), extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$PathItemToJson(entry.value);
    }
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

