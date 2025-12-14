import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'paths.dart';
import 'json_helpers.dart';

part '_gen/callback.g.dart';

/// A map of possible out-of band callbacks related to the parent operation.
@CopyWith()
@JsonSerializable(createFactory: false)
class Callback implements OpenapiObject {
  final Map<String, PathItem> expressions;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Callback({required this.expressions, this.extensions});

  factory Callback.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final expressions = <String, PathItem>{};
    final cleanedJson = jsonWithoutExtensions(json);
    for (final entry in cleanedJson.entries) {
      final key = entry.key.toString();
      if (entry.value is Map) {
        expressions[key] = PathItem.fromJson(Map<String, dynamic>.from(entry.value));
      }
    }
    return Callback(expressions: expressions, extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$CallbackToJson(this);
}
