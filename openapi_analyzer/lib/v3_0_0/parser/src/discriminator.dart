import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'json_helpers.dart';

part '_gen/discriminator.g.dart';

/// Discriminator object for polymorphism support.
@CopyWith()
@JsonSerializable()
class Discriminator implements OpenapiObject {
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
    final extensions = extractExtensions(json);
    final discriminator = _$DiscriminatorFromJson(jsonWithoutExtensions(json));
    return discriminator.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$DiscriminatorToJson(this);
}

