// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../external_documentation.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExternalDocumentationCWProxy {
  ExternalDocumentation description(String? description);

  ExternalDocumentation url(String url);

  ExternalDocumentation extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExternalDocumentation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExternalDocumentation(...).copyWith(id: 12, name: "My name")
  /// ````
  ExternalDocumentation call({
    String? description,
    String url,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExternalDocumentation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExternalDocumentation.copyWith.fieldName(...)`
class _$ExternalDocumentationCWProxyImpl
    implements _$ExternalDocumentationCWProxy {
  const _$ExternalDocumentationCWProxyImpl(this._value);

  final ExternalDocumentation _value;

  @override
  ExternalDocumentation description(String? description) =>
      this(description: description);

  @override
  ExternalDocumentation url(String url) => this(url: url);

  @override
  ExternalDocumentation extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExternalDocumentation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExternalDocumentation(...).copyWith(id: 12, name: "My name")
  /// ````
  ExternalDocumentation call({
    Object? description = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ExternalDocumentation(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ExternalDocumentationCopyWith on ExternalDocumentation {
  /// Returns a callable class that can be used as follows: `instanceOfExternalDocumentation.copyWith(...)` or like so:`instanceOfExternalDocumentation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExternalDocumentationCWProxy get copyWith =>
      _$ExternalDocumentationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalDocumentation _$ExternalDocumentationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExternalDocumentation', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['description', 'url']);
  final val = ExternalDocumentation(
    description: $checkedConvert('description', (v) => v as String?),
    url: $checkedConvert('url', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$ExternalDocumentationToJson(
  ExternalDocumentation instance,
) => <String, dynamic>{
  'description': ?instance.description,
  'url': instance.url,
};
