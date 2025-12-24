abstract class OAuthFlow {
  String? get authorizationUrl;
  String? get tokenUrl;
  String? get refreshUrl;
  Map<String, String> get scopes;
  Map<String, dynamic>? get extensions;
}

abstract class OAuthFlows {
  OAuthFlow? get implicit;
  OAuthFlow? get password;
  OAuthFlow? get clientCredentials;
  OAuthFlow? get authorizationCode;
  Map<String, dynamic>? get extensions;
}

