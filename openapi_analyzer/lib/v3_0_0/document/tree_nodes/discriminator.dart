part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Discriminator extends TreeNode {
  final String propertyName;
  final Map<String, String>? mapping;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Discriminator({
    required this.propertyName,
    this.mapping,
    this.extensions,
  });

  factory Discriminator.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final discriminator = _$DiscriminatorFromJson(_jsonWithoutExtensions(json));
    return discriminator.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$DiscriminatorToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

