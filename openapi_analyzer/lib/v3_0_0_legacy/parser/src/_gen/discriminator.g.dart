// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../discriminator.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DiscriminatorCWProxy {
  Discriminator propertyName(String propertyName);

  Discriminator mapping(Map<String, String>? mapping);

  Discriminator extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Discriminator(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Discriminator(...).copyWith(id: 12, name: "My name")
  /// ````
  Discriminator call({
    String propertyName,
    Map<String, String>? mapping,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDiscriminator.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDiscriminator.copyWith.fieldName(...)`
class _$DiscriminatorCWProxyImpl implements _$DiscriminatorCWProxy {
  const _$DiscriminatorCWProxyImpl(this._value);

  final Discriminator _value;

  @override
  Discriminator propertyName(String propertyName) =>
      this(propertyName: propertyName);

  @override
  Discriminator mapping(Map<String, String>? mapping) => this(mapping: mapping);

  @override
  Discriminator extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Discriminator(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Discriminator(...).copyWith(id: 12, name: "My name")
  /// ````
  Discriminator call({
    Object? propertyName = const $CopyWithPlaceholder(),
    Object? mapping = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Discriminator(
      propertyName: propertyName == const $CopyWithPlaceholder()
          ? _value.propertyName
          // ignore: cast_nullable_to_non_nullable
          : propertyName as String,
      mapping: mapping == const $CopyWithPlaceholder()
          ? _value.mapping
          // ignore: cast_nullable_to_non_nullable
          : mapping as Map<String, String>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $DiscriminatorCopyWith on Discriminator {
  /// Returns a callable class that can be used as follows: `instanceOfDiscriminator.copyWith(...)` or like so:`instanceOfDiscriminator.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DiscriminatorCWProxy get copyWith => _$DiscriminatorCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discriminator _$DiscriminatorFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Discriminator', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['propertyName', 'mapping']);
      final val = Discriminator(
        propertyName: $checkedConvert('propertyName', (v) => v as String),
        mapping: $checkedConvert(
          'mapping',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DiscriminatorToJson(Discriminator instance) =>
    <String, dynamic>{
      'propertyName': instance.propertyName,
      'mapping': ?instance.mapping,
    };
