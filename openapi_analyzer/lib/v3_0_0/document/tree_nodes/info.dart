part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Info extends TreeNode {
  final String title;
  final String? description;
  final String? termsOfService;
  final Contact? contact;
  final License? license;
  final String version;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Info({
    required this.title,
    this.description,
    this.termsOfService,
    this.contact,
    this.license,
    required this.version,
    this.extensions,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final info = _$InfoFromJson(_jsonWithoutExtensions(json));
    return info.copyWith(extensions: extensions);
  }
}

