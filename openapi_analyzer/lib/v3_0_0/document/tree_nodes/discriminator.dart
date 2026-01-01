part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Discriminator {
  @JsonKey(required: true, disallowNullValue: true)
  final String propertyName;
  final Map<String, String>? mapping;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Discriminator({
    required this.propertyName,
    this.mapping,
    this.extensions = const {},
  });

  factory Discriminator.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final discriminator = _$DiscriminatorFromJson(_jsonWithoutExtensions(json));
    return discriminator.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$DiscriminatorToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class DiscriminatorNode extends TreeNode {
  String propertyName;
  Map<String, String>? mapping;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  DiscriminatorNode({
    required this.propertyName,
    this.mapping,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$DiscriminatorNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

