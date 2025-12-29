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

@CopyWith()
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
  final ExamplesMap? examples;
  final MediaTypesMap? content;
  final Map<String, dynamic>? extensions;
  final String $name;

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
    this.extensions,
    required this.$name,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final parameter = _$ParameterFromJson(_jsonWithoutExtensions(json));
    return parameter.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable()
class ParametersList extends ListTreeNode<Parameter> {
  ParametersList(List<Parameter> parameters) : super(parameters);

  factory ParametersList.fromJson(List<dynamic> json) {
    return ParametersList(json.map((i) => Parameter.fromJson(i)).toList());
  }
}

@CopyWith()
@JsonSerializable()
class ParametersMap extends MapTreeNode<Parameter> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  ParametersMap(Map<String, Parameter> parameters, {this.extensions}) : super(parameters);

  factory ParametersMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return ParametersMap(map.map((key, value) => MapEntry(key, Parameter.fromJson(value))), extensions: extensions);
  }
}