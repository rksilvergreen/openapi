import 'package:json_annotation/json_annotation.dart';

/// Location of a parameter in the request.
enum ParameterLocation {
  @JsonValue('query')
  query,
  @JsonValue('header')
  header,
  @JsonValue('path')
  path,
  @JsonValue('cookie')
  cookie,
}

/// Serialization style for a parameter.
enum ParameterStyle {
  @JsonValue('matrix')
  matrix,
  @JsonValue('label')
  label,
  @JsonValue('form')
  form,
  @JsonValue('simple')
  simple,
  @JsonValue('spaceDelimited')
  spaceDelimited,
  @JsonValue('pipeDelimited')
  pipeDelimited,
  @JsonValue('deepObject')
  deepObject,
}

/// Type of security scheme.
enum SecuritySchemeType {
  @JsonValue('apiKey')
  apiKey,
  @JsonValue('http')
  http,
  @JsonValue('oauth2')
  oauth2,
  @JsonValue('openIdConnect')
  openIdConnect,
}

/// Location of API key in the request (for apiKey security scheme).
enum SecuritySchemeIn {
  @JsonValue('query')
  query,
  @JsonValue('header')
  header,
  @JsonValue('cookie')
  cookie,
}

/// JSON Schema type values for Schema Objects.
enum SchemaType {
  @JsonValue('string')
  string,
  @JsonValue('number')
  number,
  @JsonValue('integer')
  integer,
  @JsonValue('boolean')
  boolean,
  @JsonValue('array')
  array,
  @JsonValue('object')
  object,
  @JsonValue('null')
  null_,
}
