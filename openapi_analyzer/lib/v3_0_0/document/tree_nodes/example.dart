part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Example {
  final String? summary;
  final String? description;
  final dynamic value;
  final String? externalValue;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Example({
    this.summary,
    this.description,
    this.value,
    this.externalValue,
    this.extensions = const {},
  });

  factory Example.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final example = _$ExampleFromJson(_jsonWithoutExtensions(json));
    return example.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ExampleToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class ExampleNode extends TreeNode {
  String? summary;
  String? description;
  dynamic value;
  String? externalValue;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  ExampleNode({
    this.summary,
    this.description,
    this.value,
    this.externalValue,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$ExampleNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class ExamplesMapNode extends MapTreeNode<RefNode<ExampleNode>> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = entry.value.toJson();
    }
    return json;
  }
}

