// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../document.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EncodingCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Encoding(...).copyWith(id: 12, name: "My name")
  /// ````
  Encoding call({
    String? contentType,
    Map<String, Ref<Header>>? headers,
    ParameterStyle? style,
    bool? explode,
    bool allowReserved,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEncoding.copyWith(...)`.
class _$EncodingCWProxyImpl implements _$EncodingCWProxy {
  const _$EncodingCWProxyImpl(this._value);

  final Encoding _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : headers as Map<String, Ref<Header>>?,
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $EncodingCopyWith on Encoding {
  /// Returns a callable class that can be used as follows: `instanceOfEncoding.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$EncodingCWProxy get copyWith => _$EncodingCWProxyImpl(this);
}

abstract class _$EncodingNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// EncodingNode(...).copyWith(id: 12, name: "My name")
  /// ````
  EncodingNode call({
    String? contentType,
    ParameterStyle? style,
    bool? explode,
    bool allowReserved,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEncodingNode.copyWith(...)`.
class _$EncodingNodeCWProxyImpl implements _$EncodingNodeCWProxy {
  const _$EncodingNodeCWProxyImpl(this._value);

  final EncodingNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// EncodingNode(...).copyWith(id: 12, name: "My name")
  /// ````
  EncodingNode call({
    Object? contentType = const $CopyWithPlaceholder(),
    Object? style = const $CopyWithPlaceholder(),
    Object? explode = const $CopyWithPlaceholder(),
    Object? allowReserved = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return EncodingNode(
      contentType: contentType == const $CopyWithPlaceholder()
          ? _value.contentType
          // ignore: cast_nullable_to_non_nullable
          : contentType as String?,
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $EncodingNodeCopyWith on EncodingNode {
  /// Returns a callable class that can be used as follows: `instanceOfEncodingNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$EncodingNodeCWProxy get copyWith => _$EncodingNodeCWProxyImpl(this);
}

abstract class _$HeaderCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Ref<Schema>? schema,
    dynamic example,
    Map<String, Ref<Example>>? examples,
    Map<String, MediaType>? content,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHeader.copyWith(...)`.
class _$HeaderCWProxyImpl implements _$HeaderCWProxy {
  const _$HeaderCWProxyImpl(this._value);

  final Header _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : schema as Ref<Schema>?,
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as Map<String, Ref<Example>>?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as Map<String, MediaType>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $HeaderCopyWith on Header {
  /// Returns a callable class that can be used as follows: `instanceOfHeader.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$HeaderCWProxy get copyWith => _$HeaderCWProxyImpl(this);
}

abstract class _$HeaderNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// HeaderNode(...).copyWith(id: 12, name: "My name")
  /// ````
  HeaderNode call({
    String? description,
    bool required_,
    bool deprecated,
    bool allowEmptyValue,
    ParameterStyle? style,
    bool? explode,
    bool allowReserved,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHeaderNode.copyWith(...)`.
class _$HeaderNodeCWProxyImpl implements _$HeaderNodeCWProxy {
  const _$HeaderNodeCWProxyImpl(this._value);

  final HeaderNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// HeaderNode(...).copyWith(id: 12, name: "My name")
  /// ````
  HeaderNode call({
    Object? description = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? deprecated = const $CopyWithPlaceholder(),
    Object? allowEmptyValue = const $CopyWithPlaceholder(),
    Object? style = const $CopyWithPlaceholder(),
    Object? explode = const $CopyWithPlaceholder(),
    Object? allowReserved = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return HeaderNode(
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
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $HeaderNodeCopyWith on HeaderNode {
  /// Returns a callable class that can be used as follows: `instanceOfHeaderNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$HeaderNodeCWProxy get copyWith => _$HeaderNodeCWProxyImpl(this);
}

abstract class _$ParameterCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Ref<Schema>? schema,
    dynamic example,
    Map<String, Ref<Example>>? examples,
    Map<String, Ref<MediaType>>? content,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfParameter.copyWith(...)`.
class _$ParameterCWProxyImpl implements _$ParameterCWProxy {
  const _$ParameterCWProxyImpl(this._value);

  final Parameter _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : schema as Ref<Schema>?,
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as Map<String, Ref<Example>>?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as Map<String, Ref<MediaType>>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ParameterCopyWith on Parameter {
  /// Returns a callable class that can be used as follows: `instanceOfParameter.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ParameterCWProxy get copyWith => _$ParameterCWProxyImpl(this);
}

abstract class _$ParameterNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ParameterNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ParameterNode call({
    String name,
    ParameterLocation in_,
    String? description,
    bool required_,
    bool deprecated,
    bool allowEmptyValue,
    ParameterStyle? style,
    bool? explode,
    bool allowReserved,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfParameterNode.copyWith(...)`.
class _$ParameterNodeCWProxyImpl implements _$ParameterNodeCWProxy {
  const _$ParameterNodeCWProxyImpl(this._value);

  final ParameterNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ParameterNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ParameterNode call({
    Object? name = const $CopyWithPlaceholder(),
    Object? in_ = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? deprecated = const $CopyWithPlaceholder(),
    Object? allowEmptyValue = const $CopyWithPlaceholder(),
    Object? style = const $CopyWithPlaceholder(),
    Object? explode = const $CopyWithPlaceholder(),
    Object? allowReserved = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ParameterNode(
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
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ParameterNodeCopyWith on ParameterNode {
  /// Returns a callable class that can be used as follows: `instanceOfParameterNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ParameterNodeCWProxy get copyWith => _$ParameterNodeCWProxyImpl(this);
}

abstract class _$OperationCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Operation(...).copyWith(id: 12, name: "My name")
  /// ````
  Operation call({
    ExternalDocumentation? externalDocs,
    List<Ref<Parameter>>? parameters,
    Ref<RequestBody>? requestBody,
    Map<String, Ref<Response>> responses,
    Map<String, Ref<Callback>>? callbacks,
    List<Ref<SecurityRequirement>>? security,
    List<Server>? servers,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOperation.copyWith(...)`.
class _$OperationCWProxyImpl implements _$OperationCWProxy {
  const _$OperationCWProxyImpl(this._value);

  final Operation _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : parameters as List<Ref<Parameter>>?,
      requestBody: requestBody == const $CopyWithPlaceholder()
          ? _value.requestBody
          // ignore: cast_nullable_to_non_nullable
          : requestBody as Ref<RequestBody>?,
      responses: responses == const $CopyWithPlaceholder()
          ? _value.responses
          // ignore: cast_nullable_to_non_nullable
          : responses as Map<String, Ref<Response>>,
      callbacks: callbacks == const $CopyWithPlaceholder()
          ? _value.callbacks
          // ignore: cast_nullable_to_non_nullable
          : callbacks as Map<String, Ref<Callback>>?,
      security: security == const $CopyWithPlaceholder()
          ? _value.security
          // ignore: cast_nullable_to_non_nullable
          : security as List<Ref<SecurityRequirement>>?,
      servers: servers == const $CopyWithPlaceholder()
          ? _value.servers
          // ignore: cast_nullable_to_non_nullable
          : servers as List<Server>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $OperationCopyWith on Operation {
  /// Returns a callable class that can be used as follows: `instanceOfOperation.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$OperationCWProxy get copyWith => _$OperationCWProxyImpl(this);
}

abstract class _$OperationNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// OperationNode(...).copyWith(id: 12, name: "My name")
  /// ````
  OperationNode call({Map<String, dynamic> extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOperationNode.copyWith(...)`.
class _$OperationNodeCWProxyImpl implements _$OperationNodeCWProxy {
  const _$OperationNodeCWProxyImpl(this._value);

  final OperationNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// OperationNode(...).copyWith(id: 12, name: "My name")
  /// ````
  OperationNode call({Object? extensions = const $CopyWithPlaceholder()}) {
    return OperationNode(
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $OperationNodeCopyWith on OperationNode {
  /// Returns a callable class that can be used as follows: `instanceOfOperationNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$OperationNodeCWProxy get copyWith => _$OperationNodeCWProxyImpl(this);
}

abstract class _$CallbackCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Callback(...).copyWith(id: 12, name: "My name")
  /// ````
  Callback call({
    Map<String, Ref<PathItem>> expressions,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCallback.copyWith(...)`.
class _$CallbackCWProxyImpl implements _$CallbackCWProxy {
  const _$CallbackCWProxyImpl(this._value);

  final Callback _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : expressions as Map<String, Ref<PathItem>>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $CallbackCopyWith on Callback {
  /// Returns a callable class that can be used as follows: `instanceOfCallback.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$CallbackCWProxy get copyWith => _$CallbackCWProxyImpl(this);
}

abstract class _$CallbackNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// CallbackNode(...).copyWith(id: 12, name: "My name")
  /// ````
  CallbackNode call({Map<String, dynamic> extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCallbackNode.copyWith(...)`.
class _$CallbackNodeCWProxyImpl implements _$CallbackNodeCWProxy {
  const _$CallbackNodeCWProxyImpl(this._value);

  final CallbackNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// CallbackNode(...).copyWith(id: 12, name: "My name")
  /// ````
  CallbackNode call({Object? extensions = const $CopyWithPlaceholder()}) {
    return CallbackNode(
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $CallbackNodeCopyWith on CallbackNode {
  /// Returns a callable class that can be used as follows: `instanceOfCallbackNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$CallbackNodeCWProxy get copyWith => _$CallbackNodeCWProxyImpl(this);
}

abstract class _$ComponentsCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Components(...).copyWith(id: 12, name: "My name")
  /// ````
  Components call({
    Map<String, Ref<Schema>>? schemas,
    Map<String, Ref<Response>>? responses,
    Map<String, Ref<Parameter>>? parameters,
    Map<String, Ref<Example>>? examples,
    Map<String, Ref<RequestBody>>? requestBodies,
    Map<String, Ref<Header>>? headers,
    Map<String, SecurityScheme>? securitySchemes,
    Map<String, Ref<Link>>? links,
    Map<String, Ref<Callback>>? callbacks,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComponents.copyWith(...)`.
class _$ComponentsCWProxyImpl implements _$ComponentsCWProxy {
  const _$ComponentsCWProxyImpl(this._value);

  final Components _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : schemas as Map<String, Ref<Schema>>?,
      responses: responses == const $CopyWithPlaceholder()
          ? _value.responses
          // ignore: cast_nullable_to_non_nullable
          : responses as Map<String, Ref<Response>>?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as Map<String, Ref<Parameter>>?,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as Map<String, Ref<Example>>?,
      requestBodies: requestBodies == const $CopyWithPlaceholder()
          ? _value.requestBodies
          // ignore: cast_nullable_to_non_nullable
          : requestBodies as Map<String, Ref<RequestBody>>?,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as Map<String, Ref<Header>>?,
      securitySchemes: securitySchemes == const $CopyWithPlaceholder()
          ? _value.securitySchemes
          // ignore: cast_nullable_to_non_nullable
          : securitySchemes as Map<String, SecurityScheme>?,
      links: links == const $CopyWithPlaceholder()
          ? _value.links
          // ignore: cast_nullable_to_non_nullable
          : links as Map<String, Ref<Link>>?,
      callbacks: callbacks == const $CopyWithPlaceholder()
          ? _value.callbacks
          // ignore: cast_nullable_to_non_nullable
          : callbacks as Map<String, Ref<Callback>>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ComponentsCopyWith on Components {
  /// Returns a callable class that can be used as follows: `instanceOfComponents.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ComponentsCWProxy get copyWith => _$ComponentsCWProxyImpl(this);
}

abstract class _$ComponentsNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ComponentsNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ComponentsNode call({Map<String, dynamic> extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComponentsNode.copyWith(...)`.
class _$ComponentsNodeCWProxyImpl implements _$ComponentsNodeCWProxy {
  const _$ComponentsNodeCWProxyImpl(this._value);

  final ComponentsNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ComponentsNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ComponentsNode call({Object? extensions = const $CopyWithPlaceholder()}) {
    return ComponentsNode(
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ComponentsNodeCopyWith on ComponentsNode {
  /// Returns a callable class that can be used as follows: `instanceOfComponentsNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ComponentsNodeCWProxy get copyWith => _$ComponentsNodeCWProxyImpl(this);
}

abstract class _$ContactCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Contact(...).copyWith(id: 12, name: "My name")
  /// ````
  Contact call({
    String? name,
    String? url,
    String? email,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfContact.copyWith(...)`.
class _$ContactCWProxyImpl implements _$ContactCWProxy {
  const _$ContactCWProxyImpl(this._value);

  final Contact _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ContactCopyWith on Contact {
  /// Returns a callable class that can be used as follows: `instanceOfContact.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactCWProxy get copyWith => _$ContactCWProxyImpl(this);
}

abstract class _$ContactNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ContactNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ContactNode call({
    String? name,
    String? url,
    String? email,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfContactNode.copyWith(...)`.
class _$ContactNodeCWProxyImpl implements _$ContactNodeCWProxy {
  const _$ContactNodeCWProxyImpl(this._value);

  final ContactNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ContactNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ContactNode call({
    Object? name = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ContactNode(
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ContactNodeCopyWith on ContactNode {
  /// Returns a callable class that can be used as follows: `instanceOfContactNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactNodeCWProxy get copyWith => _$ContactNodeCWProxyImpl(this);
}

abstract class _$DiscriminatorCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Discriminator(...).copyWith(id: 12, name: "My name")
  /// ````
  Discriminator call({
    String propertyName,
    Map<String, String>? mapping,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDiscriminator.copyWith(...)`.
class _$DiscriminatorCWProxyImpl implements _$DiscriminatorCWProxy {
  const _$DiscriminatorCWProxyImpl(this._value);

  final Discriminator _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $DiscriminatorCopyWith on Discriminator {
  /// Returns a callable class that can be used as follows: `instanceOfDiscriminator.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$DiscriminatorCWProxy get copyWith => _$DiscriminatorCWProxyImpl(this);
}

abstract class _$DiscriminatorNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// DiscriminatorNode(...).copyWith(id: 12, name: "My name")
  /// ````
  DiscriminatorNode call({
    String propertyName,
    Map<String, String>? mapping,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDiscriminatorNode.copyWith(...)`.
class _$DiscriminatorNodeCWProxyImpl implements _$DiscriminatorNodeCWProxy {
  const _$DiscriminatorNodeCWProxyImpl(this._value);

  final DiscriminatorNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// DiscriminatorNode(...).copyWith(id: 12, name: "My name")
  /// ````
  DiscriminatorNode call({
    Object? propertyName = const $CopyWithPlaceholder(),
    Object? mapping = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return DiscriminatorNode(
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $DiscriminatorNodeCopyWith on DiscriminatorNode {
  /// Returns a callable class that can be used as follows: `instanceOfDiscriminatorNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$DiscriminatorNodeCWProxy get copyWith =>
      _$DiscriminatorNodeCWProxyImpl(this);
}

abstract class _$ExampleCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExample.copyWith(...)`.
class _$ExampleCWProxyImpl implements _$ExampleCWProxy {
  const _$ExampleCWProxyImpl(this._value);

  final Example _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ExampleCopyWith on Example {
  /// Returns a callable class that can be used as follows: `instanceOfExample.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ExampleCWProxy get copyWith => _$ExampleCWProxyImpl(this);
}

abstract class _$ExampleNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ExampleNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ExampleNode call({
    String? summary,
    String? description,
    dynamic value,
    String? externalValue,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExampleNode.copyWith(...)`.
class _$ExampleNodeCWProxyImpl implements _$ExampleNodeCWProxy {
  const _$ExampleNodeCWProxyImpl(this._value);

  final ExampleNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ExampleNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ExampleNode call({
    Object? summary = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? externalValue = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ExampleNode(
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ExampleNodeCopyWith on ExampleNode {
  /// Returns a callable class that can be used as follows: `instanceOfExampleNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ExampleNodeCWProxy get copyWith => _$ExampleNodeCWProxyImpl(this);
}

abstract class _$ExternalDocumentationCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ExternalDocumentation(...).copyWith(id: 12, name: "My name")
  /// ````
  ExternalDocumentation call({
    String? description,
    String url,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExternalDocumentation.copyWith(...)`.
class _$ExternalDocumentationCWProxyImpl
    implements _$ExternalDocumentationCWProxy {
  const _$ExternalDocumentationCWProxyImpl(this._value);

  final ExternalDocumentation _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ExternalDocumentationCopyWith on ExternalDocumentation {
  /// Returns a callable class that can be used as follows: `instanceOfExternalDocumentation.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ExternalDocumentationCWProxy get copyWith =>
      _$ExternalDocumentationCWProxyImpl(this);
}

abstract class _$ExternalDocumentationNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ExternalDocumentationNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ExternalDocumentationNode call({
    String? description,
    String url,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExternalDocumentationNode.copyWith(...)`.
class _$ExternalDocumentationNodeCWProxyImpl
    implements _$ExternalDocumentationNodeCWProxy {
  const _$ExternalDocumentationNodeCWProxyImpl(this._value);

  final ExternalDocumentationNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ExternalDocumentationNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ExternalDocumentationNode call({
    Object? description = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ExternalDocumentationNode(
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ExternalDocumentationNodeCopyWith on ExternalDocumentationNode {
  /// Returns a callable class that can be used as follows: `instanceOfExternalDocumentationNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ExternalDocumentationNodeCWProxy get copyWith =>
      _$ExternalDocumentationNodeCWProxyImpl(this);
}

abstract class _$InfoCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInfo.copyWith(...)`.
class _$InfoCWProxyImpl implements _$InfoCWProxy {
  const _$InfoCWProxyImpl(this._value);

  final Info _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $InfoCopyWith on Info {
  /// Returns a callable class that can be used as follows: `instanceOfInfo.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$InfoCWProxy get copyWith => _$InfoCWProxyImpl(this);
}

abstract class _$InfoNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// InfoNode(...).copyWith(id: 12, name: "My name")
  /// ````
  InfoNode call({
    String title,
    String? description,
    String? termsOfService,
    String version,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInfoNode.copyWith(...)`.
class _$InfoNodeCWProxyImpl implements _$InfoNodeCWProxy {
  const _$InfoNodeCWProxyImpl(this._value);

  final InfoNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// InfoNode(...).copyWith(id: 12, name: "My name")
  /// ````
  InfoNode call({
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? termsOfService = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return InfoNode(
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
      version: version == const $CopyWithPlaceholder()
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as String,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $InfoNodeCopyWith on InfoNode {
  /// Returns a callable class that can be used as follows: `instanceOfInfoNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$InfoNodeCWProxy get copyWith => _$InfoNodeCWProxyImpl(this);
}

abstract class _$LicenseCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// License(...).copyWith(id: 12, name: "My name")
  /// ````
  License call({String name, String? url, Map<String, dynamic> extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLicense.copyWith(...)`.
class _$LicenseCWProxyImpl implements _$LicenseCWProxy {
  const _$LicenseCWProxyImpl(this._value);

  final License _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $LicenseCopyWith on License {
  /// Returns a callable class that can be used as follows: `instanceOfLicense.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$LicenseCWProxy get copyWith => _$LicenseCWProxyImpl(this);
}

abstract class _$LicenseNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// LicenseNode(...).copyWith(id: 12, name: "My name")
  /// ````
  LicenseNode call({String name, String? url, Map<String, dynamic> extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLicenseNode.copyWith(...)`.
class _$LicenseNodeCWProxyImpl implements _$LicenseNodeCWProxy {
  const _$LicenseNodeCWProxyImpl(this._value);

  final LicenseNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// LicenseNode(...).copyWith(id: 12, name: "My name")
  /// ````
  LicenseNode call({
    Object? name = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return LicenseNode(
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $LicenseNodeCopyWith on LicenseNode {
  /// Returns a callable class that can be used as follows: `instanceOfLicenseNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$LicenseNodeCWProxy get copyWith => _$LicenseNodeCWProxyImpl(this);
}

abstract class _$LinkCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLink.copyWith(...)`.
class _$LinkCWProxyImpl implements _$LinkCWProxy {
  const _$LinkCWProxyImpl(this._value);

  final Link _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $LinkCopyWith on Link {
  /// Returns a callable class that can be used as follows: `instanceOfLink.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$LinkCWProxy get copyWith => _$LinkCWProxyImpl(this);
}

abstract class _$LinkNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// LinkNode(...).copyWith(id: 12, name: "My name")
  /// ````
  LinkNode call({
    String? operationRef,
    String? operationId,
    Map<String, dynamic>? parameters,
    dynamic requestBody,
    String? description,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLinkNode.copyWith(...)`.
class _$LinkNodeCWProxyImpl implements _$LinkNodeCWProxy {
  const _$LinkNodeCWProxyImpl(this._value);

  final LinkNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// LinkNode(...).copyWith(id: 12, name: "My name")
  /// ````
  LinkNode call({
    Object? operationRef = const $CopyWithPlaceholder(),
    Object? operationId = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
    Object? requestBody = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return LinkNode(
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
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $LinkNodeCopyWith on LinkNode {
  /// Returns a callable class that can be used as follows: `instanceOfLinkNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$LinkNodeCWProxy get copyWith => _$LinkNodeCWProxyImpl(this);
}

abstract class _$MediaTypeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// MediaType(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaType call({
    Ref<Schema>? schema,
    dynamic example,
    Map<String, Ref<Example>>? examples,
    Map<String, Encoding>? encoding,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMediaType.copyWith(...)`.
class _$MediaTypeCWProxyImpl implements _$MediaTypeCWProxy {
  const _$MediaTypeCWProxyImpl(this._value);

  final MediaType _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : schema as Ref<Schema>?,
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      examples: examples == const $CopyWithPlaceholder()
          ? _value.examples
          // ignore: cast_nullable_to_non_nullable
          : examples as Map<String, Ref<Example>>?,
      encoding: encoding == const $CopyWithPlaceholder()
          ? _value.encoding
          // ignore: cast_nullable_to_non_nullable
          : encoding as Map<String, Encoding>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $MediaTypeCopyWith on MediaType {
  /// Returns a callable class that can be used as follows: `instanceOfMediaType.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$MediaTypeCWProxy get copyWith => _$MediaTypeCWProxyImpl(this);
}

abstract class _$MediaTypeNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// MediaTypeNode(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaTypeNode call({dynamic example, Map<String, dynamic> extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMediaTypeNode.copyWith(...)`.
class _$MediaTypeNodeCWProxyImpl implements _$MediaTypeNodeCWProxy {
  const _$MediaTypeNodeCWProxyImpl(this._value);

  final MediaTypeNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// MediaTypeNode(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaTypeNode call({
    Object? example = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return MediaTypeNode(
      example: example == const $CopyWithPlaceholder()
          ? _value.example
          // ignore: cast_nullable_to_non_nullable
          : example as dynamic,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $MediaTypeNodeCopyWith on MediaTypeNode {
  /// Returns a callable class that can be used as follows: `instanceOfMediaTypeNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$MediaTypeNodeCWProxy get copyWith => _$MediaTypeNodeCWProxyImpl(this);
}

abstract class _$OAuthFlowCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOAuthFlow.copyWith(...)`.
class _$OAuthFlowCWProxyImpl implements _$OAuthFlowCWProxy {
  const _$OAuthFlowCWProxyImpl(this._value);

  final OAuthFlow _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $OAuthFlowCopyWith on OAuthFlow {
  /// Returns a callable class that can be used as follows: `instanceOfOAuthFlow.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$OAuthFlowCWProxy get copyWith => _$OAuthFlowCWProxyImpl(this);
}

abstract class _$OAuthFlowNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlowNode(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlowNode call({
    String? authorizationUrl,
    String? tokenUrl,
    String? refreshUrl,
    Map<String, String> scopes,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOAuthFlowNode.copyWith(...)`.
class _$OAuthFlowNodeCWProxyImpl implements _$OAuthFlowNodeCWProxy {
  const _$OAuthFlowNodeCWProxyImpl(this._value);

  final OAuthFlowNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlowNode(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlowNode call({
    Object? authorizationUrl = const $CopyWithPlaceholder(),
    Object? tokenUrl = const $CopyWithPlaceholder(),
    Object? refreshUrl = const $CopyWithPlaceholder(),
    Object? scopes = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return OAuthFlowNode(
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $OAuthFlowNodeCopyWith on OAuthFlowNode {
  /// Returns a callable class that can be used as follows: `instanceOfOAuthFlowNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$OAuthFlowNodeCWProxy get copyWith => _$OAuthFlowNodeCWProxyImpl(this);
}

abstract class _$OAuthFlowsCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOAuthFlows.copyWith(...)`.
class _$OAuthFlowsCWProxyImpl implements _$OAuthFlowsCWProxy {
  const _$OAuthFlowsCWProxyImpl(this._value);

  final OAuthFlows _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $OAuthFlowsCopyWith on OAuthFlows {
  /// Returns a callable class that can be used as follows: `instanceOfOAuthFlows.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$OAuthFlowsCWProxy get copyWith => _$OAuthFlowsCWProxyImpl(this);
}

abstract class _$OAuthFlowsNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlowsNode(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlowsNode call({Map<String, dynamic> extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOAuthFlowsNode.copyWith(...)`.
class _$OAuthFlowsNodeCWProxyImpl implements _$OAuthFlowsNodeCWProxy {
  const _$OAuthFlowsNodeCWProxyImpl(this._value);

  final OAuthFlowsNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// OAuthFlowsNode(...).copyWith(id: 12, name: "My name")
  /// ````
  OAuthFlowsNode call({Object? extensions = const $CopyWithPlaceholder()}) {
    return OAuthFlowsNode(
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $OAuthFlowsNodeCopyWith on OAuthFlowsNode {
  /// Returns a callable class that can be used as follows: `instanceOfOAuthFlowsNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$OAuthFlowsNodeCWProxy get copyWith => _$OAuthFlowsNodeCWProxyImpl(this);
}

abstract class _$PathItemCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    List<Server>? servers,
    List<Ref<Parameter>>? parameters,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPathItem.copyWith(...)`.
class _$PathItemCWProxyImpl implements _$PathItemCWProxy {
  const _$PathItemCWProxyImpl(this._value);

  final PathItem _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : servers as List<Server>?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as List<Ref<Parameter>>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $PathItemCopyWith on PathItem {
  /// Returns a callable class that can be used as follows: `instanceOfPathItem.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$PathItemCWProxy get copyWith => _$PathItemCWProxyImpl(this);
}

abstract class _$PathItemNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// PathItemNode(...).copyWith(id: 12, name: "My name")
  /// ````
  PathItemNode call({Map<String, dynamic> extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPathItemNode.copyWith(...)`.
class _$PathItemNodeCWProxyImpl implements _$PathItemNodeCWProxy {
  const _$PathItemNodeCWProxyImpl(this._value);

  final PathItemNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// PathItemNode(...).copyWith(id: 12, name: "My name")
  /// ````
  PathItemNode call({Object? extensions = const $CopyWithPlaceholder()}) {
    return PathItemNode(
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $PathItemNodeCopyWith on PathItemNode {
  /// Returns a callable class that can be used as follows: `instanceOfPathItemNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$PathItemNodeCWProxy get copyWith => _$PathItemNodeCWProxyImpl(this);
}

abstract class _$RequestBodyCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// RequestBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestBody call({
    String? description,
    bool required,
    Map<String, MediaType> content,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRequestBody.copyWith(...)`.
class _$RequestBodyCWProxyImpl implements _$RequestBodyCWProxy {
  const _$RequestBodyCWProxyImpl(this._value);

  final RequestBody _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : content as Map<String, MediaType>,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $RequestBodyCopyWith on RequestBody {
  /// Returns a callable class that can be used as follows: `instanceOfRequestBody.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$RequestBodyCWProxy get copyWith => _$RequestBodyCWProxyImpl(this);
}

abstract class _$RequestBodyNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// RequestBodyNode(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestBodyNode call({
    String? description,
    bool required,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRequestBodyNode.copyWith(...)`.
class _$RequestBodyNodeCWProxyImpl implements _$RequestBodyNodeCWProxy {
  const _$RequestBodyNodeCWProxyImpl(this._value);

  final RequestBodyNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// RequestBodyNode(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestBodyNode call({
    Object? description = const $CopyWithPlaceholder(),
    Object? required = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return RequestBodyNode(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      required: required == const $CopyWithPlaceholder()
          ? _value.required
          // ignore: cast_nullable_to_non_nullable
          : required as bool,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $RequestBodyNodeCopyWith on RequestBodyNode {
  /// Returns a callable class that can be used as follows: `instanceOfRequestBodyNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$RequestBodyNodeCWProxy get copyWith => _$RequestBodyNodeCWProxyImpl(this);
}

abstract class _$ResponseCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Response(...).copyWith(id: 12, name: "My name")
  /// ````
  Response call({
    String? description,
    Map<String, Ref<Header>>? headers,
    Map<String, MediaType>? content,
    Map<String, Ref<Link>>? links,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResponse.copyWith(...)`.
class _$ResponseCWProxyImpl implements _$ResponseCWProxy {
  const _$ResponseCWProxyImpl(this._value);

  final Response _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : headers as Map<String, Ref<Header>>?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as Map<String, MediaType>?,
      links: links == const $CopyWithPlaceholder()
          ? _value.links
          // ignore: cast_nullable_to_non_nullable
          : links as Map<String, Ref<Link>>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ResponseCopyWith on Response {
  /// Returns a callable class that can be used as follows: `instanceOfResponse.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ResponseCWProxy get copyWith => _$ResponseCWProxyImpl(this);
}

abstract class _$ResponseNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ResponseNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ResponseNode call({String? description, Map<String, dynamic>? extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResponseNode.copyWith(...)`.
class _$ResponseNodeCWProxyImpl implements _$ResponseNodeCWProxy {
  const _$ResponseNodeCWProxyImpl(this._value);

  final ResponseNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ResponseNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ResponseNode call({
    Object? description = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ResponseNode(
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

extension $ResponseNodeCopyWith on ResponseNode {
  /// Returns a callable class that can be used as follows: `instanceOfResponseNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ResponseNodeCWProxy get copyWith => _$ResponseNodeCWProxyImpl(this);
}

abstract class _$SecurityRequirementCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// SecurityRequirement(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityRequirement call({Map<String, List<String>> requirements});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecurityRequirement.copyWith(...)`.
class _$SecurityRequirementCWProxyImpl implements _$SecurityRequirementCWProxy {
  const _$SecurityRequirementCWProxyImpl(this._value);

  final SecurityRequirement _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
  /// Returns a callable class that can be used as follows: `instanceOfSecurityRequirement.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$SecurityRequirementCWProxy get copyWith =>
      _$SecurityRequirementCWProxyImpl(this);
}

abstract class _$SecurityRequirementNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// SecurityRequirementNode(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityRequirementNode call({Map<String, List<String>> requirements});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecurityRequirementNode.copyWith(...)`.
class _$SecurityRequirementNodeCWProxyImpl
    implements _$SecurityRequirementNodeCWProxy {
  const _$SecurityRequirementNodeCWProxyImpl(this._value);

  final SecurityRequirementNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// SecurityRequirementNode(...).copyWith(id: 12, name: "My name")
  /// ````
  SecurityRequirementNode call({
    Object? requirements = const $CopyWithPlaceholder(),
  }) {
    return SecurityRequirementNode(
      requirements: requirements == const $CopyWithPlaceholder()
          ? _value.requirements
          // ignore: cast_nullable_to_non_nullable
          : requirements as Map<String, List<String>>,
    );
  }
}

extension $SecurityRequirementNodeCopyWith on SecurityRequirementNode {
  /// Returns a callable class that can be used as follows: `instanceOfSecurityRequirementNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$SecurityRequirementNodeCWProxy get copyWith =>
      _$SecurityRequirementNodeCWProxyImpl(this);
}

abstract class _$SecuritySchemeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecurityScheme.copyWith(...)`.
class _$SecuritySchemeCWProxyImpl implements _$SecuritySchemeCWProxy {
  const _$SecuritySchemeCWProxyImpl(this._value);

  final SecurityScheme _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $SecuritySchemeCopyWith on SecurityScheme {
  /// Returns a callable class that can be used as follows: `instanceOfSecurityScheme.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$SecuritySchemeCWProxy get copyWith => _$SecuritySchemeCWProxyImpl(this);
}

abstract class _$SecuritySchemeNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// SecuritySchemeNode(...).copyWith(id: 12, name: "My name")
  /// ````
  SecuritySchemeNode call({
    SecuritySchemeType type,
    String? description,
    String? name,
    SecuritySchemeIn? in_,
    String? scheme,
    String? bearerFormat,
    String? openIdConnectUrl,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecuritySchemeNode.copyWith(...)`.
class _$SecuritySchemeNodeCWProxyImpl implements _$SecuritySchemeNodeCWProxy {
  const _$SecuritySchemeNodeCWProxyImpl(this._value);

  final SecuritySchemeNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// SecuritySchemeNode(...).copyWith(id: 12, name: "My name")
  /// ````
  SecuritySchemeNode call({
    Object? type = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? in_ = const $CopyWithPlaceholder(),
    Object? scheme = const $CopyWithPlaceholder(),
    Object? bearerFormat = const $CopyWithPlaceholder(),
    Object? openIdConnectUrl = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return SecuritySchemeNode(
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
      openIdConnectUrl: openIdConnectUrl == const $CopyWithPlaceholder()
          ? _value.openIdConnectUrl
          // ignore: cast_nullable_to_non_nullable
          : openIdConnectUrl as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $SecuritySchemeNodeCopyWith on SecuritySchemeNode {
  /// Returns a callable class that can be used as follows: `instanceOfSecuritySchemeNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$SecuritySchemeNodeCWProxy get copyWith =>
      _$SecuritySchemeNodeCWProxyImpl(this);
}

abstract class _$ServerCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Server(...).copyWith(id: 12, name: "My name")
  /// ````
  Server call({
    String url,
    String? description,
    Map<String, ServerVariable>? variables,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServer.copyWith(...)`.
class _$ServerCWProxyImpl implements _$ServerCWProxy {
  const _$ServerCWProxyImpl(this._value);

  final Server _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : variables as Map<String, ServerVariable>?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ServerCopyWith on Server {
  /// Returns a callable class that can be used as follows: `instanceOfServer.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerCWProxy get copyWith => _$ServerCWProxyImpl(this);
}

abstract class _$ServerNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ServerNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerNode call({
    String url,
    String? description,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServerNode.copyWith(...)`.
class _$ServerNodeCWProxyImpl implements _$ServerNodeCWProxy {
  const _$ServerNodeCWProxyImpl(this._value);

  final ServerNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ServerNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerNode call({
    Object? url = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ServerNode(
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ServerNodeCopyWith on ServerNode {
  /// Returns a callable class that can be used as follows: `instanceOfServerNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerNodeCWProxy get copyWith => _$ServerNodeCWProxyImpl(this);
}

abstract class _$ServerVariableCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ServerVariable(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerVariable call({
    List<String>? enum_,
    String default_,
    String? description,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServerVariable.copyWith(...)`.
class _$ServerVariableCWProxyImpl implements _$ServerVariableCWProxy {
  const _$ServerVariableCWProxyImpl(this._value);

  final ServerVariable _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ServerVariableCopyWith on ServerVariable {
  /// Returns a callable class that can be used as follows: `instanceOfServerVariable.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerVariableCWProxy get copyWith => _$ServerVariableCWProxyImpl(this);
}

abstract class _$ServerVariableNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ServerVariableNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerVariableNode call({
    List<String>? enum_,
    String default_,
    String? description,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfServerVariableNode.copyWith(...)`.
class _$ServerVariableNodeCWProxyImpl implements _$ServerVariableNodeCWProxy {
  const _$ServerVariableNodeCWProxyImpl(this._value);

  final ServerVariableNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// ServerVariableNode(...).copyWith(id: 12, name: "My name")
  /// ````
  ServerVariableNode call({
    Object? enum_ = const $CopyWithPlaceholder(),
    Object? default_ = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return ServerVariableNode(
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $ServerVariableNodeCopyWith on ServerVariableNode {
  /// Returns a callable class that can be used as follows: `instanceOfServerVariableNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ServerVariableNodeCWProxy get copyWith =>
      _$ServerVariableNodeCWProxyImpl(this);
}

abstract class _$TagCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Tag(...).copyWith(id: 12, name: "My name")
  /// ````
  Tag call({
    String name,
    String? description,
    ExternalDocumentation? externalDocs,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTag.copyWith(...)`.
class _$TagCWProxyImpl implements _$TagCWProxy {
  const _$TagCWProxyImpl(this._value);

  final Tag _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $TagCopyWith on Tag {
  /// Returns a callable class that can be used as follows: `instanceOfTag.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$TagCWProxy get copyWith => _$TagCWProxyImpl(this);
}

abstract class _$TagNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// TagNode(...).copyWith(id: 12, name: "My name")
  /// ````
  TagNode call({
    String name,
    String? description,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTagNode.copyWith(...)`.
class _$TagNodeCWProxyImpl implements _$TagNodeCWProxy {
  const _$TagNodeCWProxyImpl(this._value);

  final TagNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// TagNode(...).copyWith(id: 12, name: "My name")
  /// ````
  TagNode call({
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return TagNode(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $TagNodeCopyWith on TagNode {
  /// Returns a callable class that can be used as follows: `instanceOfTagNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$TagNodeCWProxy get copyWith => _$TagNodeCWProxyImpl(this);
}

abstract class _$XMLCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfXML.copyWith(...)`.
class _$XMLCWProxyImpl implements _$XMLCWProxy {
  const _$XMLCWProxyImpl(this._value);

  final XML _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $XMLCopyWith on XML {
  /// Returns a callable class that can be used as follows: `instanceOfXML.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$XMLCWProxy get copyWith => _$XMLCWProxyImpl(this);
}

abstract class _$XMLNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// XMLNode(...).copyWith(id: 12, name: "My name")
  /// ````
  XMLNode call({
    String? name,
    String? namespace,
    String? prefix,
    bool attribute,
    bool wrapped,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfXMLNode.copyWith(...)`.
class _$XMLNodeCWProxyImpl implements _$XMLNodeCWProxy {
  const _$XMLNodeCWProxyImpl(this._value);

  final XMLNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// XMLNode(...).copyWith(id: 12, name: "My name")
  /// ````
  XMLNode call({
    Object? name = const $CopyWithPlaceholder(),
    Object? namespace = const $CopyWithPlaceholder(),
    Object? prefix = const $CopyWithPlaceholder(),
    Object? attribute = const $CopyWithPlaceholder(),
    Object? wrapped = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return XMLNode(
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $XMLNodeCopyWith on XMLNode {
  /// Returns a callable class that can be used as follows: `instanceOfXMLNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$XMLNodeCWProxy get copyWith => _$XMLNodeCWProxyImpl(this);
}

abstract class _$OpenApiDocumentCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// OpenApiDocument(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenApiDocument call({
    String openapi,
    Info info,
    List<Server>? servers,
    Map<String, Ref<PathItem>> paths,
    Components? components,
    List<Ref<SecurityRequirement>>? security,
    List<Tag>? tags,
    ExternalDocumentation? externalDocs,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOpenApiDocument.copyWith(...)`.
class _$OpenApiDocumentCWProxyImpl implements _$OpenApiDocumentCWProxy {
  const _$OpenApiDocumentCWProxyImpl(this._value);

  final OpenApiDocument _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : servers as List<Server>?,
      paths: paths == const $CopyWithPlaceholder()
          ? _value.paths
          // ignore: cast_nullable_to_non_nullable
          : paths as Map<String, Ref<PathItem>>,
      components: components == const $CopyWithPlaceholder()
          ? _value.components
          // ignore: cast_nullable_to_non_nullable
          : components as Components?,
      security: security == const $CopyWithPlaceholder()
          ? _value.security
          // ignore: cast_nullable_to_non_nullable
          : security as List<Ref<SecurityRequirement>>?,
      tags: tags == const $CopyWithPlaceholder()
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as List<Tag>?,
      externalDocs: externalDocs == const $CopyWithPlaceholder()
          ? _value.externalDocs
          // ignore: cast_nullable_to_non_nullable
          : externalDocs as ExternalDocumentation?,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $OpenApiDocumentCopyWith on OpenApiDocument {
  /// Returns a callable class that can be used as follows: `instanceOfOpenApiDocument.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$OpenApiDocumentCWProxy get copyWith => _$OpenApiDocumentCWProxyImpl(this);
}

abstract class _$OpenApiDocumentNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// OpenApiDocumentNode(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenApiDocumentNode call({String openapi, Map<String, dynamic> extensions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOpenApiDocumentNode.copyWith(...)`.
class _$OpenApiDocumentNodeCWProxyImpl implements _$OpenApiDocumentNodeCWProxy {
  const _$OpenApiDocumentNodeCWProxyImpl(this._value);

  final OpenApiDocumentNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// OpenApiDocumentNode(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenApiDocumentNode call({
    Object? openapi = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return OpenApiDocumentNode(
      openapi: openapi == const $CopyWithPlaceholder()
          ? _value.openapi
          // ignore: cast_nullable_to_non_nullable
          : openapi as String,
      extensions: extensions == const $CopyWithPlaceholder()
          ? _value.extensions
          // ignore: cast_nullable_to_non_nullable
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $OpenApiDocumentNodeCopyWith on OpenApiDocumentNode {
  /// Returns a callable class that can be used as follows: `instanceOfOpenApiDocumentNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$OpenApiDocumentNodeCWProxy get copyWith =>
      _$OpenApiDocumentNodeCWProxyImpl(this);
}

abstract class _$SchemaCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
    Ref<Schema>? items,
    int? maxProperties,
    int? minProperties,
    List<String>? required_,
    Map<String, Ref<Schema>>? properties,
    bool? additionalPropertiesAllowed,
    Ref<Schema>? additionalProperties,
    List<Ref<Schema>>? allOf,
    List<Ref<Schema>>? oneOf,
    List<Ref<Schema>>? anyOf,
    List<dynamic>? enum_,
    bool nullable,
    Discriminator? discriminator,
    bool readOnly,
    bool writeOnly,
    XML? xml,
    ExternalDocumentation? externalDocs,
    dynamic example,
    bool deprecated,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSchema.copyWith(...)`.
class _$SchemaCWProxyImpl implements _$SchemaCWProxy {
  const _$SchemaCWProxyImpl(this._value);

  final Schema _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
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
          : items as Ref<Schema>?,
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
          : properties as Map<String, Ref<Schema>>?,
      additionalPropertiesAllowed:
          additionalPropertiesAllowed == const $CopyWithPlaceholder()
          ? _value.additionalPropertiesAllowed
          // ignore: cast_nullable_to_non_nullable
          : additionalPropertiesAllowed as bool?,
      additionalProperties: additionalProperties == const $CopyWithPlaceholder()
          ? _value.additionalProperties
          // ignore: cast_nullable_to_non_nullable
          : additionalProperties as Ref<Schema>?,
      allOf: allOf == const $CopyWithPlaceholder()
          ? _value.allOf
          // ignore: cast_nullable_to_non_nullable
          : allOf as List<Ref<Schema>>?,
      oneOf: oneOf == const $CopyWithPlaceholder()
          ? _value.oneOf
          // ignore: cast_nullable_to_non_nullable
          : oneOf as List<Ref<Schema>>?,
      anyOf: anyOf == const $CopyWithPlaceholder()
          ? _value.anyOf
          // ignore: cast_nullable_to_non_nullable
          : anyOf as List<Ref<Schema>>?,
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $SchemaCopyWith on Schema {
  /// Returns a callable class that can be used as follows: `instanceOfSchema.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$SchemaCWProxy get copyWith => _$SchemaCWProxyImpl(this);
}

abstract class _$SchemaNodeCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// SchemaNode(...).copyWith(id: 12, name: "My name")
  /// ````
  SchemaNode call({
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
    int? maxProperties,
    int? minProperties,
    List<String>? required_,
    bool? additionalPropertiesAllowed,
    bool nullable,
    bool readOnly,
    bool writeOnly,
    dynamic example,
    bool deprecated,
    Map<String, dynamic> extensions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSchemaNode.copyWith(...)`.
class _$SchemaNodeCWProxyImpl implements _$SchemaNodeCWProxy {
  const _$SchemaNodeCWProxyImpl(this._value);

  final SchemaNode _value;

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// SchemaNode(...).copyWith(id: 12, name: "My name")
  /// ````
  SchemaNode call({
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
    Object? maxProperties = const $CopyWithPlaceholder(),
    Object? minProperties = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? additionalPropertiesAllowed = const $CopyWithPlaceholder(),
    Object? nullable = const $CopyWithPlaceholder(),
    Object? readOnly = const $CopyWithPlaceholder(),
    Object? writeOnly = const $CopyWithPlaceholder(),
    Object? example = const $CopyWithPlaceholder(),
    Object? deprecated = const $CopyWithPlaceholder(),
    Object? extensions = const $CopyWithPlaceholder(),
  }) {
    return SchemaNode(
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
      additionalPropertiesAllowed:
          additionalPropertiesAllowed == const $CopyWithPlaceholder()
          ? _value.additionalPropertiesAllowed
          // ignore: cast_nullable_to_non_nullable
          : additionalPropertiesAllowed as bool?,
      nullable: nullable == const $CopyWithPlaceholder()
          ? _value.nullable
          // ignore: cast_nullable_to_non_nullable
          : nullable as bool,
      readOnly: readOnly == const $CopyWithPlaceholder()
          ? _value.readOnly
          // ignore: cast_nullable_to_non_nullable
          : readOnly as bool,
      writeOnly: writeOnly == const $CopyWithPlaceholder()
          ? _value.writeOnly
          // ignore: cast_nullable_to_non_nullable
          : writeOnly as bool,
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
          : extensions as Map<String, dynamic>,
    );
  }
}

extension $SchemaNodeCopyWith on SchemaNode {
  /// Returns a callable class that can be used as follows: `instanceOfSchemaNode.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$SchemaNodeCWProxy get copyWith => _$SchemaNodeCWProxyImpl(this);
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
        requiredKeys: const [
          'contentType',
          'headers',
          'style',
          'explode',
          'allowReserved',
        ],
        disallowNullValues: const [
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
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Header>.fromJson(e)),
          ),
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
  'headers': ?instance.headers?.map((k, e) => MapEntry(k, e.toJson())),
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

Map<String, dynamic> _$EncodingNodeToJson(EncodingNode instance) =>
    <String, dynamic>{
      'contentType': ?instance.contentType,
      'headers': ?instance.headers?.toJson(),
      'style': ?_$ParameterStyleEnumMap[instance.style],
      'explode': ?instance.explode,
      'allowReserved': instance.allowReserved,
    };

Header _$HeaderFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Header', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'description',
          'required',
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
        requiredKeys: const [
          'required',
          'deprecated',
          'allowEmptyValue',
          'allowReserved',
        ],
        disallowNullValues: const [
          'required',
          'deprecated',
          'allowEmptyValue',
          'allowReserved',
        ],
      );
      final val = Header(
        description: $checkedConvert('description', (v) => v as String?),
        required_: $checkedConvert('required', (v) => v as bool),
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
          (v) => v == null ? null : Ref<Schema>.fromJson(v),
        ),
        example: $checkedConvert('example', (v) => v),
        examples: $checkedConvert(
          'examples',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Example>.fromJson(e)),
          ),
        ),
        content: $checkedConvert(
          'content',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, MediaType.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      );
      return val;
    }, fieldKeyMap: const {'required_': 'required'});

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
  'description': ?instance.description,
  'required': instance.required_,
  'deprecated': instance.deprecated,
  'allowEmptyValue': instance.allowEmptyValue,
  'style': ?_$ParameterStyleEnumMap[instance.style],
  'explode': ?instance.explode,
  'allowReserved': instance.allowReserved,
  'schema': ?instance.schema?.toJson(),
  'example': ?instance.example,
  'examples': ?instance.examples?.map((k, e) => MapEntry(k, e.toJson())),
  'content': ?instance.content?.map((k, e) => MapEntry(k, e.toJson())),
};

Map<String, dynamic> _$HeaderNodeToJson(HeaderNode instance) =>
    <String, dynamic>{
      'description': ?instance.description,
      'required': instance.required_,
      'deprecated': instance.deprecated,
      'allowEmptyValue': instance.allowEmptyValue,
      'style': ?_$ParameterStyleEnumMap[instance.style],
      'explode': ?instance.explode,
      'allowReserved': instance.allowReserved,
      'schema': ?instance.schema?.toJson(),
      'examples': ?instance.examples?.toJson(),
      'content': ?instance.content?.toJson(),
    };

Parameter _$ParameterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Parameter', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'name',
          'in',
          'description',
          'required',
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
        requiredKeys: const [
          'name',
          'in',
          'required',
          'deprecated',
          'allowEmptyValue',
          'allowReserved',
        ],
        disallowNullValues: const [
          'name',
          'in',
          'required',
          'deprecated',
          'allowEmptyValue',
          'allowReserved',
        ],
      );
      final val = Parameter(
        name: $checkedConvert('name', (v) => v as String),
        in_: $checkedConvert(
          'in',
          (v) => $enumDecode(_$ParameterLocationEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String?),
        required_: $checkedConvert('required', (v) => v as bool),
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
          (v) => v == null ? null : Ref<Schema>.fromJson(v),
        ),
        example: $checkedConvert('example', (v) => v),
        examples: $checkedConvert(
          'examples',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Example>.fromJson(e)),
          ),
        ),
        content: $checkedConvert(
          'content',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<MediaType>.fromJson(e)),
          ),
        ),
        extensions: $checkedConvert(
          'extensions',
          (v) => v as Map<String, dynamic>? ?? const {},
        ),
      );
      return val;
    }, fieldKeyMap: const {'in_': 'in', 'required_': 'required'});

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
  'name': instance.name,
  'in': _$ParameterLocationEnumMap[instance.in_]!,
  'description': ?instance.description,
  'required': instance.required_,
  'deprecated': instance.deprecated,
  'allowEmptyValue': instance.allowEmptyValue,
  'style': ?_$ParameterStyleEnumMap[instance.style],
  'explode': ?instance.explode,
  'allowReserved': instance.allowReserved,
  'schema': ?instance.schema?.toJson(),
  'example': ?instance.example,
  'examples': ?instance.examples?.map((k, e) => MapEntry(k, e.toJson())),
  'content': ?instance.content?.map((k, e) => MapEntry(k, e.toJson())),
  'extensions': instance.extensions,
};

const _$ParameterLocationEnumMap = {
  ParameterLocation.query: 'query',
  ParameterLocation.header: 'header',
  ParameterLocation.path: 'path',
  ParameterLocation.cookie: 'cookie',
};

Map<String, dynamic> _$ParameterNodeToJson(ParameterNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'in': _$ParameterLocationEnumMap[instance.in_]!,
      'description': ?instance.description,
      'required': instance.required_,
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

Operation _$OperationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Operation', json, ($checkedConvert) {
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
        requiredKeys: const ['responses'],
        disallowNullValues: const ['responses'],
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
          (v) => (v as List<dynamic>?)?.map(Ref<Parameter>.fromJson).toList(),
        ),
        requestBody: $checkedConvert(
          'requestBody',
          (v) => v == null ? null : Ref<RequestBody>.fromJson(v),
        ),
        responses: $checkedConvert(
          'responses',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, Ref<Response>.fromJson(e)),
          ),
        ),
        callbacks: $checkedConvert(
          'callbacks',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Callback>.fromJson(e)),
          ),
        ),
        security: $checkedConvert(
          'security',
          (v) => (v as List<dynamic>?)
              ?.map(Ref<SecurityRequirement>.fromJson)
              .toList(),
        ),
        servers: $checkedConvert(
          'servers',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Server.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OperationToJson(Operation instance) => <String, dynamic>{
  'externalDocs': ?instance.externalDocs?.toJson(),
  'parameters': ?instance.parameters?.map((e) => e.toJson()).toList(),
  'requestBody': ?instance.requestBody?.toJson(),
  'responses': instance.responses.map((k, e) => MapEntry(k, e.toJson())),
  'callbacks': ?instance.callbacks?.map((k, e) => MapEntry(k, e.toJson())),
  'security': ?instance.security?.map((e) => e.toJson()).toList(),
  'servers': ?instance.servers?.map((e) => e.toJson()).toList(),
};

Map<String, dynamic> _$OperationNodeToJson(OperationNode instance) =>
    <String, dynamic>{
      'externalDocs': ?instance.externalDocs?.toJson(),
      'parameters': ?instance.parameters?.toJson(),
      'requestBody': ?instance.requestBody?.toJson(),
      'responses': ?instance.responses?.toJson(),
      'callbacks': ?instance.callbacks?.toJson(),
      'security': ?instance.security?.toJson(),
      'servers': ?instance.servers?.toJson(),
    };

Callback _$CallbackFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Callback', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['expressions'],
        requiredKeys: const ['expressions'],
        disallowNullValues: const ['expressions'],
      );
      final val = Callback(
        expressions: $checkedConvert(
          'expressions',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, Ref<PathItem>.fromJson(e)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CallbackToJson(Callback instance) => <String, dynamic>{
  'expressions': instance.expressions.map((k, e) => MapEntry(k, e.toJson())),
};

Map<String, dynamic> _$CallbackNodeToJson(CallbackNode instance) =>
    <String, dynamic>{'expressions': ?instance.expressions?.toJson()};

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
            (k, e) => MapEntry(k, Ref<Schema>.fromJson(e)),
          ),
        ),
        responses: $checkedConvert(
          'responses',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Response>.fromJson(e)),
          ),
        ),
        parameters: $checkedConvert(
          'parameters',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Parameter>.fromJson(e)),
          ),
        ),
        examples: $checkedConvert(
          'examples',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Example>.fromJson(e)),
          ),
        ),
        requestBodies: $checkedConvert(
          'requestBodies',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<RequestBody>.fromJson(e)),
          ),
        ),
        headers: $checkedConvert(
          'headers',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Header>.fromJson(e)),
          ),
        ),
        securitySchemes: $checkedConvert(
          'securitySchemes',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, SecurityScheme.fromJson(e as Map<String, dynamic>)),
          ),
        ),
        links: $checkedConvert(
          'links',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Link>.fromJson(e)),
          ),
        ),
        callbacks: $checkedConvert(
          'callbacks',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Callback>.fromJson(e)),
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

Map<String, dynamic> _$ComponentsNodeToJson(ComponentsNode instance) =>
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

Map<String, dynamic> _$ContactNodeToJson(ContactNode instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'url': ?instance.url,
      'email': ?instance.email,
    };

Discriminator _$DiscriminatorFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Discriminator', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['propertyName', 'mapping'],
        requiredKeys: const ['propertyName'],
        disallowNullValues: const ['propertyName'],
      );
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

Map<String, dynamic> _$DiscriminatorNodeToJson(DiscriminatorNode instance) =>
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

Map<String, dynamic> _$ExampleNodeToJson(ExampleNode instance) =>
    <String, dynamic>{
      'summary': ?instance.summary,
      'description': ?instance.description,
      'value': ?instance.value,
      'externalValue': ?instance.externalValue,
    };

ExternalDocumentation _$ExternalDocumentationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExternalDocumentation', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['description', 'url'],
    requiredKeys: const ['url'],
    disallowNullValues: const ['url'],
  );
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

Map<String, dynamic> _$ExternalDocumentationNodeToJson(
  ExternalDocumentationNode instance,
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
        requiredKeys: const ['title', 'version'],
        disallowNullValues: const ['title', 'version'],
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

Map<String, dynamic> _$InfoNodeToJson(InfoNode instance) => <String, dynamic>{
  'title': instance.title,
  'description': ?instance.description,
  'termsOfService': ?instance.termsOfService,
  'contact': ?instance.contact?.toJson(),
  'license': ?instance.license?.toJson(),
  'version': instance.version,
};

License _$LicenseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('License', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['name', 'url'],
        requiredKeys: const ['name'],
        disallowNullValues: const ['name'],
      );
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

Map<String, dynamic> _$LicenseNodeToJson(LicenseNode instance) =>
    <String, dynamic>{'name': instance.name, 'url': ?instance.url};

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

Map<String, dynamic> _$LinkNodeToJson(LinkNode instance) => <String, dynamic>{
  'operationRef': ?instance.operationRef,
  'operationId': ?instance.operationId,
  'parameters': ?instance.parameters,
  'requestBody': ?instance.requestBody,
  'description': ?instance.description,
  'server': ?instance.server?.toJson(),
};

MediaType _$MediaTypeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MediaType', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['schema', 'example', 'examples', 'encoding'],
      );
      final val = MediaType(
        schema: $checkedConvert(
          'schema',
          (v) => v == null ? null : Ref<Schema>.fromJson(v),
        ),
        example: $checkedConvert('example', (v) => v),
        examples: $checkedConvert(
          'examples',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Example>.fromJson(e)),
          ),
        ),
        encoding: $checkedConvert(
          'encoding',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Encoding.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MediaTypeToJson(MediaType instance) => <String, dynamic>{
  'schema': ?instance.schema?.toJson(),
  'example': ?instance.example,
  'examples': ?instance.examples?.map((k, e) => MapEntry(k, e.toJson())),
  'encoding': ?instance.encoding?.map((k, e) => MapEntry(k, e.toJson())),
};

Map<String, dynamic> _$MediaTypeNodeToJson(MediaTypeNode instance) =>
    <String, dynamic>{
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
    requiredKeys: const ['scopes'],
    disallowNullValues: const ['scopes'],
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

Map<String, dynamic> _$OAuthFlowNodeToJson(OAuthFlowNode instance) =>
    <String, dynamic>{
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

Map<String, dynamic> _$OAuthFlowsNodeToJson(OAuthFlowsNode instance) =>
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
          'get',
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
          'get',
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
          (v) => (v as List<dynamic>?)
              ?.map((e) => Server.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        parameters: $checkedConvert(
          'parameters',
          (v) => (v as List<dynamic>?)?.map(Ref<Parameter>.fromJson).toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'get_': 'get'});

Map<String, dynamic> _$PathItemToJson(PathItem instance) => <String, dynamic>{
  'get': ?instance.get_?.toJson(),
  'put': ?instance.put?.toJson(),
  'post': ?instance.post?.toJson(),
  'delete': ?instance.delete?.toJson(),
  'options': ?instance.options?.toJson(),
  'head': ?instance.head?.toJson(),
  'patch': ?instance.patch?.toJson(),
  'trace': ?instance.trace?.toJson(),
  'servers': ?instance.servers?.map((e) => e.toJson()).toList(),
  'parameters': ?instance.parameters?.map((e) => e.toJson()).toList(),
};

Map<String, dynamic> _$PathItemNodeToJson(PathItemNode instance) =>
    <String, dynamic>{
      'get': ?instance.get_?.toJson(),
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

RequestBody _$RequestBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RequestBody', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['description', 'required', 'content'],
        requiredKeys: const ['required', 'content'],
        disallowNullValues: const ['required', 'content'],
      );
      final val = RequestBody(
        description: $checkedConvert('description', (v) => v as String?),
        required: $checkedConvert('required', (v) => v as bool),
        content: $checkedConvert(
          'content',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) =>
                MapEntry(k, MediaType.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RequestBodyToJson(RequestBody instance) =>
    <String, dynamic>{
      'description': ?instance.description,
      'required': instance.required,
      'content': instance.content.map((k, e) => MapEntry(k, e.toJson())),
    };

Map<String, dynamic> _$RequestBodyNodeToJson(RequestBodyNode instance) =>
    <String, dynamic>{
      'description': ?instance.description,
      'required': instance.required,
      'content': ?instance.content?.toJson(),
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
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Header>.fromJson(e)),
          ),
        ),
        content: $checkedConvert(
          'content',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, MediaType.fromJson(e as Map<String, dynamic>)),
          ),
        ),
        links: $checkedConvert(
          'links',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Ref<Link>.fromJson(e)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
  'description': ?instance.description,
  'headers': ?instance.headers?.map((k, e) => MapEntry(k, e.toJson())),
  'content': ?instance.content?.map((k, e) => MapEntry(k, e.toJson())),
  'links': ?instance.links?.map((k, e) => MapEntry(k, e.toJson())),
};

Map<String, dynamic> _$ResponseNodeToJson(ResponseNode instance) =>
    <String, dynamic>{
      'description': ?instance.description,
      'headers': ?instance.headers?.toJson(),
      'content': ?instance.content?.toJson(),
      'links': ?instance.links?.toJson(),
    };

SecurityRequirement _$SecurityRequirementFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SecurityRequirement', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['requirements'],
        requiredKeys: const ['requirements'],
        disallowNullValues: const ['requirements'],
      );
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

Map<String, dynamic> _$SecurityRequirementNodeToJson(
  SecurityRequirementNode instance,
) => <String, dynamic>{'requirements': instance.requirements};

SecurityScheme _$SecuritySchemeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SecurityScheme', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'type',
          'description',
          'name',
          'in',
          'scheme',
          'bearerFormat',
          'flows',
          'openIdConnectUrl',
        ],
        requiredKeys: const ['type'],
        disallowNullValues: const ['type'],
      );
      final val = SecurityScheme(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$SecuritySchemeTypeEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        in_: $checkedConvert(
          'in',
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
    }, fieldKeyMap: const {'in_': 'in'});

Map<String, dynamic> _$SecuritySchemeToJson(SecurityScheme instance) =>
    <String, dynamic>{
      'type': _$SecuritySchemeTypeEnumMap[instance.type]!,
      'description': ?instance.description,
      'name': ?instance.name,
      'in': ?_$SecuritySchemeInEnumMap[instance.in_],
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

Map<String, dynamic> _$SecuritySchemeNodeToJson(SecuritySchemeNode instance) =>
    <String, dynamic>{
      'type': _$SecuritySchemeTypeEnumMap[instance.type]!,
      'description': ?instance.description,
      'name': ?instance.name,
      'in': ?_$SecuritySchemeInEnumMap[instance.in_],
      'scheme': ?instance.scheme,
      'bearerFormat': ?instance.bearerFormat,
      'flows': ?instance.flows?.toJson(),
      'openIdConnectUrl': ?instance.openIdConnectUrl,
    };

Server _$ServerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Server', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['url', 'description', 'variables'],
        requiredKeys: const ['url'],
        disallowNullValues: const ['url'],
      );
      final val = Server(
        url: $checkedConvert('url', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        variables: $checkedConvert(
          'variables',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, ServerVariable.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
  'url': instance.url,
  'description': ?instance.description,
  'variables': ?instance.variables?.map((k, e) => MapEntry(k, e.toJson())),
};

Map<String, dynamic> _$ServerNodeToJson(ServerNode instance) =>
    <String, dynamic>{
      'url': instance.url,
      'description': ?instance.description,
      'variables': ?instance.variables?.toJson(),
    };

ServerVariable _$ServerVariableFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ServerVariable', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['enum', 'default', 'description'],
        requiredKeys: const ['default'],
        disallowNullValues: const ['default'],
      );
      final val = ServerVariable(
        enum_: $checkedConvert(
          'enum',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        default_: $checkedConvert('default', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'enum_': 'enum', 'default_': 'default'});

Map<String, dynamic> _$ServerVariableToJson(ServerVariable instance) =>
    <String, dynamic>{
      'enum': ?instance.enum_,
      'default': instance.default_,
      'description': ?instance.description,
    };

Map<String, dynamic> _$ServerVariableNodeToJson(ServerVariableNode instance) =>
    <String, dynamic>{
      'enum': ?instance.enum_,
      'default': instance.default_,
      'description': ?instance.description,
    };

Tag _$TagFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Tag', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['name', 'description', 'externalDocs'],
        requiredKeys: const ['name'],
        disallowNullValues: const ['name'],
      );
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

Map<String, dynamic> _$TagNodeToJson(TagNode instance) => <String, dynamic>{
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
    requiredKeys: const ['attribute', 'wrapped'],
    disallowNullValues: const ['attribute', 'wrapped'],
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

Map<String, dynamic> _$XMLNodeToJson(XMLNode instance) => <String, dynamic>{
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
        requiredKeys: const ['openapi', 'info', 'paths'],
        disallowNullValues: const ['openapi', 'info', 'paths'],
      );
      final val = OpenApiDocument(
        openapi: $checkedConvert('openapi', (v) => v as String),
        info: $checkedConvert(
          'info',
          (v) => Info.fromJson(v as Map<String, dynamic>),
        ),
        servers: $checkedConvert(
          'servers',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Server.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        paths: $checkedConvert(
          'paths',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, Ref<PathItem>.fromJson(e)),
          ),
        ),
        components: $checkedConvert(
          'components',
          (v) =>
              v == null ? null : Components.fromJson(v as Map<String, dynamic>),
        ),
        security: $checkedConvert(
          'security',
          (v) => (v as List<dynamic>?)
              ?.map(Ref<SecurityRequirement>.fromJson)
              .toList(),
        ),
        tags: $checkedConvert(
          'tags',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList(),
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
      'servers': ?instance.servers?.map((e) => e.toJson()).toList(),
      'paths': instance.paths.map((k, e) => MapEntry(k, e.toJson())),
      'components': ?instance.components?.toJson(),
      'security': ?instance.security?.map((e) => e.toJson()).toList(),
      'tags': ?instance.tags?.map((e) => e.toJson()).toList(),
      'externalDocs': ?instance.externalDocs?.toJson(),
    };

Map<String, dynamic> _$OpenApiDocumentNodeToJson(
  OpenApiDocumentNode instance,
) => <String, dynamic>{
  'openapi': instance.openapi,
  'info': ?instance.info?.toJson(),
  'servers': ?instance.servers?.toJson(),
  'paths': ?instance.paths?.toJson(),
  'components': ?instance.components?.toJson(),
  'security': ?instance.security?.toJson(),
  'tags': ?instance.tags?.toJson(),
  'externalDocs': ?instance.externalDocs?.toJson(),
};

Schema _$SchemaFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Schema',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'title',
        'description',
        'default',
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
        'required',
        'properties',
        'additionalPropertiesAllowed',
        'additionalProperties',
        'allOf',
        'oneOf',
        'anyOf',
        'enum',
        'nullable',
        'discriminator',
        'readOnly',
        'writeOnly',
        'xml',
        'externalDocs',
        'example',
        'deprecated',
      ],
      requiredKeys: const [
        'uniqueItems',
        'nullable',
        'readOnly',
        'writeOnly',
        'deprecated',
      ],
      disallowNullValues: const [
        'uniqueItems',
        'nullable',
        'readOnly',
        'writeOnly',
        'deprecated',
      ],
    );
    final val = Schema(
      title: $checkedConvert('title', (v) => v as String?),
      description: $checkedConvert('description', (v) => v as String?),
      default_: $checkedConvert('default', (v) => v),
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
        (v) => v == null ? null : Ref<Schema>.fromJson(v),
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
        'required',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      properties: $checkedConvert(
        'properties',
        (v) => (v as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, Ref<Schema>.fromJson(e)),
        ),
      ),
      additionalPropertiesAllowed: $checkedConvert(
        'additionalPropertiesAllowed',
        (v) => v as bool?,
      ),
      additionalProperties: $checkedConvert(
        'additionalProperties',
        (v) => v == null ? null : Ref<Schema>.fromJson(v),
      ),
      allOf: $checkedConvert(
        'allOf',
        (v) => (v as List<dynamic>?)?.map(Ref<Schema>.fromJson).toList(),
      ),
      oneOf: $checkedConvert(
        'oneOf',
        (v) => (v as List<dynamic>?)?.map(Ref<Schema>.fromJson).toList(),
      ),
      anyOf: $checkedConvert(
        'anyOf',
        (v) => (v as List<dynamic>?)?.map(Ref<Schema>.fromJson).toList(),
      ),
      enum_: $checkedConvert('enum', (v) => v as List<dynamic>?),
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
  },
  fieldKeyMap: const {
    'default_': 'default',
    'required_': 'required',
    'enum_': 'enum',
  },
);

Map<String, dynamic> _$SchemaToJson(Schema instance) => <String, dynamic>{
  'title': ?instance.title,
  'description': ?instance.description,
  'default': ?instance.default_,
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
  'required': ?instance.required_,
  'properties': ?instance.properties?.map((k, e) => MapEntry(k, e.toJson())),
  'additionalPropertiesAllowed': ?instance.additionalPropertiesAllowed,
  'additionalProperties': ?instance.additionalProperties?.toJson(),
  'allOf': ?instance.allOf?.map((e) => e.toJson()).toList(),
  'oneOf': ?instance.oneOf?.map((e) => e.toJson()).toList(),
  'anyOf': ?instance.anyOf?.map((e) => e.toJson()).toList(),
  'enum': ?instance.enum_,
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

Map<String, dynamic> _$SchemaNodeToJson(SchemaNode instance) =>
    <String, dynamic>{
      'title': ?instance.title,
      'description': ?instance.description,
      'default': ?instance.default_,
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
      'required': ?instance.required_,
      'properties': ?instance.properties?.toJson(),
      'additionalPropertiesAllowed': ?instance.additionalPropertiesAllowed,
      'additionalProperties': ?instance.additionalProperties?.toJson(),
      'allOf': ?instance.allOf?.toJson(),
      'oneOf': ?instance.oneOf?.toJson(),
      'anyOf': ?instance.anyOf?.toJson(),
      'enum': ?instance.enum_,
      'nullable': instance.nullable,
      'discriminator': ?instance.discriminator?.toJson(),
      'readOnly': instance.readOnly,
      'writeOnly': instance.writeOnly,
      'xml': ?instance.xml?.toJson(),
      'externalDocs': ?instance.externalDocs?.toJson(),
      'example': ?instance.example,
      'deprecated': instance.deprecated,
    };
