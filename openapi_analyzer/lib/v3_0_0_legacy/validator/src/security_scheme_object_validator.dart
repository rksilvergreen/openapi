import 'validation_exception.dart';
import 'validation_utils.dart';

/// Validator for Security Scheme Objects according to OpenAPI 3.0.0 specification.
class SecuritySchemeObjectValidator {
  /// Validates a Security Scheme Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    final type = _validateTypeField(data, path);
    _validateDescriptionField(data, path);
    _validateTypeSpecificFields(data, path, type);
    _validateAllowedFields(data, path, type);
  }

  static String _validateTypeField(Map<dynamic, dynamic> data, String path) {
    final type = ValidationUtils.requireString(ValidationUtils.requireField(data, 'type', path), ValidationUtils.buildPath(path, 'type'));
    const validTypes = ['apiKey', 'http', 'oauth2', 'openIdConnect'];
    ValidationUtils.validateEnum(type, validTypes, ValidationUtils.buildPath(path, 'type'));
    return type;
  }

  static void _validateDescriptionField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }
  }

  static void _validateTypeSpecificFields(Map<dynamic, dynamic> data, String path, String type) {
    switch (type) {
      case 'apiKey':
        _validateApiKeyFields(data, path);
        break;
      case 'http':
        _validateHttpFields(data, path);
        break;
      case 'oauth2':
        _validateOAuth2Fields(data, path);
        break;
      case 'openIdConnect':
        _validateOpenIdConnectFields(data, path);
        break;
    }
  }

  static void _validateApiKeyFields(Map<dynamic, dynamic> data, String path) {
    // name is REQUIRED for apiKey
    ValidationUtils.requireString(ValidationUtils.requireField(data, 'name', path), ValidationUtils.buildPath(path, 'name'));

    // in is REQUIRED for apiKey
    final inValue = ValidationUtils.requireString(ValidationUtils.requireField(data, 'in', path), ValidationUtils.buildPath(path, 'in'));
    const validInValues = ['query', 'header', 'cookie'];
    ValidationUtils.validateEnum(inValue, validInValues, ValidationUtils.buildPath(path, 'in'));
  }

  static void _validateHttpFields(Map<dynamic, dynamic> data, String path) {
    // scheme is REQUIRED for http
    final scheme = ValidationUtils.requireString(ValidationUtils.requireField(data, 'scheme', path), ValidationUtils.buildPath(path, 'scheme'));

    // bearerFormat is optional (only for bearer scheme)
    if (data.containsKey('bearerFormat')) {
      _validateBearerFormat(data, path, scheme);
    }
  }

  static void _validateBearerFormat(Map<dynamic, dynamic> data, String path, String scheme) {
    if (scheme != 'bearer') {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'bearerFormat'),
        'bearerFormat is only valid when scheme is "bearer"',
        specReference: 'OpenAPI 3.0.0 - Security Scheme Object',
      );
    }
    ValidationUtils.requireString(data['bearerFormat'], ValidationUtils.buildPath(path, 'bearerFormat'));
  }

  static void _validateOAuth2Fields(Map<dynamic, dynamic> data, String path) {
    // flows is REQUIRED for oauth2
    final flows = ValidationUtils.requireMap(ValidationUtils.requireField(data, 'flows', path), ValidationUtils.buildPath(path, 'flows'));
    _validateOAuthFlowsObject(flows, ValidationUtils.buildPath(path, 'flows'));
  }

  static void _validateOpenIdConnectFields(Map<dynamic, dynamic> data, String path) {
    // openIdConnectUrl is REQUIRED for openIdConnect
    final openIdConnectUrl = ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'openIdConnectUrl', path),
      ValidationUtils.buildPath(path, 'openIdConnectUrl'),
    );
    if (openIdConnectUrl.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'openIdConnectUrl'),
        'openIdConnectUrl cannot be empty',
        specReference: 'OpenAPI 3.0.0 - Security Scheme Object',
      );
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path, String type) {
    final allowedFields = <String>{'type', 'description'};

    switch (type) {
      case 'apiKey':
        allowedFields.addAll(['name', 'in']);
        break;
      case 'http':
        allowedFields.addAll(['scheme', 'bearerFormat']);
        break;
      case 'oauth2':
        allowedFields.add('flows');
        break;
      case 'openIdConnect':
        allowedFields.add('openIdConnectUrl');
        break;
    }

    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Security Scheme Object');
  }

  static void _validateOAuthFlowsObject(Map<dynamic, dynamic> data, String path) {
    const validFlowTypes = ['implicit', 'password', 'clientCredentials', 'authorizationCode'];
    bool hasAnyFlow = false;

    for (final flowType in validFlowTypes) {
      if (data.containsKey(flowType)) {
        hasAnyFlow = true;
        final flow = ValidationUtils.requireMap(data[flowType], ValidationUtils.buildPath(path, flowType));
        _validateOAuthFlowObject(flow, ValidationUtils.buildPath(path, flowType), flowType);
      }
    }

    if (!hasAnyFlow) {
      throw OpenApiValidationException(
        path,
        'OAuth Flows Object must contain at least one flow type',
        specReference: 'OpenAPI 3.0.0 - OAuth Flows Object',
      );
    }
  }

  static void _validateOAuthFlowObject(Map<dynamic, dynamic> data, String path, String flowType) {
    _validateFlowScopes(data, path);
    _validateFlowAuthorizationUrl(data, path, flowType);
    _validateFlowTokenUrl(data, path, flowType);
    _validateFlowRefreshUrl(data, path);
  }

  static void _validateFlowScopes(Map<dynamic, dynamic> data, String path) {
    final scopes = ValidationUtils.requireMap(ValidationUtils.requireField(data, 'scopes', path), ValidationUtils.buildPath(path, 'scopes'));

    if (scopes.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'scopes'),
        'OAuth Flow scopes map cannot be empty',
        specReference: 'OpenAPI 3.0.0 - OAuth Flow Object',
      );
    }

    // Validate scope keys and values are strings
    for (final key in scopes.keys) {
      final keyStr = key.toString();
      ValidationUtils.requireString(scopes[key], ValidationUtils.buildPath(path, 'scopes.$keyStr'));
    }
  }

  static void _validateFlowAuthorizationUrl(Map<dynamic, dynamic> data, String path, String flowType) {
    if (flowType == 'implicit' || flowType == 'authorizationCode') {
      final authorizationUrl = ValidationUtils.requireString(
        ValidationUtils.requireField(data, 'authorizationUrl', path),
        ValidationUtils.buildPath(path, 'authorizationUrl'),
      );
      if (authorizationUrl.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'authorizationUrl'),
          'authorizationUrl cannot be empty',
          specReference: 'OpenAPI 3.0.0 - OAuth Flow Object',
        );
      }
    }
  }

  static void _validateFlowTokenUrl(Map<dynamic, dynamic> data, String path, String flowType) {
    if (flowType == 'password' || flowType == 'clientCredentials' || flowType == 'authorizationCode') {
      final tokenUrl = ValidationUtils.requireString(ValidationUtils.requireField(data, 'tokenUrl', path), ValidationUtils.buildPath(path, 'tokenUrl'));
      if (tokenUrl.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'tokenUrl'),
          'tokenUrl cannot be empty',
          specReference: 'OpenAPI 3.0.0 - OAuth Flow Object',
        );
      }
    }
  }

  static void _validateFlowRefreshUrl(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('refreshUrl')) {
      final refreshUrl = ValidationUtils.requireString(data['refreshUrl'], ValidationUtils.buildPath(path, 'refreshUrl'));
      if (refreshUrl.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'refreshUrl'),
          'refreshUrl cannot be empty',
          specReference: 'OpenAPI 3.0.0 - OAuth Flow Object',
        );
      }
    }
  }
}
