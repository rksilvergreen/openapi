part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Link extends TreeNode {
  final String? operationRef;
  final String? operationId;
  final Map<String, dynamic>? parameters;
  final dynamic requestBody;
  final String? description;
  final Server? server;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Link({
    this.operationRef,
    this.operationId,
    this.parameters,
    this.requestBody,
    this.description,
    this.server,
    this.extensions,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final link = _$LinkFromJson(_jsonWithoutExtensions(json));
    return link.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable(createFactory: false)
class LinksMap extends MapTreeNode<Link> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  LinksMap(Map<String, Link> links, {this.extensions}) : super(links);

  factory LinksMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return LinksMap(map.map((key, value) => MapEntry(key, Link.fromJson(value))), extensions: extensions);
  }
}

