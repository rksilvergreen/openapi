part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Server {
  @JsonKey(required: true, disallowNullValue: true)
  final String url;
  final String? description;
  final Map<String, ServerVariable>? variables;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Server({
    required this.url,
    this.description,
    this.variables,
    this.extensions = const {},
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final server = _$ServerFromJson(_jsonWithoutExtensions(json));
    return server.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ServerToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class ServerNode extends TreeNode {
  String url;
  String? description;
  ServerVariablesMapNode? get variables => $children?['variables'] as ServerVariablesMapNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  ServerNode({
    required this.url,
    this.description,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$ServerNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class ServerList extends ListTreeNode<ServerNode> {
  List<dynamic> toJson() {
    return map((item) => _$ServerNodeToJson(item)).toList();
  }
}
