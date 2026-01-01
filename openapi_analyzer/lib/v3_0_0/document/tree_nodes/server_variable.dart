part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class ServerVariable {
  @JsonKey(name: 'enum')
  final List<String>? enum_;
  @JsonKey(name: 'default', required: true, disallowNullValue: true)
  final String default_;
  final String? description;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  ServerVariable({
    this.enum_,
    required this.default_,
    this.description,
    this.extensions = const {},
  });

  factory ServerVariable.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final serverVariable = _$ServerVariableFromJson(_jsonWithoutExtensions(json));
    return serverVariable.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ServerVariableToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class ServerVariableNode extends TreeNode {
  @JsonKey(name: 'enum')
  List<String>? enum_;
  @JsonKey(name: 'default')
  String default_;
  String? description;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  ServerVariableNode({
    this.enum_,
    required this.default_,
    this.description,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$ServerVariableNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class ServerVariablesMapNode extends MapTreeNode<ServerVariableNode> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$ServerVariableNodeToJson(entry.value);
    }
    return json;
  }
}
