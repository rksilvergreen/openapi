part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class PathItem {
  @JsonKey(name: 'get')
  final Operation? get_;
  final Operation? put;
  final Operation? post;
  final Operation? delete;
  final Operation? options;
  final Operation? head;
  final Operation? patch;
  final Operation? trace;
  final List<Server>? servers;
  final List<Ref<Parameter>>? parameters;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

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
    this.extensions = const {},
  });

  factory PathItem.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final pathItem = _$PathItemFromJson(_jsonWithoutExtensions(json));
    return pathItem.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$PathItemToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class PathItemNode extends TreeNode {
  @JsonKey(name: 'get')
  OperationNode? get get_ => $children?['get'] as OperationNode?;
  OperationNode? get put => $children?['put'] as OperationNode?;
  OperationNode? get post => $children?['post'] as OperationNode?;
  OperationNode? get delete => $children?['delete'] as OperationNode?;
  OperationNode? get options => $children?['options'] as OperationNode?;
  OperationNode? get head => $children?['head'] as OperationNode?;
  OperationNode? get patch => $children?['patch'] as OperationNode?;
  OperationNode? get trace => $children?['trace'] as OperationNode?;
  ServerList? get servers => $children?['servers'] as ServerList?;
  ParametersListNode? get parameters => $children?['parameters'] as ParametersListNode?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  PathItemNode({
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    print('PathItemNode toJson');
    print('children: ${$children?.keys}');
    final json = _$PathItemNodeToJson(this);
    print(json);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class PathsMapNode extends MapTreeNode<RefNode<PathItemNode>> {
  final Map<String, dynamic> extensions;

  PathsMapNode({this.extensions = const {}});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = entry.value.toJson();
    }
    json.addAll(extensions);
    return json;
  }
}
