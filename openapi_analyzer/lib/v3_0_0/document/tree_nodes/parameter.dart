part of '../document.dart';

enum ParameterLocation {
  query('query'),
  header('header'),
  path('path'),
  cookie('cookie');

  const ParameterLocation(this.value);
  final String value;
}

/// Serialization style for a parameter.
enum ParameterStyle {
  matrix('matrix'),
  label('label'),
  form('form'),
  simple('simple'),
  spaceDelimited('spaceDelimited'),
  pipeDelimited('pipeDelimited'),
  deepObject('deepObject');

  const ParameterStyle(this.value);
  final String value;
}

@CopyWith(skipFields: true)
@JsonSerializable()
class Parameter extends TreeNode {
  final String name;
  final ParameterLocation in_;
  final String? description;
  final bool required_;
  final bool deprecated;
  final bool allowEmptyValue;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final Schema? schema;
  final dynamic example;
  final Map<String, Example>? examples;
  final Map<String, MediaType>? content;
  final Map<String, dynamic> extensions;

  Parameter({
    required this.name,
    required this.in_,
    this.description,
    required this.required_,
    required this.deprecated,
    required this.allowEmptyValue,
    this.style,
    this.explode,
    required this.allowReserved,
    this.schema,
    this.example,
    this.examples,
    this.content,
    this.extensions = const {},
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final parameter = _$ParameterFromJson(_jsonWithoutExtensions(json));
    return parameter.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ParameterToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class ParameterNode extends TreeNode {
  String name;
  ParameterLocation in_;
  String? description;
  bool required_;
  bool deprecated;
  bool allowEmptyValue;
  ParameterStyle? style;
  bool? explode;
  bool allowReserved;
  SchemasMapNode? get schema => $children?['schema'] as SchemasMapNode?;
  dynamic example;
  ExamplesMapNode? get examples => $children?['examples'] as ExamplesMapNode?;
  MediaTypesMapNode? get content => $children?['content'] as MediaTypesMapNode?;
  Map<String, dynamic> extensions;

  ParameterNode({
    required this.name,
    required this.in_,
    this.description,
    required this.required_,
    required this.deprecated,
    required this.allowEmptyValue,
    this.style,
    this.explode,
    required this.allowReserved,
    this.extensions = const {},
  });
}

@JsonSerializable(createFactory: false, createToJson: false)
class ParametersListNode extends ListTreeNode<ParameterNode> {

  List<dynamic> toJson() {
    return map((item) => _$ParameterNodeToJson(item)).toList();
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class ParametersMapNode extends MapTreeNode<ParameterNode> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$ParameterNodeToJson(entry.value);
    }
    return json;
  }
}