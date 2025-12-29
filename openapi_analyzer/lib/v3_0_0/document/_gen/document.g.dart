// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../document.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EncodingCWProxy {
  Encoding contentType(String? contentType);

  Encoding headers(HeadersMap? headers);

  Encoding style(ParameterStyle? style);

  Encoding explode(bool? explode);

  Encoding allowReserved(bool allowReserved);

  Encoding extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Encoding(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Encoding(...).copyWith(id: 12, name: "My name")
  /// ````
  Encoding call({
    String? contentType,
    HeadersMap? headers,
    ParameterStyle? style,
    bool? explode,
    bool allowReserved,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEncoding.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEncoding.copyWith.fieldName(...)`
class _$EncodingCWProxyImpl implements _$EncodingCWProxy {
  const _$EncodingCWProxyImpl(this._value);

  final Encoding _value;

  @override
  Encoding contentType(String? contentType) => this(contentType: contentType);

  @override
  Encoding headers(HeadersMap? headers) => this(headers: headers);

  @override
  Encoding style(ParameterStyle? style) => this(style: style);

  @override
  Encoding explode(bool? explode) => this(explode: explode);

  @override
  Encoding allowReserved(bool allowReserved) =>
      this(allowReserved: allowReserved);

  @override
  Encoding extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Encoding(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Encoding(...).copyWith(id: 12, name: "My name")
  /// ````
  Encoding call({
    Object? contentType = const $CopyWithPlaceholder(),
    Object? headers = const $CopyWithPlaceholder(),
    Object? style = const $CopyWithPlaceholder(),
    Object? explode = const $CopyWithPlaceholder(),
    Object? allowReserved = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Encoding(
      contentType: contentType == const $CopyWithPlaceholder()
          ? _value.contentType
          // ignore: cast_nullable_to_non_nullable
          : contentType as String?,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as HeadersMap?,
      style: style == const $CopyWithPlaceholder()
          ? _value.style
          // ignore: cast_nullable_to_non_nullable
          : style as ParameterStyle?,
      explode: explode == const $CopyWithPlaceholder()
          ? _value.explode
          // ignore: cast_nullable_to_non_nullable
          : explode as bool?,
      allowReserved: allowReserved == const $CopyWithPlaceholder()
          ? _value.allowReserved
          // ignore: cast_nullable_to_non_nullable
          : allowReserved as bool,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $EncodingCopyWith on Encoding {
  /// Returns a callable class that can be used as follows: `instanceOfEncoding.copyWith(...)` or like so:`instanceOfEncoding.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EncodingCWProxy get copyWith => _$EncodingCWProxyImpl(this);
}

abstract class _$EncodingsMapCWProxy {
  EncodingsMap encodings(Map<String, Encoding> encodings);

  EncodingsMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EncodingsMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EncodingsMap(...).copyWith(id: 12, name: "My name")
  /// ````
  EncodingsMap call({
    Map<String, Encoding> encodings,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEncodingsMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEncodingsMap.copyWith.fieldName(...)`
class _$EncodingsMapCWProxyImpl implements _$EncodingsMapCWProxy {
  const _$EncodingsMapCWProxyImpl(this._value);

  final EncodingsMap _value;

  @override
  EncodingsMap encodings(Map<String, Encoding> encodings) =>
      this(encodings: encodings);

  @override
  EncodingsMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EncodingsMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EncodingsMap(...).copyWith(id: 12, name: "My name")
  /// ````
  EncodingsMap call({
    Object? encodings = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return EncodingsMap(
      encodings == const $CopyWithPlaceholder()
          ? _value.encodings
          // ignore: cast_nullable_to_non_nullable
          : encodings as Map<String, Encoding>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $EncodingsMapCopyWith on EncodingsMap {
  /// Returns a callable class that can be used as follows: `instanceOfEncodingsMap.copyWith(...)` or like so:`instanceOfEncodingsMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EncodingsMapCWProxy get copyWith => _$EncodingsMapCWProxyImpl(this);
}

abstract class _$HeaderCWProxy {
  Header description(String? description);

  Header required_(bool required_);

  Header deprecated(bool deprecated);

  Header allowEmptyValue(bool allowEmptyValue);

  Header style(ParameterStyle? style);

  Header explode(bool? explode);

  Header allowReserved(bool allowReserved);

  Header schema(SchemasMap? schema);

  Header example(dynamic example);

  Header examples(ExamplesMap? examples);

  Header content(MediaTypesMap? content);

  Header extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Header(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Header(...).copyWith(id: 12, name: "My name")
  /// ````
  Header call({
    String? description,
    bool required_,
    bool deprecated,
    bool allowEmptyValue,
    ParameterStyle? style,
    bool? explode,
    bool allowReserved,
    SchemasMap? schema,
    dynamic example,
    ExamplesMap? examples,
    MediaTypesMap? content,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHeader.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHeader.copyWith.fieldName(...)`
class _$HeaderCWProxyImpl implements _$HeaderCWProxy {
  const _$HeaderCWProxyImpl(this._value);

  final Header _value;

  @override
  Header description(String? description) => this(description: description);

  @override
  Header required_(bool required_) => this(required_: required_);

  @override
  Header deprecated(bool deprecated) => this(deprecated: deprecated);

  @override
  Header allowEmptyValue(bool allowEmptyValue) =>
      this(allowEmptyValue: allowEmptyValue);

  @override
  Header style(ParameterStyle? style) => this(style: style);

  @override
  Header explode(bool? explode) => this(explode: explode);

  @override
  Header allowReserved(bool allowReserved) =>
      this(allowReserved: allowReserved);

  @override
  Header schema(SchemasMap? schema) => this(schema: schema);

  @override
  Header example(dynamic example) => this(example: example);

  @override
  Header examples(ExamplesMap? examples) => this(examples: examples);

  @override
  Header content(MediaTypesMap? content) => this(content: content);

  @override
  Header extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Header(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Header(...).copyWith(id: 12, name: "My name")
  /// ````
  Header call({
    Object? description = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? deprecated = const $CopyWithPlaceholder(),
    Object? allowEmptyValue = const $CopyWithPlaceholder(),
    Object? style = const $CopyWithPlaceholder(),
    Object? explode = const $CopyWithPlaceholder(),
    Object? allowReserved = const $CopyWithPlaceholder(),
    Object? schema = const $CopyWithPlaceholder(),
    Object? example = const $CopyWithPlaceholder(),
    Object? examples = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Header(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      required_: required_ == const $CopyWithPlaceholder()
          ? _value.required_
          // ignore: cast_nullable_to_non_nullable
          : required_ as bool,
      deprecated: deprecated == const $CopyWithPlaceholder()
          ? _value.deprecated
          // ignore: cast_nullable_to_non_nullable
          : deprecated as bool,
      allowEmptyValue: allowEmptyValue == const $CopyWithPlaceholder()
          ? _value.allowEmptyValue
          // ignore: cast_nullable_to_non_nullable
          : allowEmptyValue as bool,
      style: style == const $CopyWithPlaceholder()
          ? _value.style
          // ignore: cast_nullable_to_non_nullable
          : style as ParameterStyle?,
      explode: explode == const $CopyWithPlaceholder()
          ? _value.explode
          // ignore: cast_nullable_to_non_nullable
          : explode as bool?,
      allowReserved: allowReserved == const $CopyWithPlaceholder()
          ? _value.allowReserved
          // ignore: cast_nullable_to_non_nullable
          : allowReserved as bool,
      schema: schema == const $CopyWithPlaceholder()
          ? _value.schema
          // ignore: cast_nullable_to_non_nullable
          : schema as SchemasMap?,
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as ExamplesMap?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as MediaTypesMap?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $HeaderCopyWith on Header {
  /// Returns a callable class that can be used as follows: `instanceOfHeader.copyWith(...)` or like so:`instanceOfHeader.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HeaderCWProxy get copyWith => _$HeaderCWProxyImpl(this);
}

abstract class _$HeadersMapCWProxy {
  HeadersMap headers(Map<String, Header> headers);

  HeadersMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HeadersMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HeadersMap(...).copyWith(id: 12, name: "My name")
  /// ````
  HeadersMap call({
    Map<String, Header> headers,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHeadersMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHeadersMap.copyWith.fieldName(...)`
class _$HeadersMapCWProxyImpl implements _$HeadersMapCWProxy {
  const _$HeadersMapCWProxyImpl(this._value);

  final HeadersMap _value;

  @override
  HeadersMap headers(Map<String, Header> headers) => this(headers: headers);

  @override
  HeadersMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HeadersMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HeadersMap(...).copyWith(id: 12, name: "My name")
  /// ````
  HeadersMap call({
    Object? headers = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return HeadersMap(
      headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as Map<String, Header>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $HeadersMapCopyWith on HeadersMap {
  /// Returns a callable class that can be used as follows: `instanceOfHeadersMap.copyWith(...)` or like so:`instanceOfHeadersMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HeadersMapCWProxy get copyWith => _$HeadersMapCWProxyImpl(this);
}

abstract class _$ParameterCWProxy {
  Parameter name(String name);

  Parameter in_(ParameterLocation in_);

  Parameter description(String? description);

  Parameter required_(bool required_);

  Parameter deprecated(bool deprecated);

  Parameter allowEmptyValue(bool allowEmptyValue);

  Parameter style(ParameterStyle? style);

  Parameter explode(bool? explode);

  Parameter allowReserved(bool allowReserved);

  Parameter schema(Schema? schema);

  Parameter example(dynamic example);

  Parameter examples(ExamplesMap? examples);

  Parameter content(MediaTypesMap? content);

  Parameter extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Parameter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Parameter(...).copyWith(id: 12, name: "My name")
  /// ````
  Parameter call({
    String name,
    ParameterLocation in_,
    String? description,
    bool required_,
    bool deprecated,
    bool allowEmptyValue,
    ParameterStyle? style,
    bool? explode,
    bool allowReserved,
    Schema? schema,
    dynamic example,
    ExamplesMap? examples,
    MediaTypesMap? content,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfParameter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfParameter.copyWith.fieldName(...)`
class _$ParameterCWProxyImpl implements _$ParameterCWProxy {
  const _$ParameterCWProxyImpl(this._value);

  final Parameter _value;

  @override
  Parameter name(String name) => this(name: name);

  @override
  Parameter in_(ParameterLocation in_) => this(in_: in_);

  @override
  Parameter description(String? description) => this(description: description);

  @override
  Parameter required_(bool required_) => this(required_: required_);

  @override
  Parameter deprecated(bool deprecated) => this(deprecated: deprecated);

  @override
  Parameter allowEmptyValue(bool allowEmptyValue) =>
      this(allowEmptyValue: allowEmptyValue);

  @override
  Parameter style(ParameterStyle? style) => this(style: style);

  @override
  Parameter explode(bool? explode) => this(explode: explode);

  @override
  Parameter allowReserved(bool allowReserved) =>
      this(allowReserved: allowReserved);

  @override
  Parameter schema(Schema? schema) => this(schema: schema);

  @override
  Parameter example(dynamic example) => this(example: example);

  @override
  Parameter examples(ExamplesMap? examples) => this(examples: examples);

  @override
  Parameter content(MediaTypesMap? content) => this(content: content);

  @override
  Parameter extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Parameter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Parameter(...).copyWith(id: 12, name: "My name")
  /// ````
  Parameter call({
    Object? name = const $CopyWithPlaceholder(),
    Object? in_ = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? deprecated = const $CopyWithPlaceholder(),
    Object? allowEmptyValue = const $CopyWithPlaceholder(),
    Object? style = const $CopyWithPlaceholder(),
    Object? explode = const $CopyWithPlaceholder(),
    Object? allowReserved = const $CopyWithPlaceholder(),
    Object? schema = const $CopyWithPlaceholder(),
    Object? example = const $CopyWithPlaceholder(),
    Object? examples = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Parameter(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      in_: in_ == const $CopyWithPlaceholder()
          ? _value.in_
          // ignore: cast_nullable_to_non_nullable
          : in_ as ParameterLocation,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      required_: required_ == const $CopyWithPlaceholder()
          ? _value.required_
          // ignore: cast_nullable_to_non_nullable
          : required_ as bool,
      deprecated: deprecated == const $CopyWithPlaceholder()
          ? _value.deprecated
          // ignore: cast_nullable_to_non_nullable
          : deprecated as bool,
      allowEmptyValue: allowEmptyValue == const $CopyWithPlaceholder()
          ? _value.allowEmptyValue
          // ignore: cast_nullable_to_non_nullable
          : allowEmptyValue as bool,
      style: style == const $CopyWithPlaceholder()
          ? _value.style
          // ignore: cast_nullable_to_non_nullable
          : style as ParameterStyle?,
      explode: explode == const $CopyWithPlaceholder()
          ? _value.explode
          // ignore: cast_nullable_to_non_nullable
          : explode as bool?,
      allowReserved: allowReserved == const $CopyWithPlaceholder()
          ? _value.allowReserved
          // ignore: cast_nullable_to_non_nullable
          : allowReserved as bool,
      schema: schema == const $CopyWithPlaceholder()
          ? _value.schema
          // ignore: cast_nullable_to_non_nullable
          : schema as Schema?,
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as ExamplesMap?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as MediaTypesMap?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ParameterCopyWith on Parameter {
  /// Returns a callable class that can be used as follows: `instanceOfParameter.copyWith(...)` or like so:`instanceOfParameter.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ParameterCWProxy get copyWith => _$ParameterCWProxyImpl(this);
}

abstract class _$ParametersListCWProxy {
  ParametersList parameters(List<Parameter> parameters);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ParametersList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ParametersList(...).copyWith(id: 12, name: "My name")
  /// ````
  ParametersList call({List<Parameter> parameters});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfParametersList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfParametersList.copyWith.fieldName(...)`
class _$ParametersListCWProxyImpl implements _$ParametersListCWProxy {
  const _$ParametersListCWProxyImpl(this._value);

  final ParametersList _value;

  @override
  ParametersList parameters(List<Parameter> parameters) =>
      this(parameters: parameters);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ParametersList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ParametersList(...).copyWith(id: 12, name: "My name")
  /// ````
  ParametersList call({Object? parameters = const $CopyWithPlaceholder()}) {
    return ParametersList(
      parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as List<Parameter>,
    );
  }
}

extension $ParametersListCopyWith on ParametersList {
  /// Returns a callable class that can be used as follows: `instanceOfParametersList.copyWith(...)` or like so:`instanceOfParametersList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ParametersListCWProxy get copyWith => _$ParametersListCWProxyImpl(this);
}

abstract class _$ParametersMapCWProxy {
  ParametersMap parameters(Map<String, Parameter> parameters);

  ParametersMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ParametersMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ParametersMap(...).copyWith(id: 12, name: "My name")
  /// ````
  ParametersMap call({
    Map<String, Parameter> parameters,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfParametersMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfParametersMap.copyWith.fieldName(...)`
class _$ParametersMapCWProxyImpl implements _$ParametersMapCWProxy {
  const _$ParametersMapCWProxyImpl(this._value);

  final ParametersMap _value;

  @override
  ParametersMap parameters(Map<String, Parameter> parameters) =>
      this(parameters: parameters);

  @override
  ParametersMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ParametersMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ParametersMap(...).copyWith(id: 12, name: "My name")
  /// ````
  ParametersMap call({
    Object? parameters = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ParametersMap(
      parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as Map<String, Parameter>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ParametersMapCopyWith on ParametersMap {
  /// Returns a callable class that can be used as follows: `instanceOfParametersMap.copyWith(...)` or like so:`instanceOfParametersMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ParametersMapCWProxy get copyWith => _$ParametersMapCWProxyImpl(this);
}

abstract class _$OperationCWProxy {
  Operation externalDocs(ExternalDocumentation? externalDocs);

  Operation parameters(ParametersList? parameters);

  Operation requestBody(RequestBody? requestBody);

  Operation responses(ResponsesMap responses);

  Operation callbacks(CallbacksMap? callbacks);

  Operation security(SecurityRequirementsList? security);

  Operation servers(ServerList? servers);

  Operation extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Operation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Operation(...).copyWith(id: 12, name: "My name")
  /// ````
  Operation call({
    ExternalDocumentation? externalDocs,
    ParametersList? parameters,
    RequestBody? requestBody,
    ResponsesMap responses,
    CallbacksMap? callbacks,
    SecurityRequirementsList? security,
    ServerList? servers,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOperation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOperation.copyWith.fieldName(...)`
class _$OperationCWProxyImpl implements _$OperationCWProxy {
  const _$OperationCWProxyImpl(this._value);

  final Operation _value;

  @override
  Operation externalDocs(ExternalDocumentation? externalDocs) =>
      this(externalDocs: externalDocs);

  @override
  Operation parameters(ParametersList? parameters) =>
      this(parameters: parameters);

  @override
  Operation requestBody(RequestBody? requestBody) =>
      this(requestBody: requestBody);

  @override
  Operation responses(ResponsesMap responses) => this(responses: responses);

  @override
  Operation callbacks(CallbacksMap? callbacks) => this(callbacks: callbacks);

  @override
  Operation security(SecurityRequirementsList? security) =>
      this(security: security);

  @override
  Operation servers(ServerList? servers) => this(servers: servers);

  @override
  Operation extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Operation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Operation(...).copyWith(id: 12, name: "My name")
  /// ````
  Operation call({
    Object? externalDocs = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
    Object? requestBody = const $CopyWithPlaceholder(),
    Object? responses = const $CopyWithPlaceholder(),
    Object? callbacks = const $CopyWithPlaceholder(),
    Object? security = const $CopyWithPlaceholder(),
    Object? servers = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Operation(
      externalDocs: externalDocs == const $CopyWithPlaceholder()
          ? _value.externalDocs
          // ignore: cast_nullable_to_non_nullable
          : externalDocs as ExternalDocumentation?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as ParametersList?,
      requestBody: requestBody == const $CopyWithPlaceholder()
          ? _value.requestBody
          // ignore: cast_nullable_to_non_nullable
          : requestBody as RequestBody?,
      responses: responses == const $CopyWithPlaceholder()
          ? _value.responses
          // ignore: cast_nullable_to_non_nullable
          : responses as ResponsesMap,
      callbacks: callbacks == const $CopyWithPlaceholder()
          ? _value.callbacks
          // ignore: cast_nullable_to_non_nullable
          : callbacks as CallbacksMap?,
      security: security == const $CopyWithPlaceholder()
          ? _value.security
          // ignore: cast_nullable_to_non_nullable
          : security as SecurityRequirementsList?,
      servers: servers == const $CopyWithPlaceholder()
          ? _value.servers
          // ignore: cast_nullable_to_non_nullable
          : servers as ServerList?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $OperationCopyWith on Operation {
  /// Returns a callable class that can be used as follows: `instanceOfOperation.copyWith(...)` or like so:`instanceOfOperation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OperationCWProxy get copyWith => _$OperationCWProxyImpl(this);
}

abstract class _$CallbackCWProxy {
  Callback expressions(PathsMap expressions);

  Callback extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Callback(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Callback(...).copyWith(id: 12, name: "My name")
  /// ````
  Callback call({PathsMap expressions, Map<String, dynamic>? extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCallback.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCallback.copyWith.fieldName(...)`
class _$CallbackCWProxyImpl implements _$CallbackCWProxy {
  const _$CallbackCWProxyImpl(this._value);

  final Callback _value;

  @override
  Callback expressions(PathsMap expressions) => this(expressions: expressions);

  @override
  Callback extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Callback(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Callback(...).copyWith(id: 12, name: "My name")
  /// ````
  Callback call({
    Object? expressions = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Callback(
      expressions: expressions == const $CopyWithPlaceholder()
          ? _value.expressions
          // ignore: cast_nullable_to_non_nullable
          : expressions as PathsMap,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $CallbackCopyWith on Callback {
  /// Returns a callable class that can be used as follows: `instanceOfCallback.copyWith(...)` or like so:`instanceOfCallback.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CallbackCWProxy get copyWith => _$CallbackCWProxyImpl(this);
}

abstract class _$CallbacksMapCWProxy {
  CallbacksMap callbacks(Map<String, Callback> callbacks);

  CallbacksMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CallbacksMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CallbacksMap(...).copyWith(id: 12, name: "My name")
  /// ````
  CallbacksMap call({
    Map<String, Callback> callbacks,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCallbacksMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCallbacksMap.copyWith.fieldName(...)`
class _$CallbacksMapCWProxyImpl implements _$CallbacksMapCWProxy {
  const _$CallbacksMapCWProxyImpl(this._value);

  final CallbacksMap _value;

  @override
  CallbacksMap callbacks(Map<String, Callback> callbacks) =>
      this(callbacks: callbacks);

  @override
  CallbacksMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CallbacksMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CallbacksMap(...).copyWith(id: 12, name: "My name")
  /// ````
  CallbacksMap call({
    Object? callbacks = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return CallbacksMap(
      callbacks == const $CopyWithPlaceholder()
          ? _value.callbacks
          // ignore: cast_nullable_to_non_nullable
          : callbacks as Map<String, Callback>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $CallbacksMapCopyWith on CallbacksMap {
  /// Returns a callable class that can be used as follows: `instanceOfCallbacksMap.copyWith(...)` or like so:`instanceOfCallbacksMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CallbacksMapCWProxy get copyWith => _$CallbacksMapCWProxyImpl(this);
}

abstract class _$ComponentsCWProxy {
  Components schemas(SchemasMap? schemas);

  Components responses(ResponsesMap? responses);

  Components parameters(ParametersMap? parameters);

  Components examples(ExamplesMap? examples);

  Components requestBodies(RequestBodiesMap? requestBodies);

  Components headers(HeadersMap? headers);

  Components securitySchemes(SecuritySchemesMap? securitySchemes);

  Components links(LinksMap? links);

  Components callbacks(CallbacksMap? callbacks);

  Components extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Components(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Components(...).copyWith(id: 12, name: "My name")
  /// ````
  Components call({
    SchemasMap? schemas,
    ResponsesMap? responses,
    ParametersMap? parameters,
    ExamplesMap? examples,
    RequestBodiesMap? requestBodies,
    HeadersMap? headers,
    SecuritySchemesMap? securitySchemes,
    LinksMap? links,
    CallbacksMap? callbacks,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComponents.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfComponents.copyWith.fieldName(...)`
class _$ComponentsCWProxyImpl implements _$ComponentsCWProxy {
  const _$ComponentsCWProxyImpl(this._value);

  final Components _value;

  @override
  Components schemas(SchemasMap? schemas) => this(schemas: schemas);

  @override
  Components responses(ResponsesMap? responses) => this(responses: responses);

  @override
  Components parameters(ParametersMap? parameters) =>
      this(parameters: parameters);

  @override
  Components examples(ExamplesMap? examples) => this(examples: examples);

  @override
  Components requestBodies(RequestBodiesMap? requestBodies) =>
      this(requestBodies: requestBodies);

  @override
  Components headers(HeadersMap? headers) => this(headers: headers);

  @override
  Components securitySchemes(SecuritySchemesMap? securitySchemes) =>
      this(securitySchemes: securitySchemes);

  @override
  Components links(LinksMap? links) => this(links: links);

  @override
  Components callbacks(CallbacksMap? callbacks) => this(callbacks: callbacks);

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
          : schemas as SchemasMap?,
      responses: responses == const $CopyWithPlaceholder()
          ? _value.responses
          // ignore: cast_nullable_to_non_nullable
          : responses as ResponsesMap?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as ParametersMap?,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as ExamplesMap?,
      requestBodies: requestBodies == const $CopyWithPlaceholder()
          ? _value.requestBodies
          // ignore: cast_nullable_to_non_nullable
          : requestBodies as RequestBodiesMap?,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as HeadersMap?,
      securitySchemes: securitySchemes == const $CopyWithPlaceholder()
          ? _value.securitySchemes
          // ignore: cast_nullable_to_non_nullable
          : securitySchemes as SecuritySchemesMap?,
      links: links == const $CopyWithPlaceholder()
          ? _value.links
          // ignore: cast_nullable_to_non_nullable
          : links as LinksMap?,
      callbacks: callbacks == const $CopyWithPlaceholder()
          ? _value.callbacks
          // ignore: cast_nullable_to_non_nullable
          : callbacks as CallbacksMap?,
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

abstract class _$ExamplesMapCWProxy {
  ExamplesMap examples(Map<String, Example> examples);

  ExamplesMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExamplesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExamplesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  ExamplesMap call({
    Map<String, Example> examples,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExamplesMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExamplesMap.copyWith.fieldName(...)`
class _$ExamplesMapCWProxyImpl implements _$ExamplesMapCWProxy {
  const _$ExamplesMapCWProxyImpl(this._value);

  final ExamplesMap _value;

  @override
  ExamplesMap examples(Map<String, Example> examples) =>
      this(examples: examples);

  @override
  ExamplesMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExamplesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExamplesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  ExamplesMap call({
    Object? examples = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ExamplesMap(
      examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as Map<String, Example>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ExamplesMapCopyWith on ExamplesMap {
  /// Returns a callable class that can be used as follows: `instanceOfExamplesMap.copyWith(...)` or like so:`instanceOfExamplesMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExamplesMapCWProxy get copyWith => _$ExamplesMapCWProxyImpl(this);
}

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

abstract class _$LinkCWProxy {
  Link operationRef(String? operationRef);

  Link operationId(String? operationId);

  Link parameters(Map<String, dynamic>? parameters);

  Link requestBody(dynamic requestBody);

  Link description(String? description);

  Link server(Server? server);

  Link extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Link(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Link(...).copyWith(id: 12, name: "My name")
  /// ````
  Link call({
    String? operationRef,
    String? operationId,
    Map<String, dynamic>? parameters,
    dynamic requestBody,
    String? description,
    Server? server,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLink.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLink.copyWith.fieldName(...)`
class _$LinkCWProxyImpl implements _$LinkCWProxy {
  const _$LinkCWProxyImpl(this._value);

  final Link _value;

  @override
  Link operationRef(String? operationRef) => this(operationRef: operationRef);

  @override
  Link operationId(String? operationId) => this(operationId: operationId);

  @override
  Link parameters(Map<String, dynamic>? parameters) =>
      this(parameters: parameters);

  @override
  Link requestBody(dynamic requestBody) => this(requestBody: requestBody);

  @override
  Link description(String? description) => this(description: description);

  @override
  Link server(Server? server) => this(server: server);

  @override
  Link extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Link(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Link(...).copyWith(id: 12, name: "My name")
  /// ````
  Link call({
    Object? operationRef = const $CopyWithPlaceholder(),
    Object? operationId = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
    Object? requestBody = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? server = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Link(
      operationRef: operationRef == const $CopyWithPlaceholder()
          ? _value.operationRef
          // ignore: cast_nullable_to_non_nullable
          : operationRef as String?,
      operationId: operationId == const $CopyWithPlaceholder()
          ? _value.operationId
          // ignore: cast_nullable_to_non_nullable
          : operationId as String?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as Map<String, dynamic>?,
      requestBody: requestBody == const $CopyWithPlaceholder()
          ? _value.requestBody
          // ignore: cast_nullable_to_non_nullable
          : requestBody as dynamic,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      server: server == const $CopyWithPlaceholder()
          ? _value.server
          // ignore: cast_nullable_to_non_nullable
          : server as Server?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $LinkCopyWith on Link {
  /// Returns a callable class that can be used as follows: `instanceOfLink.copyWith(...)` or like so:`instanceOfLink.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LinkCWProxy get copyWith => _$LinkCWProxyImpl(this);
}

abstract class _$LinksMapCWProxy {
  LinksMap links(Map<String, Link> links);

  LinksMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LinksMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LinksMap(...).copyWith(id: 12, name: "My name")
  /// ````
  LinksMap call({Map<String, Link> links, Map<String, dynamic>? extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLinksMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLinksMap.copyWith.fieldName(...)`
class _$LinksMapCWProxyImpl implements _$LinksMapCWProxy {
  const _$LinksMapCWProxyImpl(this._value);

  final LinksMap _value;

  @override
  LinksMap links(Map<String, Link> links) => this(links: links);

  @override
  LinksMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LinksMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LinksMap(...).copyWith(id: 12, name: "My name")
  /// ````
  LinksMap call({
    Object? links = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return LinksMap(
      links == const $CopyWithPlaceholder()
          ? _value.links
          // ignore: cast_nullable_to_non_nullable
          : links as Map<String, Link>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $LinksMapCopyWith on LinksMap {
  /// Returns a callable class that can be used as follows: `instanceOfLinksMap.copyWith(...)` or like so:`instanceOfLinksMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LinksMapCWProxy get copyWith => _$LinksMapCWProxyImpl(this);
}

abstract class _$MediaTypeCWProxy {
  MediaType schema(SchemasMap? schema);

  MediaType example(dynamic example);

  MediaType examples(ExamplesMap? examples);

  MediaType encoding(EncodingsMap? encoding);

  MediaType extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaType(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaType(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaType call({
    SchemasMap? schema,
    dynamic example,
    ExamplesMap? examples,
    EncodingsMap? encoding,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMediaType.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMediaType.copyWith.fieldName(...)`
class _$MediaTypeCWProxyImpl implements _$MediaTypeCWProxy {
  const _$MediaTypeCWProxyImpl(this._value);

  final MediaType _value;

  @override
  MediaType schema(SchemasMap? schema) => this(schema: schema);

  @override
  MediaType example(dynamic example) => this(example: example);

  @override
  MediaType examples(ExamplesMap? examples) => this(examples: examples);

  @override
  MediaType encoding(EncodingsMap? encoding) => this(encoding: encoding);

  @override
  MediaType extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaType(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaType(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaType call({
    Object? schema = const $CopyWithPlaceholder(),
    Object? example = const $CopyWithPlaceholder(),
    Object? examples = const $CopyWithPlaceholder(),
    Object? encoding = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return MediaType(
      schema: schema == const $CopyWithPlaceholder()
          ? _value.schema
          // ignore: cast_nullable_to_non_nullable
          : schema as SchemasMap?,
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as ExamplesMap?,
      encoding: encoding == const $CopyWithPlaceholder()
          ? _value.encoding
          // ignore: cast_nullable_to_non_nullable
          : encoding as EncodingsMap?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $MediaTypeCopyWith on MediaType {
  /// Returns a callable class that can be used as follows: `instanceOfMediaType.copyWith(...)` or like so:`instanceOfMediaType.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MediaTypeCWProxy get copyWith => _$MediaTypeCWProxyImpl(this);
}

abstract class _$MediaTypesMapCWProxy {
  MediaTypesMap mediaTypes(Map<String, MediaType> mediaTypes);

  MediaTypesMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaTypesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaTypesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaTypesMap call({
    Map<String, MediaType> mediaTypes,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMediaTypesMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMediaTypesMap.copyWith.fieldName(...)`
class _$MediaTypesMapCWProxyImpl implements _$MediaTypesMapCWProxy {
  const _$MediaTypesMapCWProxyImpl(this._value);

  final MediaTypesMap _value;

  @override
  MediaTypesMap mediaTypes(Map<String, MediaType> mediaTypes) =>
      this(mediaTypes: mediaTypes);

  @override
  MediaTypesMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaTypesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaTypesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaTypesMap call({
    Object? mediaTypes = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return MediaTypesMap(
      mediaTypes == const $CopyWithPlaceholder()
          ? _value.mediaTypes
          // ignore: cast_nullable_to_non_nullable
          : mediaTypes as Map<String, MediaType>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $MediaTypesMapCopyWith on MediaTypesMap {
  /// Returns a callable class that can be used as follows: `instanceOfMediaTypesMap.copyWith(...)` or like so:`instanceOfMediaTypesMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MediaTypesMapCWProxy get copyWith => _$MediaTypesMapCWProxyImpl(this);
}

abstract class _$OAuthFlowCWProxy {
  OAuthFlow authorizationUrl(String? authorizationUrl);

  OAuthFlow tokenUrl(String? tokenUrl);

  OAuthFlow refreshUrl(String? refreshUrl);

  OAuthFlow scopes(Map<String, String> scopes);

  OAuthFlow extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OAuthFlow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlow(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlow call({
    String? authorizationUrl,
    String? tokenUrl,
    String? refreshUrl,
    Map<String, String> scopes,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOAuthFlow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOAuthFlow.copyWith.fieldName(...)`
class _$OAuthFlowCWProxyImpl implements _$OAuthFlowCWProxy {
  const _$OAuthFlowCWProxyImpl(this._value);

  final OAuthFlow _value;

  @override
  OAuthFlow authorizationUrl(String? authorizationUrl) =>
      this(authorizationUrl: authorizationUrl);

  @override
  OAuthFlow tokenUrl(String? tokenUrl) => this(tokenUrl: tokenUrl);

  @override
  OAuthFlow refreshUrl(String? refreshUrl) => this(refreshUrl: refreshUrl);

  @override
  OAuthFlow scopes(Map<String, String> scopes) => this(scopes: scopes);

  @override
  OAuthFlow extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OAuthFlow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlow(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlow call({
    Object? authorizationUrl = const $CopyWithPlaceholder(),
    Object? tokenUrl = const $CopyWithPlaceholder(),
    Object? refreshUrl = const $CopyWithPlaceholder(),
    Object? scopes = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return OAuthFlow(
      authorizationUrl: authorizationUrl == const $CopyWithPlaceholder()
          ? _value.authorizationUrl
          // ignore: cast_nullable_to_non_nullable
          : authorizationUrl as String?,
      tokenUrl: tokenUrl == const $CopyWithPlaceholder()
          ? _value.tokenUrl
          // ignore: cast_nullable_to_non_nullable
          : tokenUrl as String?,
      refreshUrl: refreshUrl == const $CopyWithPlaceholder()
          ? _value.refreshUrl
          // ignore: cast_nullable_to_non_nullable
          : refreshUrl as String?,
      scopes: scopes == const $CopyWithPlaceholder()
          ? _value.scopes
          // ignore: cast_nullable_to_non_nullable
          : scopes as Map<String, String>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $OAuthFlowCopyWith on OAuthFlow {
  /// Returns a callable class that can be used as follows: `instanceOfOAuthFlow.copyWith(...)` or like so:`instanceOfOAuthFlow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OAuthFlowCWProxy get copyWith => _$OAuthFlowCWProxyImpl(this);
}

abstract class _$OAuthFlowsCWProxy {
  OAuthFlows implicit(OAuthFlow? implicit);

  OAuthFlows password(OAuthFlow? password);

  OAuthFlows clientCredentials(OAuthFlow? clientCredentials);

  OAuthFlows authorizationCode(OAuthFlow? authorizationCode);

  OAuthFlows extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OAuthFlows(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlows(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlows call({
    OAuthFlow? implicit,
    OAuthFlow? password,
    OAuthFlow? clientCredentials,
    OAuthFlow? authorizationCode,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOAuthFlows.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOAuthFlows.copyWith.fieldName(...)`
class _$OAuthFlowsCWProxyImpl implements _$OAuthFlowsCWProxy {
  const _$OAuthFlowsCWProxyImpl(this._value);

  final OAuthFlows _value;

  @override
  OAuthFlows implicit(OAuthFlow? implicit) => this(implicit: implicit);

  @override
  OAuthFlows password(OAuthFlow? password) => this(password: password);

  @override
  OAuthFlows clientCredentials(OAuthFlow? clientCredentials) =>
      this(clientCredentials: clientCredentials);

  @override
  OAuthFlows authorizationCode(OAuthFlow? authorizationCode) =>
      this(authorizationCode: authorizationCode);

  @override
  OAuthFlows extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OAuthFlows(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlows(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlows call({
    Object? implicit = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? clientCredentials = const $CopyWithPlaceholder(),
    Object? authorizationCode = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return OAuthFlows(
      implicit: implicit == const $CopyWithPlaceholder()
          ? _value.implicit
          // ignore: cast_nullable_to_non_nullable
          : implicit as OAuthFlow?,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as OAuthFlow?,
      clientCredentials: clientCredentials == const $CopyWithPlaceholder()
          ? _value.clientCredentials
          // ignore: cast_nullable_to_non_nullable
          : clientCredentials as OAuthFlow?,
      authorizationCode: authorizationCode == const $CopyWithPlaceholder()
          ? _value.authorizationCode
          // ignore: cast_nullable_to_non_nullable
          : authorizationCode as OAuthFlow?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $OAuthFlowsCopyWith on OAuthFlows {
  /// Returns a callable class that can be used as follows: `instanceOfOAuthFlows.copyWith(...)` or like so:`instanceOfOAuthFlows.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OAuthFlowsCWProxy get copyWith => _$OAuthFlowsCWProxyImpl(this);
}

abstract class _$PathItemCWProxy {
  PathItem get_(Operation? get_);

  PathItem put(Operation? put);

  PathItem post(Operation? post);

  PathItem delete(Operation? delete);

  PathItem options(Operation? options);

  PathItem head(Operation? head);

  PathItem patch(Operation? patch);

  PathItem trace(Operation? trace);

  PathItem servers(ServerList? servers);

  PathItem parameters(ParametersList? parameters);

  PathItem extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PathItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PathItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PathItem call({
    Operation? get_,
    Operation? put,
    Operation? post,
    Operation? delete,
    Operation? options,
    Operation? head,
    Operation? patch,
    Operation? trace,
    ServerList? servers,
    ParametersList? parameters,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPathItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPathItem.copyWith.fieldName(...)`
class _$PathItemCWProxyImpl implements _$PathItemCWProxy {
  const _$PathItemCWProxyImpl(this._value);

  final PathItem _value;

  @override
  PathItem get_(Operation? get_) => this(get_: get_);

  @override
  PathItem put(Operation? put) => this(put: put);

  @override
  PathItem post(Operation? post) => this(post: post);

  @override
  PathItem delete(Operation? delete) => this(delete: delete);

  @override
  PathItem options(Operation? options) => this(options: options);

  @override
  PathItem head(Operation? head) => this(head: head);

  @override
  PathItem patch(Operation? patch) => this(patch: patch);

  @override
  PathItem trace(Operation? trace) => this(trace: trace);

  @override
  PathItem servers(ServerList? servers) => this(servers: servers);

  @override
  PathItem parameters(ParametersList? parameters) =>
      this(parameters: parameters);

  @override
  PathItem extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PathItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PathItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PathItem call({
    Object? get_ = const $CopyWithPlaceholder(),
    Object? put = const $CopyWithPlaceholder(),
    Object? post = const $CopyWithPlaceholder(),
    Object? delete = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
    Object? head = const $CopyWithPlaceholder(),
    Object? patch = const $CopyWithPlaceholder(),
    Object? trace = const $CopyWithPlaceholder(),
    Object? servers = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return PathItem(
      get_: get_ == const $CopyWithPlaceholder()
          ? _value.get_
          // ignore: cast_nullable_to_non_nullable
          : get_ as Operation?,
      put: put == const $CopyWithPlaceholder()
          ? _value.put
          // ignore: cast_nullable_to_non_nullable
          : put as Operation?,
      post: post == const $CopyWithPlaceholder()
          ? _value.post
          // ignore: cast_nullable_to_non_nullable
          : post as Operation?,
      delete: delete == const $CopyWithPlaceholder()
          ? _value.delete
          // ignore: cast_nullable_to_non_nullable
          : delete as Operation?,
      options: options == const $CopyWithPlaceholder()
          ? _value.options
          // ignore: cast_nullable_to_non_nullable
          : options as Operation?,
      head: head == const $CopyWithPlaceholder()
          ? _value.head
          // ignore: cast_nullable_to_non_nullable
          : head as Operation?,
      patch: patch == const $CopyWithPlaceholder()
          ? _value.patch
          // ignore: cast_nullable_to_non_nullable
          : patch as Operation?,
      trace: trace == const $CopyWithPlaceholder()
          ? _value.trace
          // ignore: cast_nullable_to_non_nullable
          : trace as Operation?,
      servers: servers == const $CopyWithPlaceholder()
          ? _value.servers
          // ignore: cast_nullable_to_non_nullable
          : servers as ServerList?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as ParametersList?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $PathItemCopyWith on PathItem {
  /// Returns a callable class that can be used as follows: `instanceOfPathItem.copyWith(...)` or like so:`instanceOfPathItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PathItemCWProxy get copyWith => _$PathItemCWProxyImpl(this);
}

abstract class _$PathsMapCWProxy {
  PathsMap paths(Map<String, PathItem> paths);

  PathsMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PathsMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PathsMap(...).copyWith(id: 12, name: "My name")
  /// ````
  PathsMap call({
    Map<String, PathItem> paths,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPathsMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPathsMap.copyWith.fieldName(...)`
class _$PathsMapCWProxyImpl implements _$PathsMapCWProxy {
  const _$PathsMapCWProxyImpl(this._value);

  final PathsMap _value;

  @override
  PathsMap paths(Map<String, PathItem> paths) => this(paths: paths);

  @override
  PathsMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PathsMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PathsMap(...).copyWith(id: 12, name: "My name")
  /// ````
  PathsMap call({
    Object? paths = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return PathsMap(
      paths == const $CopyWithPlaceholder()
          ? _value.paths
          // ignore: cast_nullable_to_non_nullable
          : paths as Map<String, PathItem>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $PathsMapCopyWith on PathsMap {
  /// Returns a callable class that can be used as follows: `instanceOfPathsMap.copyWith(...)` or like so:`instanceOfPathsMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PathsMapCWProxy get copyWith => _$PathsMapCWProxyImpl(this);
}

abstract class _$RequestBodyCWProxy {
  RequestBody description(String? description);

  RequestBody required(bool required);

  RequestBody content(MediaTypesMap content);

  RequestBody extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestBody call({
    String? description,
    bool required,
    MediaTypesMap content,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRequestBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRequestBody.copyWith.fieldName(...)`
class _$RequestBodyCWProxyImpl implements _$RequestBodyCWProxy {
  const _$RequestBodyCWProxyImpl(this._value);

  final RequestBody _value;

  @override
  RequestBody description(String? description) =>
      this(description: description);

  @override
  RequestBody required(bool required) => this(required: required);

  @override
  RequestBody content(MediaTypesMap content) => this(content: content);

  @override
  RequestBody extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestBody call({
    Object? description = const $CopyWithPlaceholder(),
    Object? required = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return RequestBody(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      required: required == const $CopyWithPlaceholder()
          ? _value.required
          // ignore: cast_nullable_to_non_nullable
          : required as bool,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as MediaTypesMap,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $RequestBodyCopyWith on RequestBody {
  /// Returns a callable class that can be used as follows: `instanceOfRequestBody.copyWith(...)` or like so:`instanceOfRequestBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RequestBodyCWProxy get copyWith => _$RequestBodyCWProxyImpl(this);
}

abstract class _$RequestBodiesMapCWProxy {
  RequestBodiesMap requestBodies(Map<String, RequestBody> requestBodies);

  RequestBodiesMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestBodiesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestBodiesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestBodiesMap call({
    Map<String, RequestBody> requestBodies,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRequestBodiesMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRequestBodiesMap.copyWith.fieldName(...)`
class _$RequestBodiesMapCWProxyImpl implements _$RequestBodiesMapCWProxy {
  const _$RequestBodiesMapCWProxyImpl(this._value);

  final RequestBodiesMap _value;

  @override
  RequestBodiesMap requestBodies(Map<String, RequestBody> requestBodies) =>
      this(requestBodies: requestBodies);

  @override
  RequestBodiesMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestBodiesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestBodiesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestBodiesMap call({
    Object? requestBodies = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return RequestBodiesMap(
      requestBodies == const $CopyWithPlaceholder()
          ? _value.requestBodies
          // ignore: cast_nullable_to_non_nullable
          : requestBodies as Map<String, RequestBody>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $RequestBodiesMapCopyWith on RequestBodiesMap {
  /// Returns a callable class that can be used as follows: `instanceOfRequestBodiesMap.copyWith(...)` or like so:`instanceOfRequestBodiesMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RequestBodiesMapCWProxy get copyWith => _$RequestBodiesMapCWProxyImpl(this);
}

abstract class _$ResponseCWProxy {
  Response description(String? description);

  Response headers(HeadersMap? headers);

  Response content(MediaTypesMap? content);

  Response links(LinksMap? links);

  Response extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Response(...).copyWith(id: 12, name: "My name")
  /// ````
  Response call({
    String? description,
    HeadersMap? headers,
    MediaTypesMap? content,
    LinksMap? links,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResponse.copyWith.fieldName(...)`
class _$ResponseCWProxyImpl implements _$ResponseCWProxy {
  const _$ResponseCWProxyImpl(this._value);

  final Response _value;

  @override
  Response description(String? description) => this(description: description);

  @override
  Response headers(HeadersMap? headers) => this(headers: headers);

  @override
  Response content(MediaTypesMap? content) => this(content: content);

  @override
  Response links(LinksMap? links) => this(links: links);

  @override
  Response extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Response(...).copyWith(id: 12, name: "My name")
  /// ````
  Response call({
    Object? description = const $CopyWithPlaceholder(),
    Object? headers = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? links = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Response(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as HeadersMap?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as MediaTypesMap?,
      links: links == const $CopyWithPlaceholder()
          ? _value.links
          // ignore: cast_nullable_to_non_nullable
          : links as LinksMap?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ResponseCopyWith on Response {
  /// Returns a callable class that can be used as follows: `instanceOfResponse.copyWith(...)` or like so:`instanceOfResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResponseCWProxy get copyWith => _$ResponseCWProxyImpl(this);
}

abstract class _$ResponsesMapCWProxy {
  ResponsesMap responses(Map<String, Response> responses);

  ResponsesMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResponsesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResponsesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  ResponsesMap call({
    Map<String, Response> responses,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResponsesMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResponsesMap.copyWith.fieldName(...)`
class _$ResponsesMapCWProxyImpl implements _$ResponsesMapCWProxy {
  const _$ResponsesMapCWProxyImpl(this._value);

  final ResponsesMap _value;

  @override
  ResponsesMap responses(Map<String, Response> responses) =>
      this(responses: responses);

  @override
  ResponsesMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResponsesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResponsesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  ResponsesMap call({
    Object? responses = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ResponsesMap(
      responses == const $CopyWithPlaceholder()
          ? _value.responses
          // ignore: cast_nullable_to_non_nullable
          : responses as Map<String, Response>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ResponsesMapCopyWith on ResponsesMap {
  /// Returns a callable class that can be used as follows: `instanceOfResponsesMap.copyWith(...)` or like so:`instanceOfResponsesMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResponsesMapCWProxy get copyWith => _$ResponsesMapCWProxyImpl(this);
}

abstract class _$SecurityRequirementCWProxy {
  SecurityRequirement requirements(Map<String, List<String>> requirements);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityRequirement(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityRequirement(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityRequirement call({Map<String, List<String>> requirements});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecurityRequirement.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSecurityRequirement.copyWith.fieldName(...)`
class _$SecurityRequirementCWProxyImpl implements _$SecurityRequirementCWProxy {
  const _$SecurityRequirementCWProxyImpl(this._value);

  final SecurityRequirement _value;

  @override
  SecurityRequirement requirements(Map<String, List<String>> requirements) =>
      this(requirements: requirements);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityRequirement(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityRequirement(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityRequirement call({
    Object? requirements = const $CopyWithPlaceholder(),
  }) {
    return SecurityRequirement(
      requirements: requirements == const $CopyWithPlaceholder()
          ? _value.requirements
          // ignore: cast_nullable_to_non_nullable
          : requirements as Map<String, List<String>>,
    );
  }
}

extension $SecurityRequirementCopyWith on SecurityRequirement {
  /// Returns a callable class that can be used as follows: `instanceOfSecurityRequirement.copyWith(...)` or like so:`instanceOfSecurityRequirement.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SecurityRequirementCWProxy get copyWith =>
      _$SecurityRequirementCWProxyImpl(this);
}

abstract class _$SecurityRequirementsListCWProxy {
  SecurityRequirementsList requirements(List<SecurityRequirement> requirements);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityRequirementsList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityRequirementsList(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityRequirementsList call({List<SecurityRequirement> requirements});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecurityRequirementsList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSecurityRequirementsList.copyWith.fieldName(...)`
class _$SecurityRequirementsListCWProxyImpl
    implements _$SecurityRequirementsListCWProxy {
  const _$SecurityRequirementsListCWProxyImpl(this._value);

  final SecurityRequirementsList _value;

  @override
  SecurityRequirementsList requirements(
    List<SecurityRequirement> requirements,
  ) => this(requirements: requirements);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityRequirementsList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityRequirementsList(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityRequirementsList call({
    Object? requirements = const $CopyWithPlaceholder(),
  }) {
    return SecurityRequirementsList(
      requirements == const $CopyWithPlaceholder()
          ? _value.requirements
          // ignore: cast_nullable_to_non_nullable
          : requirements as List<SecurityRequirement>,
    );
  }
}

extension $SecurityRequirementsListCopyWith on SecurityRequirementsList {
  /// Returns a callable class that can be used as follows: `instanceOfSecurityRequirementsList.copyWith(...)` or like so:`instanceOfSecurityRequirementsList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SecurityRequirementsListCWProxy get copyWith =>
      _$SecurityRequirementsListCWProxyImpl(this);
}

abstract class _$SecuritySchemeCWProxy {
  SecurityScheme type(SecuritySchemeType type);

  SecurityScheme description(String? description);

  SecurityScheme name(String? name);

  SecurityScheme in_(SecuritySchemeIn? in_);

  SecurityScheme scheme(String? scheme);

  SecurityScheme bearerFormat(String? bearerFormat);

  SecurityScheme flows(OAuthFlows? flows);

  SecurityScheme openIdConnectUrl(String? openIdConnectUrl);

  SecurityScheme extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityScheme(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityScheme(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityScheme call({
    SecuritySchemeType type,
    String? description,
    String? name,
    SecuritySchemeIn? in_,
    String? scheme,
    String? bearerFormat,
    OAuthFlows? flows,
    String? openIdConnectUrl,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecurityScheme.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSecurityScheme.copyWith.fieldName(...)`
class _$SecuritySchemeCWProxyImpl implements _$SecuritySchemeCWProxy {
  const _$SecuritySchemeCWProxyImpl(this._value);

  final SecurityScheme _value;

  @override
  SecurityScheme type(SecuritySchemeType type) => this(type: type);

  @override
  SecurityScheme description(String? description) =>
      this(description: description);

  @override
  SecurityScheme name(String? name) => this(name: name);

  @override
  SecurityScheme in_(SecuritySchemeIn? in_) => this(in_: in_);

  @override
  SecurityScheme scheme(String? scheme) => this(scheme: scheme);

  @override
  SecurityScheme bearerFormat(String? bearerFormat) =>
      this(bearerFormat: bearerFormat);

  @override
  SecurityScheme flows(OAuthFlows? flows) => this(flows: flows);

  @override
  SecurityScheme openIdConnectUrl(String? openIdConnectUrl) =>
      this(openIdConnectUrl: openIdConnectUrl);

  @override
  SecurityScheme extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecurityScheme(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecurityScheme(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityScheme call({
    Object? type = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? in_ = const $CopyWithPlaceholder(),
    Object? scheme = const $CopyWithPlaceholder(),
    Object? bearerFormat = const $CopyWithPlaceholder(),
    Object? flows = const $CopyWithPlaceholder(),
    Object? openIdConnectUrl = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return SecurityScheme(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as SecuritySchemeType,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      in_: in_ == const $CopyWithPlaceholder()
          ? _value.in_
          // ignore: cast_nullable_to_non_nullable
          : in_ as SecuritySchemeIn?,
      scheme: scheme == const $CopyWithPlaceholder()
          ? _value.scheme
          // ignore: cast_nullable_to_non_nullable
          : scheme as String?,
      bearerFormat: bearerFormat == const $CopyWithPlaceholder()
          ? _value.bearerFormat
          // ignore: cast_nullable_to_non_nullable
          : bearerFormat as String?,
      flows: flows == const $CopyWithPlaceholder()
          ? _value.flows
          // ignore: cast_nullable_to_non_nullable
          : flows as OAuthFlows?,
      openIdConnectUrl: openIdConnectUrl == const $CopyWithPlaceholder()
          ? _value.openIdConnectUrl
          // ignore: cast_nullable_to_non_nullable
          : openIdConnectUrl as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $SecuritySchemeCopyWith on SecurityScheme {
  /// Returns a callable class that can be used as follows: `instanceOfSecurityScheme.copyWith(...)` or like so:`instanceOfSecurityScheme.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SecuritySchemeCWProxy get copyWith => _$SecuritySchemeCWProxyImpl(this);
}

abstract class _$SecuritySchemesMapCWProxy {
  SecuritySchemesMap securitySchemes(
    Map<String, SecurityScheme> securitySchemes,
  );

  SecuritySchemesMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecuritySchemesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecuritySchemesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  SecuritySchemesMap call({
    Map<String, SecurityScheme> securitySchemes,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecuritySchemesMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSecuritySchemesMap.copyWith.fieldName(...)`
class _$SecuritySchemesMapCWProxyImpl implements _$SecuritySchemesMapCWProxy {
  const _$SecuritySchemesMapCWProxyImpl(this._value);

  final SecuritySchemesMap _value;

  @override
  SecuritySchemesMap securitySchemes(
    Map<String, SecurityScheme> securitySchemes,
  ) => this(securitySchemes: securitySchemes);

  @override
  SecuritySchemesMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecuritySchemesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecuritySchemesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  SecuritySchemesMap call({
    Object? securitySchemes = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return SecuritySchemesMap(
      securitySchemes == const $CopyWithPlaceholder()
          ? _value.securitySchemes
          // ignore: cast_nullable_to_non_nullable
          : securitySchemes as Map<String, SecurityScheme>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $SecuritySchemesMapCopyWith on SecuritySchemesMap {
  /// Returns a callable class that can be used as follows: `instanceOfSecuritySchemesMap.copyWith(...)` or like so:`instanceOfSecuritySchemesMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SecuritySchemesMapCWProxy get copyWith =>
      _$SecuritySchemesMapCWProxyImpl(this);
}

abstract class _$ServerCWProxy {
  Server url(String url);

  Server description(String? description);

  Server variables(ServerVariablesMap? variables);

  Server extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Server(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Server(...).copyWith(id: 12, name: "My name")
  /// ````
  Server call({
    String url,
    String? description,
    ServerVariablesMap? variables,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServer.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfServer.copyWith.fieldName(...)`
class _$ServerCWProxyImpl implements _$ServerCWProxy {
  const _$ServerCWProxyImpl(this._value);

  final Server _value;

  @override
  Server url(String url) => this(url: url);

  @override
  Server description(String? description) => this(description: description);

  @override
  Server variables(ServerVariablesMap? variables) => this(variables: variables);

  @override
  Server extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Server(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Server(...).copyWith(id: 12, name: "My name")
  /// ````
  Server call({
    Object? url = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? variables = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Server(
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      variables: variables == const $CopyWithPlaceholder()
          ? _value.variables
          // ignore: cast_nullable_to_non_nullable
          : variables as ServerVariablesMap?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ServerCopyWith on Server {
  /// Returns a callable class that can be used as follows: `instanceOfServer.copyWith(...)` or like so:`instanceOfServer.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerCWProxy get copyWith => _$ServerCWProxyImpl(this);
}

abstract class _$ServerListCWProxy {
  ServerList servers(List<Server> servers);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ServerList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ServerList(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerList call({List<Server> servers});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServerList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfServerList.copyWith.fieldName(...)`
class _$ServerListCWProxyImpl implements _$ServerListCWProxy {
  const _$ServerListCWProxyImpl(this._value);

  final ServerList _value;

  @override
  ServerList servers(List<Server> servers) => this(servers: servers);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ServerList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ServerList(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerList call({Object? servers = const $CopyWithPlaceholder()}) {
    return ServerList(
      servers == const $CopyWithPlaceholder()
          ? _value.servers
          // ignore: cast_nullable_to_non_nullable
          : servers as List<Server>,
    );
  }
}

extension $ServerListCopyWith on ServerList {
  /// Returns a callable class that can be used as follows: `instanceOfServerList.copyWith(...)` or like so:`instanceOfServerList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerListCWProxy get copyWith => _$ServerListCWProxyImpl(this);
}

abstract class _$ServerVariableCWProxy {
  ServerVariable enum_(List<String>? enum_);

  ServerVariable default_(String default_);

  ServerVariable description(String? description);

  ServerVariable extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ServerVariable(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ServerVariable(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerVariable call({
    List<String>? enum_,
    String default_,
    String? description,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServerVariable.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfServerVariable.copyWith.fieldName(...)`
class _$ServerVariableCWProxyImpl implements _$ServerVariableCWProxy {
  const _$ServerVariableCWProxyImpl(this._value);

  final ServerVariable _value;

  @override
  ServerVariable enum_(List<String>? enum_) => this(enum_: enum_);

  @override
  ServerVariable default_(String default_) => this(default_: default_);

  @override
  ServerVariable description(String? description) =>
      this(description: description);

  @override
  ServerVariable extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ServerVariable(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ServerVariable(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerVariable call({
    Object? enum_ = const $CopyWithPlaceholder(),
    Object? default_ = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ServerVariable(
      enum_: enum_ == const $CopyWithPlaceholder()
          ? _value.enum_
          // ignore: cast_nullable_to_non_nullable
          : enum_ as List<String>?,
      default_: default_ == const $CopyWithPlaceholder()
          ? _value.default_
          // ignore: cast_nullable_to_non_nullable
          : default_ as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ServerVariableCopyWith on ServerVariable {
  /// Returns a callable class that can be used as follows: `instanceOfServerVariable.copyWith(...)` or like so:`instanceOfServerVariable.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerVariableCWProxy get copyWith => _$ServerVariableCWProxyImpl(this);
}

abstract class _$ServerVariablesMapCWProxy {
  ServerVariablesMap variables(Map<String, ServerVariable> variables);

  ServerVariablesMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ServerVariablesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ServerVariablesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerVariablesMap call({
    Map<String, ServerVariable> variables,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServerVariablesMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfServerVariablesMap.copyWith.fieldName(...)`
class _$ServerVariablesMapCWProxyImpl implements _$ServerVariablesMapCWProxy {
  const _$ServerVariablesMapCWProxyImpl(this._value);

  final ServerVariablesMap _value;

  @override
  ServerVariablesMap variables(Map<String, ServerVariable> variables) =>
      this(variables: variables);

  @override
  ServerVariablesMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ServerVariablesMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ServerVariablesMap(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerVariablesMap call({
    Object? variables = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ServerVariablesMap(
      variables == const $CopyWithPlaceholder()
          ? _value.variables
          // ignore: cast_nullable_to_non_nullable
          : variables as Map<String, ServerVariable>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $ServerVariablesMapCopyWith on ServerVariablesMap {
  /// Returns a callable class that can be used as follows: `instanceOfServerVariablesMap.copyWith(...)` or like so:`instanceOfServerVariablesMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerVariablesMapCWProxy get copyWith =>
      _$ServerVariablesMapCWProxyImpl(this);
}

abstract class _$TagCWProxy {
  Tag name(String name);

  Tag description(String? description);

  Tag externalDocs(ExternalDocumentation? externalDocs);

  Tag extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Tag(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Tag(...).copyWith(id: 12, name: "My name")
  /// ````
  Tag call({
    String name,
    String? description,
    ExternalDocumentation? externalDocs,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTag.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTag.copyWith.fieldName(...)`
class _$TagCWProxyImpl implements _$TagCWProxy {
  const _$TagCWProxyImpl(this._value);

  final Tag _value;

  @override
  Tag name(String name) => this(name: name);

  @override
  Tag description(String? description) => this(description: description);

  @override
  Tag externalDocs(ExternalDocumentation? externalDocs) =>
      this(externalDocs: externalDocs);

  @override
  Tag extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Tag(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Tag(...).copyWith(id: 12, name: "My name")
  /// ````
  Tag call({
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? externalDocs = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Tag(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      externalDocs: externalDocs == const $CopyWithPlaceholder()
          ? _value.externalDocs
          // ignore: cast_nullable_to_non_nullable
          : externalDocs as ExternalDocumentation?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $TagCopyWith on Tag {
  /// Returns a callable class that can be used as follows: `instanceOfTag.copyWith(...)` or like so:`instanceOfTag.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TagCWProxy get copyWith => _$TagCWProxyImpl(this);
}

abstract class _$TagsListCWProxy {
  TagsList tags(List<Tag> tags);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TagsList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TagsList(...).copyWith(id: 12, name: "My name")
  /// ````
  TagsList call({List<Tag> tags});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTagsList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTagsList.copyWith.fieldName(...)`
class _$TagsListCWProxyImpl implements _$TagsListCWProxy {
  const _$TagsListCWProxyImpl(this._value);

  final TagsList _value;

  @override
  TagsList tags(List<Tag> tags) => this(tags: tags);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TagsList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TagsList(...).copyWith(id: 12, name: "My name")
  /// ````
  TagsList call({Object? tags = const $CopyWithPlaceholder()}) {
    return TagsList(
      tags == const $CopyWithPlaceholder()
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as List<Tag>,
    );
  }
}

extension $TagsListCopyWith on TagsList {
  /// Returns a callable class that can be used as follows: `instanceOfTagsList.copyWith(...)` or like so:`instanceOfTagsList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TagsListCWProxy get copyWith => _$TagsListCWProxyImpl(this);
}

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

abstract class _$OpenApiDocumentCWProxy {
  OpenApiDocument openapi(String openapi);

  OpenApiDocument info(Info info);

  OpenApiDocument servers(ServerList? servers);

  OpenApiDocument paths(PathsMap paths);

  OpenApiDocument components(Components? components);

  OpenApiDocument security(SecurityRequirementsList? security);

  OpenApiDocument tags(TagsList? tags);

  OpenApiDocument externalDocs(ExternalDocumentation? externalDocs);

  OpenApiDocument extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OpenApiDocument(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OpenApiDocument(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenApiDocument call({
    String openapi,
    Info info,
    ServerList? servers,
    PathsMap paths,
    Components? components,
    SecurityRequirementsList? security,
    TagsList? tags,
    ExternalDocumentation? externalDocs,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOpenApiDocument.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOpenApiDocument.copyWith.fieldName(...)`
class _$OpenApiDocumentCWProxyImpl implements _$OpenApiDocumentCWProxy {
  const _$OpenApiDocumentCWProxyImpl(this._value);

  final OpenApiDocument _value;

  @override
  OpenApiDocument openapi(String openapi) => this(openapi: openapi);

  @override
  OpenApiDocument info(Info info) => this(info: info);

  @override
  OpenApiDocument servers(ServerList? servers) => this(servers: servers);

  @override
  OpenApiDocument paths(PathsMap paths) => this(paths: paths);

  @override
  OpenApiDocument components(Components? components) =>
      this(components: components);

  @override
  OpenApiDocument security(SecurityRequirementsList? security) =>
      this(security: security);

  @override
  OpenApiDocument tags(TagsList? tags) => this(tags: tags);

  @override
  OpenApiDocument externalDocs(ExternalDocumentation? externalDocs) =>
      this(externalDocs: externalDocs);

  @override
  OpenApiDocument extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OpenApiDocument(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OpenApiDocument(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenApiDocument call({
    Object? openapi = const $CopyWithPlaceholder(),
    Object? info = const $CopyWithPlaceholder(),
    Object? servers = const $CopyWithPlaceholder(),
    Object? paths = const $CopyWithPlaceholder(),
    Object? components = const $CopyWithPlaceholder(),
    Object? security = const $CopyWithPlaceholder(),
    Object? tags = const $CopyWithPlaceholder(),
    Object? externalDocs = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return OpenApiDocument(
      openapi: openapi == const $CopyWithPlaceholder()
          ? _value.openapi
          // ignore: cast_nullable_to_non_nullable
          : openapi as String,
      info: info == const $CopyWithPlaceholder()
          ? _value.info
          // ignore: cast_nullable_to_non_nullable
          : info as Info,
      servers: servers == const $CopyWithPlaceholder()
          ? _value.servers
          // ignore: cast_nullable_to_non_nullable
          : servers as ServerList?,
      paths: paths == const $CopyWithPlaceholder()
          ? _value.paths
          // ignore: cast_nullable_to_non_nullable
          : paths as PathsMap,
      components: components == const $CopyWithPlaceholder()
          ? _value.components
          // ignore: cast_nullable_to_non_nullable
          : components as Components?,
      security: security == const $CopyWithPlaceholder()
          ? _value.security
          // ignore: cast_nullable_to_non_nullable
          : security as SecurityRequirementsList?,
      tags: tags == const $CopyWithPlaceholder()
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as TagsList?,
      externalDocs: externalDocs == const $CopyWithPlaceholder()
          ? _value.externalDocs
          // ignore: cast_nullable_to_non_nullable
          : externalDocs as ExternalDocumentation?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $OpenApiDocumentCopyWith on OpenApiDocument {
  /// Returns a callable class that can be used as follows: `instanceOfOpenApiDocument.copyWith(...)` or like so:`instanceOfOpenApiDocument.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OpenApiDocumentCWProxy get copyWith => _$OpenApiDocumentCWProxyImpl(this);
}

abstract class _$SchemaCWProxy {
  Schema title(String? title);

  Schema description(String? description);

  Schema default_(dynamic default_);

  Schema type(SchemaType? type);

  Schema format(String? format);

  Schema multipleOf(num? multipleOf);

  Schema maximum(num? maximum);

  Schema exclusiveMaximum(num? exclusiveMaximum);

  Schema minimum(num? minimum);

  Schema exclusiveMinimum(num? exclusiveMinimum);

  Schema maxLength(int? maxLength);

  Schema minLength(int? minLength);

  Schema pattern(String? pattern);

  Schema maxItems(int? maxItems);

  Schema minItems(int? minItems);

  Schema uniqueItems(bool uniqueItems);

  Schema items(Schema? items);

  Schema maxProperties(int? maxProperties);

  Schema minProperties(int? minProperties);

  Schema required_(List<String>? required_);

  Schema properties(SchemasMap? properties);

  Schema additionalPropertiesAllowed(bool? additionalPropertiesAllowed);

  Schema additionalProperties(Schema? additionalProperties);

  Schema allOf(SchemasList? allOf);

  Schema oneOf(SchemasList? oneOf);

  Schema anyOf(SchemasList? anyOf);

  Schema enum_(List<dynamic>? enum_);

  Schema nullable(bool nullable);

  Schema discriminator(Discriminator? discriminator);

  Schema readOnly(bool readOnly);

  Schema writeOnly(bool writeOnly);

  Schema xml(XML? xml);

  Schema externalDocs(ExternalDocumentation? externalDocs);

  Schema example(dynamic example);

  Schema deprecated(bool deprecated);

  Schema extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Schema(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Schema(...).copyWith(id: 12, name: "My name")
  /// ````
  Schema call({
    String? title,
    String? description,
    dynamic default_,
    SchemaType? type,
    String? format,
    num? multipleOf,
    num? maximum,
    num? exclusiveMaximum,
    num? minimum,
    num? exclusiveMinimum,
    int? maxLength,
    int? minLength,
    String? pattern,
    int? maxItems,
    int? minItems,
    bool uniqueItems,
    Schema? items,
    int? maxProperties,
    int? minProperties,
    List<String>? required_,
    SchemasMap? properties,
    bool? additionalPropertiesAllowed,
    Schema? additionalProperties,
    SchemasList? allOf,
    SchemasList? oneOf,
    SchemasList? anyOf,
    List<dynamic>? enum_,
    bool nullable,
    Discriminator? discriminator,
    bool readOnly,
    bool writeOnly,
    XML? xml,
    ExternalDocumentation? externalDocs,
    dynamic example,
    bool deprecated,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSchema.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSchema.copyWith.fieldName(...)`
class _$SchemaCWProxyImpl implements _$SchemaCWProxy {
  const _$SchemaCWProxyImpl(this._value);

  final Schema _value;

  @override
  Schema title(String? title) => this(title: title);

  @override
  Schema description(String? description) => this(description: description);

  @override
  Schema default_(dynamic default_) => this(default_: default_);

  @override
  Schema type(SchemaType? type) => this(type: type);

  @override
  Schema format(String? format) => this(format: format);

  @override
  Schema multipleOf(num? multipleOf) => this(multipleOf: multipleOf);

  @override
  Schema maximum(num? maximum) => this(maximum: maximum);

  @override
  Schema exclusiveMaximum(num? exclusiveMaximum) =>
      this(exclusiveMaximum: exclusiveMaximum);

  @override
  Schema minimum(num? minimum) => this(minimum: minimum);

  @override
  Schema exclusiveMinimum(num? exclusiveMinimum) =>
      this(exclusiveMinimum: exclusiveMinimum);

  @override
  Schema maxLength(int? maxLength) => this(maxLength: maxLength);

  @override
  Schema minLength(int? minLength) => this(minLength: minLength);

  @override
  Schema pattern(String? pattern) => this(pattern: pattern);

  @override
  Schema maxItems(int? maxItems) => this(maxItems: maxItems);

  @override
  Schema minItems(int? minItems) => this(minItems: minItems);

  @override
  Schema uniqueItems(bool uniqueItems) => this(uniqueItems: uniqueItems);

  @override
  Schema items(Schema? items) => this(items: items);

  @override
  Schema maxProperties(int? maxProperties) =>
      this(maxProperties: maxProperties);

  @override
  Schema minProperties(int? minProperties) =>
      this(minProperties: minProperties);

  @override
  Schema required_(List<String>? required_) => this(required_: required_);

  @override
  Schema properties(SchemasMap? properties) => this(properties: properties);

  @override
  Schema additionalPropertiesAllowed(bool? additionalPropertiesAllowed) =>
      this(additionalPropertiesAllowed: additionalPropertiesAllowed);

  @override
  Schema additionalProperties(Schema? additionalProperties) =>
      this(additionalProperties: additionalProperties);

  @override
  Schema allOf(SchemasList? allOf) => this(allOf: allOf);

  @override
  Schema oneOf(SchemasList? oneOf) => this(oneOf: oneOf);

  @override
  Schema anyOf(SchemasList? anyOf) => this(anyOf: anyOf);

  @override
  Schema enum_(List<dynamic>? enum_) => this(enum_: enum_);

  @override
  Schema nullable(bool nullable) => this(nullable: nullable);

  @override
  Schema discriminator(Discriminator? discriminator) =>
      this(discriminator: discriminator);

  @override
  Schema readOnly(bool readOnly) => this(readOnly: readOnly);

  @override
  Schema writeOnly(bool writeOnly) => this(writeOnly: writeOnly);

  @override
  Schema xml(XML? xml) => this(xml: xml);

  @override
  Schema externalDocs(ExternalDocumentation? externalDocs) =>
      this(externalDocs: externalDocs);

  @override
  Schema example(dynamic example) => this(example: example);

  @override
  Schema deprecated(bool deprecated) => this(deprecated: deprecated);

  @override
  Schema extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Schema(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Schema(...).copyWith(id: 12, name: "My name")
  /// ````
  Schema call({
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? default_ = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? format = const $CopyWithPlaceholder(),
    Object? multipleOf = const $CopyWithPlaceholder(),
    Object? maximum = const $CopyWithPlaceholder(),
    Object? exclusiveMaximum = const $CopyWithPlaceholder(),
    Object? minimum = const $CopyWithPlaceholder(),
    Object? exclusiveMinimum = const $CopyWithPlaceholder(),
    Object? maxLength = const $CopyWithPlaceholder(),
    Object? minLength = const $CopyWithPlaceholder(),
    Object? pattern = const $CopyWithPlaceholder(),
    Object? maxItems = const $CopyWithPlaceholder(),
    Object? minItems = const $CopyWithPlaceholder(),
    Object? uniqueItems = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? maxProperties = const $CopyWithPlaceholder(),
    Object? minProperties = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? properties = const $CopyWithPlaceholder(),
    Object? additionalPropertiesAllowed = const $CopyWithPlaceholder(),
    Object? additionalProperties = const $CopyWithPlaceholder(),
    Object? allOf = const $CopyWithPlaceholder(),
    Object? oneOf = const $CopyWithPlaceholder(),
    Object? anyOf = const $CopyWithPlaceholder(),
    Object? enum_ = const $CopyWithPlaceholder(),
    Object? nullable = const $CopyWithPlaceholder(),
    Object? discriminator = const $CopyWithPlaceholder(),
    Object? readOnly = const $CopyWithPlaceholder(),
    Object? writeOnly = const $CopyWithPlaceholder(),
    Object? xml = const $CopyWithPlaceholder(),
    Object? externalDocs = const $CopyWithPlaceholder(),
    Object? example = const $CopyWithPlaceholder(),
    Object? deprecated = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return Schema(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      default_: default_ == const $CopyWithPlaceholder()
          ? _value.default_
          // ignore: cast_nullable_to_non_nullable
          : default_ as dynamic,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as SchemaType?,
      format: format == const $CopyWithPlaceholder()
          ? _value.format
          // ignore: cast_nullable_to_non_nullable
          : format as String?,
      multipleOf: multipleOf == const $CopyWithPlaceholder()
          ? _value.multipleOf
          // ignore: cast_nullable_to_non_nullable
          : multipleOf as num?,
      maximum: maximum == const $CopyWithPlaceholder()
          ? _value.maximum
          // ignore: cast_nullable_to_non_nullable
          : maximum as num?,
      exclusiveMaximum: exclusiveMaximum == const $CopyWithPlaceholder()
          ? _value.exclusiveMaximum
          // ignore: cast_nullable_to_non_nullable
          : exclusiveMaximum as num?,
      minimum: minimum == const $CopyWithPlaceholder()
          ? _value.minimum
          // ignore: cast_nullable_to_non_nullable
          : minimum as num?,
      exclusiveMinimum: exclusiveMinimum == const $CopyWithPlaceholder()
          ? _value.exclusiveMinimum
          // ignore: cast_nullable_to_non_nullable
          : exclusiveMinimum as num?,
      maxLength: maxLength == const $CopyWithPlaceholder()
          ? _value.maxLength
          // ignore: cast_nullable_to_non_nullable
          : maxLength as int?,
      minLength: minLength == const $CopyWithPlaceholder()
          ? _value.minLength
          // ignore: cast_nullable_to_non_nullable
          : minLength as int?,
      pattern: pattern == const $CopyWithPlaceholder()
          ? _value.pattern
          // ignore: cast_nullable_to_non_nullable
          : pattern as String?,
      maxItems: maxItems == const $CopyWithPlaceholder()
          ? _value.maxItems
          // ignore: cast_nullable_to_non_nullable
          : maxItems as int?,
      minItems: minItems == const $CopyWithPlaceholder()
          ? _value.minItems
          // ignore: cast_nullable_to_non_nullable
          : minItems as int?,
      uniqueItems: uniqueItems == const $CopyWithPlaceholder()
          ? _value.uniqueItems
          // ignore: cast_nullable_to_non_nullable
          : uniqueItems as bool,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as Schema?,
      maxProperties: maxProperties == const $CopyWithPlaceholder()
          ? _value.maxProperties
          // ignore: cast_nullable_to_non_nullable
          : maxProperties as int?,
      minProperties: minProperties == const $CopyWithPlaceholder()
          ? _value.minProperties
          // ignore: cast_nullable_to_non_nullable
          : minProperties as int?,
      required_: required_ == const $CopyWithPlaceholder()
          ? _value.required_
          // ignore: cast_nullable_to_non_nullable
          : required_ as List<String>?,
      properties: properties == const $CopyWithPlaceholder()
          ? _value.properties
          // ignore: cast_nullable_to_non_nullable
          : properties as SchemasMap?,
      additionalPropertiesAllowed:
          additionalPropertiesAllowed == const $CopyWithPlaceholder()
          ? _value.additionalPropertiesAllowed
          // ignore: cast_nullable_to_non_nullable
          : additionalPropertiesAllowed as bool?,
      additionalProperties: additionalProperties == const $CopyWithPlaceholder()
          ? _value.additionalProperties
          // ignore: cast_nullable_to_non_nullable
          : additionalProperties as Schema?,
      allOf: allOf == const $CopyWithPlaceholder()
          ? _value.allOf
          // ignore: cast_nullable_to_non_nullable
          : allOf as SchemasList?,
      oneOf: oneOf == const $CopyWithPlaceholder()
          ? _value.oneOf
          // ignore: cast_nullable_to_non_nullable
          : oneOf as SchemasList?,
      anyOf: anyOf == const $CopyWithPlaceholder()
          ? _value.anyOf
          // ignore: cast_nullable_to_non_nullable
          : anyOf as SchemasList?,
      enum_: enum_ == const $CopyWithPlaceholder()
          ? _value.enum_
          // ignore: cast_nullable_to_non_nullable
          : enum_ as List<dynamic>?,
      nullable: nullable == const $CopyWithPlaceholder()
          ? _value.nullable
          // ignore: cast_nullable_to_non_nullable
          : nullable as bool,
      discriminator: discriminator == const $CopyWithPlaceholder()
          ? _value.discriminator
          // ignore: cast_nullable_to_non_nullable
          : discriminator as Discriminator?,
      readOnly: readOnly == const $CopyWithPlaceholder()
          ? _value.readOnly
          // ignore: cast_nullable_to_non_nullable
          : readOnly as bool,
      writeOnly: writeOnly == const $CopyWithPlaceholder()
          ? _value.writeOnly
          // ignore: cast_nullable_to_non_nullable
          : writeOnly as bool,
      xml: xml == const $CopyWithPlaceholder()
          ? _value.xml
          // ignore: cast_nullable_to_non_nullable
          : xml as XML?,
      externalDocs: externalDocs == const $CopyWithPlaceholder()
          ? _value.externalDocs
          // ignore: cast_nullable_to_non_nullable
          : externalDocs as ExternalDocumentation?,
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      deprecated: deprecated == const $CopyWithPlaceholder()
          ? _value.deprecated
          // ignore: cast_nullable_to_non_nullable
          : deprecated as bool,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $SchemaCopyWith on Schema {
  /// Returns a callable class that can be used as follows: `instanceOfSchema.copyWith(...)` or like so:`instanceOfSchema.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SchemaCWProxy get copyWith => _$SchemaCWProxyImpl(this);
}

abstract class _$SchemasMapCWProxy {
  SchemasMap schemas(Map<String, Schema> schemas);

  SchemasMap extensions(Map<String, dynamic>? extensions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SchemasMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SchemasMap(...).copyWith(id: 12, name: "My name")
  /// ````
  SchemasMap call({
    Map<String, Schema> schemas,
    Map<String, dynamic>? extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSchemasMap.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSchemasMap.copyWith.fieldName(...)`
class _$SchemasMapCWProxyImpl implements _$SchemasMapCWProxy {
  const _$SchemasMapCWProxyImpl(this._value);

  final SchemasMap _value;

  @override
  SchemasMap schemas(Map<String, Schema> schemas) => this(schemas: schemas);

  @override
  SchemasMap extensions(Map<String, dynamic>? extensions) =>
      this(extensions: extensions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SchemasMap(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SchemasMap(...).copyWith(id: 12, name: "My name")
  /// ````
  SchemasMap call({
    Object? schemas = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return SchemasMap(
      schemas == const $CopyWithPlaceholder()
          ? _value.schemas
          // ignore: cast_nullable_to_non_nullable
          : schemas as Map<String, Schema>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>?,
    );
  }
}

extension $SchemasMapCopyWith on SchemasMap {
  /// Returns a callable class that can be used as follows: `instanceOfSchemasMap.copyWith(...)` or like so:`instanceOfSchemasMap.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SchemasMapCWProxy get copyWith => _$SchemasMapCWProxyImpl(this);
}

abstract class _$SchemasListCWProxy {
  SchemasList schemas(List<Schema> schemas);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SchemasList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SchemasList(...).copyWith(id: 12, name: "My name")
  /// ````
  SchemasList call({List<Schema> schemas});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSchemasList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSchemasList.copyWith.fieldName(...)`
class _$SchemasListCWProxyImpl implements _$SchemasListCWProxy {
  const _$SchemasListCWProxyImpl(this._value);

  final SchemasList _value;

  @override
  SchemasList schemas(List<Schema> schemas) => this(schemas: schemas);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SchemasList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SchemasList(...).copyWith(id: 12, name: "My name")
  /// ````
  SchemasList call({Object? schemas = const $CopyWithPlaceholder()}) {
    return SchemasList(
      schemas == const $CopyWithPlaceholder()
          ? _value.schemas
          // ignore: cast_nullable_to_non_nullable
          : schemas as List<Schema>,
    );
  }
}

extension $SchemasListCopyWith on SchemasList {
  /// Returns a callable class that can be used as follows: `instanceOfSchemasList.copyWith(...)` or like so:`instanceOfSchemasList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SchemasListCWProxy get copyWith => _$SchemasListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Encoding _$EncodingFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Encoding', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'contentType',
          'headers',
          'style',
          'explode',
          'allowReserved',
        ],
      );
      final val = Encoding(
        contentType: $checkedConvert('contentType', (v) => v as String?),
        headers: $checkedConvert(
          'headers',
          (v) =>
              v == null ? null : HeadersMap.fromJson(v as Map<String, dynamic>),
        ),
        style: $checkedConvert(
          'style',
          (v) => $enumDecodeNullable(_$ParameterStyleEnumMap, v),
        ),
        explode: $checkedConvert('explode', (v) => v as bool?),
        allowReserved: $checkedConvert('allowReserved', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$EncodingToJson(Encoding instance) => <String, dynamic>{
  'contentType': ?instance.contentType,
  'headers': ?instance.headers?.toJson(),
  'style': ?_$ParameterStyleEnumMap[instance.style],
  'explode': ?instance.explode,
  'allowReserved': instance.allowReserved,
};

const _$ParameterStyleEnumMap = {
  ParameterStyle.matrix: 'matrix',
  ParameterStyle.label: 'label',
  ParameterStyle.form: 'form',
  ParameterStyle.simple: 'simple',
  ParameterStyle.spaceDelimited: 'spaceDelimited',
  ParameterStyle.pipeDelimited: 'pipeDelimited',
  ParameterStyle.deepObject: 'deepObject',
};

Header _$HeaderFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Header', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'description',
      'required_',
      'deprecated',
      'allowEmptyValue',
      'style',
      'explode',
      'allowReserved',
      'schema',
      'example',
      'examples',
      'content',
    ],
  );
  final val = Header(
    description: $checkedConvert('description', (v) => v as String?),
    required_: $checkedConvert('required_', (v) => v as bool),
    deprecated: $checkedConvert('deprecated', (v) => v as bool),
    allowEmptyValue: $checkedConvert('allowEmptyValue', (v) => v as bool),
    style: $checkedConvert(
      'style',
      (v) => $enumDecodeNullable(_$ParameterStyleEnumMap, v),
    ),
    explode: $checkedConvert('explode', (v) => v as bool?),
    allowReserved: $checkedConvert('allowReserved', (v) => v as bool),
    schema: $checkedConvert(
      'schema',
      (v) => v == null ? null : SchemasMap.fromJson(v as Map<String, dynamic>),
    ),
    example: $checkedConvert('example', (v) => v),
    examples: $checkedConvert(
      'examples',
      (v) => v == null ? null : ExamplesMap.fromJson(v as Map<String, dynamic>),
    ),
    content: $checkedConvert(
      'content',
      (v) =>
          v == null ? null : MediaTypesMap.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
  'description': ?instance.description,
  'required_': instance.required_,
  'deprecated': instance.deprecated,
  'allowEmptyValue': instance.allowEmptyValue,
  'style': ?_$ParameterStyleEnumMap[instance.style],
  'explode': ?instance.explode,
  'allowReserved': instance.allowReserved,
  'schema': ?instance.schema?.toJson(),
  'example': ?instance.example,
  'examples': ?instance.examples?.toJson(),
  'content': ?instance.content?.toJson(),
};

Parameter _$ParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Parameter', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'name',
      'in_',
      'description',
      'required_',
      'deprecated',
      'allowEmptyValue',
      'style',
      'explode',
      'allowReserved',
      'schema',
      'example',
      'examples',
      'content',
      'extensions',
    ],
  );
  final val = Parameter(
    name: $checkedConvert('name', (v) => v as String),
    in_: $checkedConvert(
      'in_',
      (v) => $enumDecode(_$ParameterLocationEnumMap, v),
    ),
    description: $checkedConvert('description', (v) => v as String?),
    required_: $checkedConvert('required_', (v) => v as bool),
    deprecated: $checkedConvert('deprecated', (v) => v as bool),
    allowEmptyValue: $checkedConvert('allowEmptyValue', (v) => v as bool),
    style: $checkedConvert(
      'style',
      (v) => $enumDecodeNullable(_$ParameterStyleEnumMap, v),
    ),
    explode: $checkedConvert('explode', (v) => v as bool?),
    allowReserved: $checkedConvert('allowReserved', (v) => v as bool),
    schema: $checkedConvert(
      'schema',
      (v) => v == null ? null : Schema.fromJson(v as Map<String, dynamic>),
    ),
    example: $checkedConvert('example', (v) => v),
    examples: $checkedConvert(
      'examples',
      (v) => v == null ? null : ExamplesMap.fromJson(v as Map<String, dynamic>),
    ),
    content: $checkedConvert(
      'content',
      (v) =>
          v == null ? null : MediaTypesMap.fromJson(v as Map<String, dynamic>),
    ),
    extensions: $checkedConvert(
      'extensions',
      (v) => v as Map<String, dynamic>?,
    ),
  );
  return val;
});

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
  'name': instance.name,
  'in_': _$ParameterLocationEnumMap[instance.in_]!,
  'description': ?instance.description,
  'required_': instance.required_,
  'deprecated': instance.deprecated,
  'allowEmptyValue': instance.allowEmptyValue,
  'style': ?_$ParameterStyleEnumMap[instance.style],
  'explode': ?instance.explode,
  'allowReserved': instance.allowReserved,
  'schema': ?instance.schema?.toJson(),
  'example': ?instance.example,
  'examples': ?instance.examples?.toJson(),
  'content': ?instance.content?.toJson(),
  'extensions': ?instance.extensions,
};

const _$ParameterLocationEnumMap = {
  ParameterLocation.query: 'query',
  ParameterLocation.header: 'header',
  ParameterLocation.path: 'path',
  ParameterLocation.cookie: 'cookie',
};

Operation _$OperationFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Operation',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'externalDocs',
        'parameters',
        'requestBody',
        'responses',
        'callbacks',
        'security',
        'servers',
      ],
    );
    final val = Operation(
      externalDocs: $checkedConvert(
        'externalDocs',
        (v) => v == null
            ? null
            : ExternalDocumentation.fromJson(v as Map<String, dynamic>),
      ),
      parameters: $checkedConvert(
        'parameters',
        (v) => v == null ? null : ParametersList.fromJson(v as List<dynamic>),
      ),
      requestBody: $checkedConvert(
        'requestBody',
        (v) =>
            v == null ? null : RequestBody.fromJson(v as Map<String, dynamic>),
      ),
      responses: $checkedConvert(
        'responses',
        (v) => ResponsesMap.fromJson(v as Map<String, dynamic>),
      ),
      callbacks: $checkedConvert(
        'callbacks',
        (v) =>
            v == null ? null : CallbacksMap.fromJson(v as Map<String, dynamic>),
      ),
      security: $checkedConvert(
        'security',
        (v) => v == null
            ? null
            : SecurityRequirementsList.fromJson(v as List<dynamic>),
      ),
      servers: $checkedConvert(
        'servers',
        (v) => v == null ? null : ServerList.fromJson(v as List<dynamic>),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$OperationToJson(Operation instance) => <String, dynamic>{
  'externalDocs': ?instance.externalDocs?.toJson(),
  'parameters': ?instance.parameters?.toJson(),
  'requestBody': ?instance.requestBody?.toJson(),
  'responses': instance.responses.toJson(),
  'callbacks': ?instance.callbacks?.toJson(),
  'security': ?instance.security?.toJson(),
  'servers': ?instance.servers?.toJson(),
};

Callback _$CallbackFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Callback', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['expressions']);
      final val = Callback(
        expressions: $checkedConvert(
          'expressions',
          (v) => PathsMap.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CallbackToJson(Callback instance) => <String, dynamic>{
  'expressions': instance.expressions.toJson(),
};

Components _$ComponentsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Components', json, ($checkedConvert) {
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
      (v) => v == null ? null : SchemasMap.fromJson(v as Map<String, dynamic>),
    ),
    responses: $checkedConvert(
      'responses',
      (v) =>
          v == null ? null : ResponsesMap.fromJson(v as Map<String, dynamic>),
    ),
    parameters: $checkedConvert(
      'parameters',
      (v) =>
          v == null ? null : ParametersMap.fromJson(v as Map<String, dynamic>),
    ),
    examples: $checkedConvert(
      'examples',
      (v) => v == null ? null : ExamplesMap.fromJson(v as Map<String, dynamic>),
    ),
    requestBodies: $checkedConvert(
      'requestBodies',
      (v) => v == null
          ? null
          : RequestBodiesMap.fromJson(v as Map<String, dynamic>),
    ),
    headers: $checkedConvert(
      'headers',
      (v) => v == null ? null : HeadersMap.fromJson(v as Map<String, dynamic>),
    ),
    securitySchemes: $checkedConvert(
      'securitySchemes',
      (v) => v == null
          ? null
          : SecuritySchemesMap.fromJson(v as Map<String, dynamic>),
    ),
    links: $checkedConvert(
      'links',
      (v) => v == null ? null : LinksMap.fromJson(v as Map<String, dynamic>),
    ),
    callbacks: $checkedConvert(
      'callbacks',
      (v) =>
          v == null ? null : CallbacksMap.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$ComponentsToJson(Components instance) =>
    <String, dynamic>{
      'schemas': ?instance.schemas?.toJson(),
      'responses': ?instance.responses?.toJson(),
      'parameters': ?instance.parameters?.toJson(),
      'examples': ?instance.examples?.toJson(),
      'requestBodies': ?instance.requestBodies?.toJson(),
      'headers': ?instance.headers?.toJson(),
      'securitySchemes': ?instance.securitySchemes?.toJson(),
      'links': ?instance.links?.toJson(),
      'callbacks': ?instance.callbacks?.toJson(),
    };

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

Link _$LinkFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Link', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'operationRef',
          'operationId',
          'parameters',
          'requestBody',
          'description',
          'server',
        ],
      );
      final val = Link(
        operationRef: $checkedConvert('operationRef', (v) => v as String?),
        operationId: $checkedConvert('operationId', (v) => v as String?),
        parameters: $checkedConvert(
          'parameters',
          (v) => v as Map<String, dynamic>?,
        ),
        requestBody: $checkedConvert('requestBody', (v) => v),
        description: $checkedConvert('description', (v) => v as String?),
        server: $checkedConvert(
          'server',
          (v) => v == null ? null : Server.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
  'operationRef': ?instance.operationRef,
  'operationId': ?instance.operationId,
  'parameters': ?instance.parameters,
  'requestBody': ?instance.requestBody,
  'description': ?instance.description,
  'server': ?instance.server?.toJson(),
};

MediaType _$MediaTypeFromJson(Map<String, dynamic> json) => $checkedCreate(
  'MediaType',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const ['schema', 'example', 'examples', 'encoding'],
    );
    final val = MediaType(
      schema: $checkedConvert(
        'schema',
        (v) =>
            v == null ? null : SchemasMap.fromJson(v as Map<String, dynamic>),
      ),
      example: $checkedConvert('example', (v) => v),
      examples: $checkedConvert(
        'examples',
        (v) =>
            v == null ? null : ExamplesMap.fromJson(v as Map<String, dynamic>),
      ),
      encoding: $checkedConvert(
        'encoding',
        (v) =>
            v == null ? null : EncodingsMap.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$MediaTypeToJson(MediaType instance) => <String, dynamic>{
  'schema': ?instance.schema?.toJson(),
  'example': ?instance.example,
  'examples': ?instance.examples?.toJson(),
  'encoding': ?instance.encoding?.toJson(),
};

OAuthFlow _$OAuthFlowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OAuthFlow', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['authorizationUrl', 'tokenUrl', 'refreshUrl', 'scopes'],
  );
  final val = OAuthFlow(
    authorizationUrl: $checkedConvert('authorizationUrl', (v) => v as String?),
    tokenUrl: $checkedConvert('tokenUrl', (v) => v as String?),
    refreshUrl: $checkedConvert('refreshUrl', (v) => v as String?),
    scopes: $checkedConvert(
      'scopes',
      (v) => Map<String, String>.from(v as Map),
    ),
  );
  return val;
});

Map<String, dynamic> _$OAuthFlowToJson(OAuthFlow instance) => <String, dynamic>{
  'authorizationUrl': ?instance.authorizationUrl,
  'tokenUrl': ?instance.tokenUrl,
  'refreshUrl': ?instance.refreshUrl,
  'scopes': instance.scopes,
};

OAuthFlows _$OAuthFlowsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OAuthFlows', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'implicit',
          'password',
          'clientCredentials',
          'authorizationCode',
        ],
      );
      final val = OAuthFlows(
        implicit: $checkedConvert(
          'implicit',
          (v) =>
              v == null ? null : OAuthFlow.fromJson(v as Map<String, dynamic>),
        ),
        password: $checkedConvert(
          'password',
          (v) =>
              v == null ? null : OAuthFlow.fromJson(v as Map<String, dynamic>),
        ),
        clientCredentials: $checkedConvert(
          'clientCredentials',
          (v) =>
              v == null ? null : OAuthFlow.fromJson(v as Map<String, dynamic>),
        ),
        authorizationCode: $checkedConvert(
          'authorizationCode',
          (v) =>
              v == null ? null : OAuthFlow.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OAuthFlowsToJson(OAuthFlows instance) =>
    <String, dynamic>{
      'implicit': ?instance.implicit?.toJson(),
      'password': ?instance.password?.toJson(),
      'clientCredentials': ?instance.clientCredentials?.toJson(),
      'authorizationCode': ?instance.authorizationCode?.toJson(),
    };

PathItem _$PathItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PathItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'get_',
          'put',
          'post',
          'delete',
          'options',
          'head',
          'patch',
          'trace',
          'servers',
          'parameters',
        ],
      );
      final val = PathItem(
        get_: $checkedConvert(
          'get_',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        put: $checkedConvert(
          'put',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        post: $checkedConvert(
          'post',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        delete: $checkedConvert(
          'delete',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        options: $checkedConvert(
          'options',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        head: $checkedConvert(
          'head',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        patch: $checkedConvert(
          'patch',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        trace: $checkedConvert(
          'trace',
          (v) =>
              v == null ? null : Operation.fromJson(v as Map<String, dynamic>),
        ),
        servers: $checkedConvert(
          'servers',
          (v) => v == null ? null : ServerList.fromJson(v as List<dynamic>),
        ),
        parameters: $checkedConvert(
          'parameters',
          (v) => v == null ? null : ParametersList.fromJson(v as List<dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PathItemToJson(PathItem instance) => <String, dynamic>{
  'get_': ?instance.get_?.toJson(),
  'put': ?instance.put?.toJson(),
  'post': ?instance.post?.toJson(),
  'delete': ?instance.delete?.toJson(),
  'options': ?instance.options?.toJson(),
  'head': ?instance.head?.toJson(),
  'patch': ?instance.patch?.toJson(),
  'trace': ?instance.trace?.toJson(),
  'servers': ?instance.servers?.toJson(),
  'parameters': ?instance.parameters?.toJson(),
};

RequestBody _$RequestBodyFromJson(Map<String, dynamic> json) => $checkedCreate(
  'RequestBody',
  json,
  ($checkedConvert) {
    $checkKeys(json, allowedKeys: const ['description', 'required', 'content']);
    final val = RequestBody(
      description: $checkedConvert('description', (v) => v as String?),
      required: $checkedConvert('required', (v) => v as bool),
      content: $checkedConvert(
        'content',
        (v) => MediaTypesMap.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$RequestBodyToJson(RequestBody instance) =>
    <String, dynamic>{
      'description': ?instance.description,
      'required': instance.required,
      'content': instance.content.toJson(),
    };

Response _$ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Response', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['description', 'headers', 'content', 'links'],
      );
      final val = Response(
        description: $checkedConvert('description', (v) => v as String?),
        headers: $checkedConvert(
          'headers',
          (v) =>
              v == null ? null : HeadersMap.fromJson(v as Map<String, dynamic>),
        ),
        content: $checkedConvert(
          'content',
          (v) => v == null
              ? null
              : MediaTypesMap.fromJson(v as Map<String, dynamic>),
        ),
        links: $checkedConvert(
          'links',
          (v) =>
              v == null ? null : LinksMap.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
  'description': ?instance.description,
  'headers': ?instance.headers?.toJson(),
  'content': ?instance.content?.toJson(),
  'links': ?instance.links?.toJson(),
};

SecurityRequirement _$SecurityRequirementFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SecurityRequirement', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['requirements']);
      final val = SecurityRequirement(
        requirements: $checkedConvert(
          'requirements',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>).map((e) => e as String).toList(),
            ),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SecurityRequirementToJson(
  SecurityRequirement instance,
) => <String, dynamic>{'requirements': instance.requirements};

SecurityScheme _$SecuritySchemeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SecurityScheme', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'type',
          'description',
          'name',
          'in_',
          'scheme',
          'bearerFormat',
          'flows',
          'openIdConnectUrl',
        ],
      );
      final val = SecurityScheme(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$SecuritySchemeTypeEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        in_: $checkedConvert(
          'in_',
          (v) => $enumDecodeNullable(_$SecuritySchemeInEnumMap, v),
        ),
        scheme: $checkedConvert('scheme', (v) => v as String?),
        bearerFormat: $checkedConvert('bearerFormat', (v) => v as String?),
        flows: $checkedConvert(
          'flows',
          (v) =>
              v == null ? null : OAuthFlows.fromJson(v as Map<String, dynamic>),
        ),
        openIdConnectUrl: $checkedConvert(
          'openIdConnectUrl',
          (v) => v as String?,
        ),
      );
      return val;
    });

Map<String, dynamic> _$SecuritySchemeToJson(SecurityScheme instance) =>
    <String, dynamic>{
      'type': _$SecuritySchemeTypeEnumMap[instance.type]!,
      'description': ?instance.description,
      'name': ?instance.name,
      'in_': ?_$SecuritySchemeInEnumMap[instance.in_],
      'scheme': ?instance.scheme,
      'bearerFormat': ?instance.bearerFormat,
      'flows': ?instance.flows?.toJson(),
      'openIdConnectUrl': ?instance.openIdConnectUrl,
    };

const _$SecuritySchemeTypeEnumMap = {
  SecuritySchemeType.apiKey: 'apiKey',
  SecuritySchemeType.http: 'http',
  SecuritySchemeType.oauth2: 'oauth2',
  SecuritySchemeType.openIdConnect: 'openIdConnect',
};

const _$SecuritySchemeInEnumMap = {
  SecuritySchemeIn.query: 'query',
  SecuritySchemeIn.header: 'header',
  SecuritySchemeIn.cookie: 'cookie',
};

Server _$ServerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Server', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['url', 'description', 'variables']);
      final val = Server(
        url: $checkedConvert('url', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        variables: $checkedConvert(
          'variables',
          (v) => v == null
              ? null
              : ServerVariablesMap.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
  'url': instance.url,
  'description': ?instance.description,
  'variables': ?instance.variables?.toJson(),
};

ServerVariable _$ServerVariableFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ServerVariable', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['enum_', 'default_', 'description']);
      final val = ServerVariable(
        enum_: $checkedConvert(
          'enum_',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        default_: $checkedConvert('default_', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ServerVariableToJson(ServerVariable instance) =>
    <String, dynamic>{
      'enum_': ?instance.enum_,
      'default_': instance.default_,
      'description': ?instance.description,
    };

Tag _$TagFromJson(Map<String, dynamic> json) => $checkedCreate('Tag', json, (
  $checkedConvert,
) {
  $checkKeys(json, allowedKeys: const ['name', 'description', 'externalDocs']);
  final val = Tag(
    name: $checkedConvert('name', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String?),
    externalDocs: $checkedConvert(
      'externalDocs',
      (v) => v == null
          ? null
          : ExternalDocumentation.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
  'name': instance.name,
  'description': ?instance.description,
  'externalDocs': ?instance.externalDocs?.toJson(),
};

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
    attribute: $checkedConvert('attribute', (v) => v as bool),
    wrapped: $checkedConvert('wrapped', (v) => v as bool),
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

OpenApiDocument _$OpenApiDocumentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OpenApiDocument', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'openapi',
          'info',
          'servers',
          'paths',
          'components',
          'security',
          'tags',
          'externalDocs',
        ],
      );
      final val = OpenApiDocument(
        openapi: $checkedConvert('openapi', (v) => v as String),
        info: $checkedConvert(
          'info',
          (v) => Info.fromJson(v as Map<String, dynamic>),
        ),
        servers: $checkedConvert(
          'servers',
          (v) => v == null ? null : ServerList.fromJson(v as List<dynamic>),
        ),
        paths: $checkedConvert(
          'paths',
          (v) => PathsMap.fromJson(v as Map<String, dynamic>),
        ),
        components: $checkedConvert(
          'components',
          (v) =>
              v == null ? null : Components.fromJson(v as Map<String, dynamic>),
        ),
        security: $checkedConvert(
          'security',
          (v) => v == null
              ? null
              : SecurityRequirementsList.fromJson(v as List<dynamic>),
        ),
        tags: $checkedConvert(
          'tags',
          (v) => v == null ? null : TagsList.fromJson(v as List<dynamic>),
        ),
        externalDocs: $checkedConvert(
          'externalDocs',
          (v) => v == null
              ? null
              : ExternalDocumentation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OpenApiDocumentToJson(OpenApiDocument instance) =>
    <String, dynamic>{
      'openapi': instance.openapi,
      'info': instance.info.toJson(),
      'servers': ?instance.servers?.toJson(),
      'paths': instance.paths.toJson(),
      'components': ?instance.components?.toJson(),
      'security': ?instance.security?.toJson(),
      'tags': ?instance.tags?.toJson(),
      'externalDocs': ?instance.externalDocs?.toJson(),
    };

Schema _$SchemaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Schema', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'title',
          'description',
          'default_',
          'type',
          'format',
          'multipleOf',
          'maximum',
          'exclusiveMaximum',
          'minimum',
          'exclusiveMinimum',
          'maxLength',
          'minLength',
          'pattern',
          'maxItems',
          'minItems',
          'uniqueItems',
          'items',
          'maxProperties',
          'minProperties',
          'required_',
          'properties',
          'additionalPropertiesAllowed',
          'additionalProperties',
          'allOf',
          'oneOf',
          'anyOf',
          'enum_',
          'nullable',
          'discriminator',
          'readOnly',
          'writeOnly',
          'xml',
          'externalDocs',
          'example',
          'deprecated',
        ],
      );
      final val = Schema(
        title: $checkedConvert('title', (v) => v as String?),
        description: $checkedConvert('description', (v) => v as String?),
        default_: $checkedConvert('default_', (v) => v),
        type: $checkedConvert(
          'type',
          (v) => $enumDecodeNullable(_$SchemaTypeEnumMap, v),
        ),
        format: $checkedConvert('format', (v) => v as String?),
        multipleOf: $checkedConvert('multipleOf', (v) => v as num?),
        maximum: $checkedConvert('maximum', (v) => v as num?),
        exclusiveMaximum: $checkedConvert('exclusiveMaximum', (v) => v as num?),
        minimum: $checkedConvert('minimum', (v) => v as num?),
        exclusiveMinimum: $checkedConvert('exclusiveMinimum', (v) => v as num?),
        maxLength: $checkedConvert('maxLength', (v) => (v as num?)?.toInt()),
        minLength: $checkedConvert('minLength', (v) => (v as num?)?.toInt()),
        pattern: $checkedConvert('pattern', (v) => v as String?),
        maxItems: $checkedConvert('maxItems', (v) => (v as num?)?.toInt()),
        minItems: $checkedConvert('minItems', (v) => (v as num?)?.toInt()),
        uniqueItems: $checkedConvert('uniqueItems', (v) => v as bool),
        items: $checkedConvert(
          'items',
          (v) => v == null ? null : Schema.fromJson(v as Map<String, dynamic>),
        ),
        maxProperties: $checkedConvert(
          'maxProperties',
          (v) => (v as num?)?.toInt(),
        ),
        minProperties: $checkedConvert(
          'minProperties',
          (v) => (v as num?)?.toInt(),
        ),
        required_: $checkedConvert(
          'required_',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        properties: $checkedConvert(
          'properties',
          (v) =>
              v == null ? null : SchemasMap.fromJson(v as Map<String, dynamic>),
        ),
        additionalPropertiesAllowed: $checkedConvert(
          'additionalPropertiesAllowed',
          (v) => v as bool?,
        ),
        additionalProperties: $checkedConvert(
          'additionalProperties',
          (v) => v == null ? null : Schema.fromJson(v as Map<String, dynamic>),
        ),
        allOf: $checkedConvert(
          'allOf',
          (v) => v == null ? null : SchemasList.fromJson(v as List<dynamic>),
        ),
        oneOf: $checkedConvert(
          'oneOf',
          (v) => v == null ? null : SchemasList.fromJson(v as List<dynamic>),
        ),
        anyOf: $checkedConvert(
          'anyOf',
          (v) => v == null ? null : SchemasList.fromJson(v as List<dynamic>),
        ),
        enum_: $checkedConvert('enum_', (v) => v as List<dynamic>?),
        nullable: $checkedConvert('nullable', (v) => v as bool),
        discriminator: $checkedConvert(
          'discriminator',
          (v) => v == null
              ? null
              : Discriminator.fromJson(v as Map<String, dynamic>),
        ),
        readOnly: $checkedConvert('readOnly', (v) => v as bool),
        writeOnly: $checkedConvert('writeOnly', (v) => v as bool),
        xml: $checkedConvert(
          'xml',
          (v) => v == null ? null : XML.fromJson(v as Map<String, dynamic>),
        ),
        externalDocs: $checkedConvert(
          'externalDocs',
          (v) => v == null
              ? null
              : ExternalDocumentation.fromJson(v as Map<String, dynamic>),
        ),
        example: $checkedConvert('example', (v) => v),
        deprecated: $checkedConvert('deprecated', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$SchemaToJson(Schema instance) => <String, dynamic>{
  'title': ?instance.title,
  'description': ?instance.description,
  'default_': ?instance.default_,
  'type': ?_$SchemaTypeEnumMap[instance.type],
  'format': ?instance.format,
  'multipleOf': ?instance.multipleOf,
  'maximum': ?instance.maximum,
  'exclusiveMaximum': ?instance.exclusiveMaximum,
  'minimum': ?instance.minimum,
  'exclusiveMinimum': ?instance.exclusiveMinimum,
  'maxLength': ?instance.maxLength,
  'minLength': ?instance.minLength,
  'pattern': ?instance.pattern,
  'maxItems': ?instance.maxItems,
  'minItems': ?instance.minItems,
  'uniqueItems': instance.uniqueItems,
  'items': ?instance.items?.toJson(),
  'maxProperties': ?instance.maxProperties,
  'minProperties': ?instance.minProperties,
  'required_': ?instance.required_,
  'properties': ?instance.properties?.toJson(),
  'additionalPropertiesAllowed': ?instance.additionalPropertiesAllowed,
  'additionalProperties': ?instance.additionalProperties?.toJson(),
  'allOf': ?instance.allOf?.toJson(),
  'oneOf': ?instance.oneOf?.toJson(),
  'anyOf': ?instance.anyOf?.toJson(),
  'enum_': ?instance.enum_,
  'nullable': instance.nullable,
  'discriminator': ?instance.discriminator?.toJson(),
  'readOnly': instance.readOnly,
  'writeOnly': instance.writeOnly,
  'xml': ?instance.xml?.toJson(),
  'externalDocs': ?instance.externalDocs?.toJson(),
  'example': ?instance.example,
  'deprecated': instance.deprecated,
};

const _$SchemaTypeEnumMap = {
  SchemaType.string: 'string',
  SchemaType.number: 'number',
  SchemaType.integer: 'integer',
  SchemaType.boolean: 'boolean',
  SchemaType.array: 'array',
  SchemaType.object: 'object',
  SchemaType.null_: 'null_',
  SchemaType.unknown: 'unknown',
  SchemaType.multiType: 'multiType',
};
