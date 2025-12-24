import '../node.dart';

class OAuthFlow extends Node {
  final String? authorizationUrl;
  final String? tokenUrl;
  final String? refreshUrl;
  final Map<String, String> scopes;
  final Map<String, dynamic>? extensions;

  OAuthFlow({this.authorizationUrl, this.tokenUrl, this.refreshUrl, required this.scopes, this.extensions});
}

class OAuthFlows extends Node {
  final OAuthFlow? implicit;
  final OAuthFlow? password;
  final OAuthFlow? clientCredentials;
  final OAuthFlow? authorizationCode;
  final Map<String, dynamic>? extensions;

  OAuthFlows({this.implicit, this.password, this.clientCredentials, this.authorizationCode, this.extensions});
}

