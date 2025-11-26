// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../components.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ComponentsCWProxy {
  Components schemas(Map<String, Referenceable<SchemaObject>>? schemas);

  Components responses(Map<String, Referenceable<Response>>? responses);

  Components parameters(Map<String, Referenceable<Parameter>>? parameters);

  Components examples(Map<String, Referenceable<Example>>? examples);

  Components requestBodies(
    Map<String, Referenceable<RequestBody>>? requestBodies,
  );

  Components headers(Map<String, Referenceable<Header>>? headers);

  Components securitySchemes(
    Map<String, Referenceable<SecurityScheme>>? securitySchemes,
  );

  Components links(Map<String, Referenceable<Link>>? links);

  Components callbacks(Map<String, Referenceable<Callback>>? callbacks);

  Components extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Components(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Components(...).copyWith(id: 12, name: "My name")
  /// ````
  Components call({
    Map<String, Referenceable<SchemaObject>>? schemas,
    Map<String, Referenceable<Response>>? responses,
    Map<String, Referenceable<Parameter>>? parameters,
    Map<String, Referenceable<Example>>? examples,
    Map<String, Referenceable<RequestBody>>? requestBodies,
    Map<String, Referenceable<Header>>? headers,
    Map<String, Referenceable<SecurityScheme>>? securitySchemes,
    Map<String, Referenceable<Link>>? links,
    Map<String, Referenceable<Callback>>? callbacks,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComponents.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfComponents.copyWith.fieldName(...)`
class _$ComponentsCWProxyImpl implements _$ComponentsCWProxy {
  const _$ComponentsCWProxyImpl(this._value);

  final Components _value;

  @override
  Components schemas(Map<String, Referenceable<SchemaObject>>? schemas) =>
      this(schemas: schemas);

  @override
  Components responses(Map<String, Referenceable<Response>>? responses) =>
      this(responses: responses);

  @override
  Components parameters(Map<String, Referenceable<Parameter>>? parameters) =>
      this(parameters: parameters);

  @override
  Components examples(Map<String, Referenceable<Example>>? examples) =>
      this(examples: examples);

  @override
  Components requestBodies(
    Map<String, Referenceable<RequestBody>>? requestBodies,
  ) => this(requestBodies: requestBodies);

  @override
  Components headers(Map<String, Referenceable<Header>>? headers) =>
      this(headers: headers);

  @override
  Components securitySchemes(
    Map<String, Referenceable<SecurityScheme>>? securitySchemes,
  ) => this(securitySchemes: securitySchemes);

  @override
  Components links(Map<String, Referenceable<Link>>? links) =>
      this(links: links);

  @override
  Components callbacks(Map<String, Referenceable<Callback>>? callbacks) =>
      this(callbacks: callbacks);

  @override
  Components extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Components(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Components(...).copyWith(id: 12, name: "My name")
  /// ````
  Components call({
    Object? schemas = const $CopyWithPlaceholder(),
    Object? responses = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
    Object? examples = const $CopyWithPlaceholder(),
    Object? requestBodies = const $CopyWithPlaceholder(),
    Object? headers = const $CopyWithPlaceholder(),
    Object? securitySchemes = const $CopyWithPlaceholder(),
    Object? links = const $CopyWithPlaceholder(),
    Object? callbacks = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Components(
      schemas: schemas == const $CopyWithPlaceholder()
          ? _value.schemas
          // ignore: cast_nullable_to_non_nullable
          : schemas as Map<String, Referenceable<SchemaObject>>?,
      responses: responses == const $CopyWithPlaceholder()
          ? _value.responses
          // ignore: cast_nullable_to_non_nullable
          : responses as Map<String, Referenceable<Response>>?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as Map<String, Referenceable<Parameter>>?,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as Map<String, Referenceable<Example>>?,
      requestBodies: requestBodies == const $CopyWithPlaceholder()
          ? _value.requestBodies
          // ignore: cast_nullable_to_non_nullable
          : requestBodies as Map<String, Referenceable<RequestBody>>?,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as Map<String, Referenceable<Header>>?,
      securitySchemes: securitySchemes == const $CopyWithPlaceholder()
          ? _value.securitySchemes
          // ignore: cast_nullable_to_non_nullable
          : securitySchemes as Map<String, Referenceable<SecurityScheme>>?,
      links: links == const $CopyWithPlaceholder()
          ? _value.links
          // ignore: cast_nullable_to_non_nullable
          : links as Map<String, Referenceable<Link>>?,
      callbacks: callbacks == const $CopyWithPlaceholder()
          ? _value.callbacks
          // ignore: cast_nullable_to_non_nullable
          : callbacks as Map<String, Referenceable<Callback>>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ComponentsCopyWith on Components {
  /// Returns a callable class that can be used as follows: `instanceOfComponents.copyWith(...)` or like so:`instanceOfComponents.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ComponentsCWProxy get copyWith => _$ComponentsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Components _$ComponentsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Components', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'schemas',
          'responses',
          'parameters',
          'examples',
          'requestBodies',
          'headers',
          'securitySchemes',
          'links',
          'callbacks',
        ],
      );
      final val = Components(
        schemas: $checkedConvert(
          'schemas',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<SchemaObject>.fromJson(e)),
          ),
        ),
        responses: $checkedConvert(
          'responses',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Response>.fromJson(e)),
          ),
        ),
        parameters: $checkedConvert(
          'parameters',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Parameter>.fromJson(e)),
          ),
        ),
        examples: $checkedConvert(
          'examples',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Example>.fromJson(e)),
          ),
        ),
        requestBodies: $checkedConvert(
          'requestBodies',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<RequestBody>.fromJson(e)),
          ),
        ),
        headers: $checkedConvert(
          'headers',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Header>.fromJson(e)),
          ),
        ),
        securitySchemes: $checkedConvert(
          'securitySchemes',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<SecurityScheme>.fromJson(e)),
          ),
        ),
        links: $checkedConvert(
          'links',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Link>.fromJson(e)),
          ),
        ),
        callbacks: $checkedConvert(
          'callbacks',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Referenceable<Callback>.fromJson(e)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ComponentsToJson(
  Components instance,
) => <String, dynamic>{
  'schemas': ?instance.schemas?.map((k, e) => MapEntry(k, e.toJson())),
  'responses': ?instance.responses?.map((k, e) => MapEntry(k, e.toJson())),
  'parameters': ?instance.parameters?.map((k, e) => MapEntry(k, e.toJson())),
  'examples': ?instance.examples?.map((k, e) => MapEntry(k, e.toJson())),
  'requestBodies': ?instance.requestBodies?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'headers': ?instance.headers?.map((k, e) => MapEntry(k, e.toJson())),
  'securitySchemes': ?instance.securitySchemes?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'links': ?instance.links?.map((k, e) => MapEntry(k, e.toJson())),
  'callbacks': ?instance.callbacks?.map((k, e) => MapEntry(k, e.toJson())),
};
