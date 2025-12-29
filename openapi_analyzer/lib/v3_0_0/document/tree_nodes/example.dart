part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Example extends TreeNode {
  final String? summary;
  final String? description;
  final dynamic value;
  final String? externalValue;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Example({
    this.summary,
    this.description,
    this.value,
    this.externalValue,
    this.extensions,
  });

  factory Example.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final example = _$ExampleFromJson(_jsonWithoutExtensions(json));
    return example.copyWith(extensions: extensions);
  }
}

@CopyWith()
@JsonSerializable(createFactory: false)
class ExamplesMap extends MapTreeNode<Example> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  ExamplesMap(Map<String, Example> examples, {this.extensions}) : super(examples);

  factory ExamplesMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return ExamplesMap(map.map((key, value) => MapEntry(key, Example.fromJson(value))), extensions: extensions);
  }
}

