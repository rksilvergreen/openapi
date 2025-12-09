// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../example.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExampleCWProxy {
  Example summary(String? summary);

  Example description(String? description);

  Example value(dynamic value);

  Example externalValue(String? externalValue);

  Example extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Example(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Example(...).copyWith(id: 12, name: "My name")
  /// ````
  Example call({
    String? summary,
    String? description,
    dynamic value,
    String? externalValue,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExample.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExample.copyWith.fieldName(...)`
class _$ExampleCWProxyImpl implements _$ExampleCWProxy {
  const _$ExampleCWProxyImpl(this._value);

  final Example _value;

  @override
  Example summary(String? summary) => this(summary: summary);

  @override
  Example description(String? description) => this(description: description);

  @override
  Example value(dynamic value) => this(value: value);

  @override
  Example externalValue(String? externalValue) =>
      this(externalValue: externalValue);

  @override
  Example extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Example(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Example(...).copyWith(id: 12, name: "My name")
  /// ````
  Example call({
    Object? summary = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? externalValue = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Example(
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as dynamic,
      externalValue: externalValue == const $CopyWithPlaceholder()
          ? _value.externalValue
          // ignore: cast_nullable_to_non_nullable
          : externalValue as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ExampleCopyWith on Example {
  /// Returns a callable class that can be used as follows: `instanceOfExample.copyWith(...)` or like so:`instanceOfExample.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExampleCWProxy get copyWith => _$ExampleCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Example', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['summary', 'description', 'value', 'externalValue'],
      );
      final val = Example(
        summary: $checkedConvert('summary', (v) => v as String?),
        description: $checkedConvert('description', (v) => v as String?),
        value: $checkedConvert('value', (v) => v),
        externalValue: $checkedConvert('externalValue', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
  'summary': ?instance.summary,
  'description': ?instance.description,
  'value': ?instance.value,
  'externalValue': ?instance.externalValue,
};
