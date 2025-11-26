// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../xml.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$XMLCWProxy {
  XML name(String? name);

  XML namespace(String? namespace);

  XML prefix(String? prefix);

  XML attribute(bool attribute);

  XML wrapped(bool wrapped);

  XML extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `XML(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// XML(...).copyWith(id: 12, name: "My name")
  /// ````
  XML call({
    String? name,
    String? namespace,
    String? prefix,
    bool attribute,
    bool wrapped,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfXML.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfXML.copyWith.fieldName(...)`
class _$XMLCWProxyImpl implements _$XMLCWProxy {
  const _$XMLCWProxyImpl(this._value);

  final XML _value;

  @override
  XML name(String? name) => this(name: name);

  @override
  XML namespace(String? namespace) => this(namespace: namespace);

  @override
  XML prefix(String? prefix) => this(prefix: prefix);

  @override
  XML attribute(bool attribute) => this(attribute: attribute);

  @override
  XML wrapped(bool wrapped) => this(wrapped: wrapped);

  @override
  XML extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `XML(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// XML(...).copyWith(id: 12, name: "My name")
  /// ````
  XML call({
    Object? name = const $CopyWithPlaceholder(),
    Object? namespace = const $CopyWithPlaceholder(),
    Object? prefix = const $CopyWithPlaceholder(),
    Object? attribute = const $CopyWithPlaceholder(),
    Object? wrapped = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return XML(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      namespace: namespace == const $CopyWithPlaceholder()
          ? _value.namespace
          // ignore: cast_nullable_to_non_nullable
          : namespace as String?,
      prefix: prefix == const $CopyWithPlaceholder()
          ? _value.prefix
          // ignore: cast_nullable_to_non_nullable
          : prefix as String?,
      attribute: attribute == const $CopyWithPlaceholder()
          ? _value.attribute
          // ignore: cast_nullable_to_non_nullable
          : attribute as bool,
      wrapped: wrapped == const $CopyWithPlaceholder()
          ? _value.wrapped
          // ignore: cast_nullable_to_non_nullable
          : wrapped as bool,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $XMLCopyWith on XML {
  /// Returns a callable class that can be used as follows: `instanceOfXML.copyWith(...)` or like so:`instanceOfXML.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$XMLCWProxy get copyWith => _$XMLCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XML _$XMLFromJson(Map<String, dynamic> json) => $checkedCreate('XML', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    allowedKeys: const ['name', 'namespace', 'prefix', 'attribute', 'wrapped'],
  );
  final val = XML(
    name: $checkedConvert('name', (v) => v as String?),
    namespace: $checkedConvert('namespace', (v) => v as String?),
    prefix: $checkedConvert('prefix', (v) => v as String?),
    attribute: $checkedConvert('attribute', (v) => v as bool? ?? false),
    wrapped: $checkedConvert('wrapped', (v) => v as bool? ?? false),
  );
  return val;
});

Map<String, dynamic> _$XMLToJson(XML instance) => <String, dynamic>{
  'name': ?instance.name,
  'namespace': ?instance.namespace,
  'prefix': ?instance.prefix,
  'attribute': instance.attribute,
  'wrapped': instance.wrapped,
};
