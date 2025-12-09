import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import 'json_helpers.dart';

part '_gen/info.g.dart';

/// Contact information for the exposed API.
@CopyWith()
@JsonSerializable()
class Contact implements OpenapiObject {
  final String? name;
  final String? url;
  final String? email;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Contact({this.name, this.url, this.email, this.extensions});

  factory Contact.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final contact = _$ContactFromJson(jsonWithoutExtensions(json));
    return contact.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}

/// License information for the exposed API.
@CopyWith()
@JsonSerializable()
class License implements OpenapiObject {
  final String name;
  final String? url;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  License({required this.name, this.url, this.extensions});

  factory License.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final license = _$LicenseFromJson(jsonWithoutExtensions(json));
    return license.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}

/// Metadata about the API.
@CopyWith()
@JsonSerializable()
class Info implements OpenapiObject {
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
    final extensions = extractExtensions(json);
    final info = _$InfoFromJson(jsonWithoutExtensions(json));
    return info.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
