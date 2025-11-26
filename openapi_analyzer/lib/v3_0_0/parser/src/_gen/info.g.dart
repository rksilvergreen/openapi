// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactCWProxy {
  Contact name(String? name);

  Contact url(String? url);

  Contact email(String? email);

  Contact extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Contact(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Contact(...).copyWith(id: 12, name: "My name")
  /// ````
  Contact call({
    String? name,
    String? url,
    String? email,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfContact.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfContact.copyWith.fieldName(...)`
class _$ContactCWProxyImpl implements _$ContactCWProxy {
  const _$ContactCWProxyImpl(this._value);

  final Contact _value;

  @override
  Contact name(String? name) => this(name: name);

  @override
  Contact url(String? url) => this(url: url);

  @override
  Contact email(String? email) => this(email: email);

  @override
  Contact extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Contact(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Contact(...).copyWith(id: 12, name: "My name")
  /// ````
  Contact call({
    Object? name = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Contact(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ContactCopyWith on Contact {
  /// Returns a callable class that can be used as follows: `instanceOfContact.copyWith(...)` or like so:`instanceOfContact.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactCWProxy get copyWith => _$ContactCWProxyImpl(this);
}

abstract class _$LicenseCWProxy {
  License name(String name);

  License url(String? url);

  License extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `License(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// License(...).copyWith(id: 12, name: "My name")
  /// ````
  License call({String name, String? url, Map<String, dynamic>? extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLicense.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLicense.copyWith.fieldName(...)`
class _$LicenseCWProxyImpl implements _$LicenseCWProxy {
  const _$LicenseCWProxyImpl(this._value);

  final License _value;

  @override
  License name(String name) => this(name: name);

  @override
  License url(String? url) => this(url: url);

  @override
  License extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `License(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// License(...).copyWith(id: 12, name: "My name")
  /// ````
  License call({
    Object? name = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return License(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $LicenseCopyWith on License {
  /// Returns a callable class that can be used as follows: `instanceOfLicense.copyWith(...)` or like so:`instanceOfLicense.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LicenseCWProxy get copyWith => _$LicenseCWProxyImpl(this);
}

abstract class _$InfoCWProxy {
  Info title(String title);

  Info description(String? description);

  Info termsOfService(String? termsOfService);

  Info contact(Contact? contact);

  Info license(License? license);

  Info version(String version);

  Info extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Info(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Info(...).copyWith(id: 12, name: "My name")
  /// ````
  Info call({
    String title,
    String? description,
    String? termsOfService,
    Contact? contact,
    License? license,
    String version,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInfo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInfo.copyWith.fieldName(...)`
class _$InfoCWProxyImpl implements _$InfoCWProxy {
  const _$InfoCWProxyImpl(this._value);

  final Info _value;

  @override
  Info title(String title) => this(title: title);

  @override
  Info description(String? description) => this(description: description);

  @override
  Info termsOfService(String? termsOfService) =>
      this(termsOfService: termsOfService);

  @override
  Info contact(Contact? contact) => this(contact: contact);

  @override
  Info license(License? license) => this(license: license);

  @override
  Info version(String version) => this(version: version);

  @override
  Info extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Info(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Info(...).copyWith(id: 12, name: "My name")
  /// ````
  Info call({
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? termsOfService = const $CopyWithPlaceholder(),
    Object? contact = const $CopyWithPlaceholder(),
    Object? license = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Info(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      termsOfService: termsOfService == const $CopyWithPlaceholder()
          ? _value.termsOfService
          // ignore: cast_nullable_to_non_nullable
          : termsOfService as String?,
      contact: contact == const $CopyWithPlaceholder()
          ? _value.contact
          // ignore: cast_nullable_to_non_nullable
          : contact as Contact?,
      license: license == const $CopyWithPlaceholder()
          ? _value.license
          // ignore: cast_nullable_to_non_nullable
          : license as License?,
      version: version == const $CopyWithPlaceholder()
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as String,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $InfoCopyWith on Info {
  /// Returns a callable class that can be used as follows: `instanceOfInfo.copyWith(...)` or like so:`instanceOfInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InfoCWProxy get copyWith => _$InfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Contact', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['name', 'url', 'email']);
      final val = Contact(
        name: $checkedConvert('name', (v) => v as String?),
        url: $checkedConvert('url', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
  'name': ?instance.name,
  'url': ?instance.url,
  'email': ?instance.email,
};

License _$LicenseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('License', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['name', 'url']);
      final val = License(
        name: $checkedConvert('name', (v) => v as String),
        url: $checkedConvert('url', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$LicenseToJson(License instance) => <String, dynamic>{
  'name': instance.name,
  'url': ?instance.url,
};

Info _$InfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Info', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'title',
          'description',
          'termsOfService',
          'contact',
          'license',
          'version',
        ],
      );
      final val = Info(
        title: $checkedConvert('title', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        termsOfService: $checkedConvert('termsOfService', (v) => v as String?),
        contact: $checkedConvert(
          'contact',
          (v) => v == null ? null : Contact.fromJson(v as Map<String, dynamic>),
        ),
        license: $checkedConvert(
          'license',
          (v) => v == null ? null : License.fromJson(v as Map<String, dynamic>),
        ),
        version: $checkedConvert('version', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
  'title': instance.title,
  'description': ?instance.description,
  'termsOfService': ?instance.termsOfService,
  'contact': ?instance.contact?.toJson(),
  'license': ?instance.license?.toJson(),
  'version': instance.version,
};
