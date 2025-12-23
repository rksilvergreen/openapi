/// Location of a parameter in the request.
enum ParameterLocation {
  query('query'),
  header('header'),
  path('path'),
  cookie('cookie');

  const ParameterLocation(this.value);
  final String value;
}

/// Serialization style for a parameter.
enum ParameterStyle {
  matrix('matrix'),
  label('label'),
  form('form'),
  simple('simple'),
  spaceDelimited('spaceDelimited'),
  pipeDelimited('pipeDelimited'),
  deepObject('deepObject');

  const ParameterStyle(this.value);
  final String value;
}

/// Type of security scheme.
enum SecuritySchemeType {
  apiKey('apiKey'),
  http('http'),
  oauth2('oauth2'),
  openIdConnect('openIdConnect');

  const SecuritySchemeType(this.value);
  final String value;
}

/// Location of API key in the request (for apiKey security scheme).
enum SecuritySchemeIn {
  query('query'),
  header('header'),
  cookie('cookie');

  const SecuritySchemeIn(this.value);
  final String value;
}


