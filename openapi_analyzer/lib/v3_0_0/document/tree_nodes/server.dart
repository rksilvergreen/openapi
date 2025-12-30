part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Server extends TreeNode {
  final String url;
  final String? description;
  final ServerVariablesMap? variables;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Server({required this.url, this.description, this.variables, this.extensions});

  factory Server.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final server = _$ServerFromJson(_jsonWithoutExtensions(json));
    return server.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ServerToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class ServerList extends ListTreeNode<Server> {
  ServerList(List<Server> servers) : super(servers);

  factory ServerList.fromJson(List<dynamic> json) {
    return ServerList(json.map((i) => Server.fromJson(i)).toList());
  }

  List<dynamic> toJson() {
    return map((item) => _$ServerToJson(item)).toList();
  }
}

@CopyWith()
@JsonSerializable()
class ServerVariable extends TreeNode {
  final List<String>? enum_;
  final String default_;
  final String? description;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  ServerVariable({this.enum_, required this.default_, this.description, this.extensions});

  factory ServerVariable.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final serverVariable = _$ServerVariableFromJson(_jsonWithoutExtensions(json));
    return serverVariable.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ServerVariableToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class ServerVariablesMap extends MapTreeNode<ServerVariable> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  ServerVariablesMap(Map<String, ServerVariable> variables, {this.extensions}) : super(variables);

  factory ServerVariablesMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return ServerVariablesMap(
      map.map((key, value) => MapEntry(key, ServerVariable.fromJson(value))),
      extensions: extensions,
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$ServerVariableToJson(entry.value);
    }
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}
