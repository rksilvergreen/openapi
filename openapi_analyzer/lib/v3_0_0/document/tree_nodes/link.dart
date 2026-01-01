part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Link {
  final String? operationRef;
  final String? operationId;
  final Map<String, dynamic>? parameters;
  final dynamic requestBody;
  final String? description;
  final Server? server;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Link({
    this.operationRef,
    this.operationId,
    this.parameters,
    this.requestBody,
    this.description,
    this.server,
    this.extensions = const {},
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final link = _$LinkFromJson(_jsonWithoutExtensions(json));
    return link.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$LinkToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class LinkNode extends TreeNode {
  String? operationRef;
  String? operationId;
  Map<String, dynamic>? parameters;
  dynamic requestBody;
  String? description;
  ServerNode? get server => $children?['server'] as ServerNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  LinkNode({
    this.operationRef,
    this.operationId,
    this.parameters,
    this.requestBody,
    this.description,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$LinkNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class LinksMapNode extends MapTreeNode<RefNode<LinkNode>> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = entry.value.toJson();
    }
    return json;
  }
}

