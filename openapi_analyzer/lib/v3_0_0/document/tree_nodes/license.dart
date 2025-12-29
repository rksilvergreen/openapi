part of '../document.dart';

@CopyWith()
@JsonSerializable()
class License extends TreeNode {
  final String name;
  final String? url;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  License({
    required this.name,
    this.url,
    this.extensions,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final license = _$LicenseFromJson(_jsonWithoutExtensions(json));
    return license.copyWith(extensions: extensions);
  }
}

