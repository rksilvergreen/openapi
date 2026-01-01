part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class License {
  @JsonKey(required: true, disallowNullValue: true)
  final String name;
  final String? url;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  License({
    required this.name,
    this.url,
    this.extensions = const {},
  });

  factory License.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final license = _$LicenseFromJson(_jsonWithoutExtensions(json));
    return license.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$LicenseToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class LicenseNode extends TreeNode {
  String name;
  String? url;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  LicenseNode({
    required this.name,
    this.url,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$LicenseNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

