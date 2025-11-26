import 'validation_exception.dart';
import 'validation_utils.dart';
import 'parameter_object_validator.dart';
import 'reference_object_validator.dart';
import 'request_body_object_validator.dart';
import 'responses_object_validator.dart';
import 'server_object_validator.dart';

/// Validator for Operation Objects according to OpenAPI 3.0.0 specification.
class OperationObjectValidator {
  /// Validates an Operation Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateResponsesField(data, path);
    _validateTagsField(data, path);
    _validateSummaryField(data, path);
    _validateDescriptionField(data, path);
    _validateExternalDocsField(data, path);
    _validateOperationIdField(data, path);
    _validateParametersField(data, path);
    _validateRequestBodyField(data, path);
    _validateCallbacksField(data, path);
    _validateDeprecatedField(data, path);
    _validateSecurityField(data, path);
    _validateServersField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateResponsesField(Map<dynamic, dynamic> data, String path) {
    final responses = ValidationUtils.requireMap(ValidationUtils.requireField(data, 'responses', path), ValidationUtils.buildPath(path, 'responses'));
    ResponsesObjectValidator.validate(responses, ValidationUtils.buildPath(path, 'responses'));
  }

  static void _validateTagsField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('tags')) {
      final tags = ValidationUtils.requireList(data['tags'], ValidationUtils.buildPath(path, 'tags'));
      for (var i = 0; i < tags.length; i++) {
        ValidationUtils.requireString(tags[i], ValidationUtils.buildPath(path, 'tags[$i]'));
      }
    }
  }

  static void _validateSummaryField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('summary')) {
      ValidationUtils.requireString(data['summary'], ValidationUtils.buildPath(path, 'summary'));
    }
  }

  static void _validateDescriptionField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }
  }

  static void _validateExternalDocsField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('externalDocs')) {
      ValidationUtils.requireMap(data['externalDocs'], ValidationUtils.buildPath(path, 'externalDocs'));
      // External Documentation Object validation is handled separately
    }
  }

  static void _validateOperationIdField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('operationId')) {
      ValidationUtils.requireString(data['operationId'], ValidationUtils.buildPath(path, 'operationId'));
    }
  }

  static void _validateParametersField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('parameters')) {
      final parameters = ValidationUtils.requireList(data['parameters'], ValidationUtils.buildPath(path, 'parameters'));
      _validateParametersList(parameters, path);
      _checkDuplicateParameters(parameters, path);
    }
  }

  static void _validateParametersList(List<dynamic> parameters, String path) {
    for (var i = 0; i < parameters.length; i++) {
      final param = parameters[i];
      if (param is! Map) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'parameters[$i]'),
          'Parameter must be a Parameter Object or Reference Object',
          specReference: 'OpenAPI 3.0.0 - Operation Object',
        );
      }
      final paramMap = param;
      if (paramMap.containsKey(r'$ref')) {
        ReferenceObjectValidator.validate(paramMap, ValidationUtils.buildPath(path, 'parameters[$i]'));
      } else {
        ParameterObjectValidator.validate(paramMap, ValidationUtils.buildPath(path, 'parameters[$i]'));
      }
    }
  }

  static void _checkDuplicateParameters(List<dynamic> parameters, String path) {
    final paramKeys = <String>{};
    for (var i = 0; i < parameters.length; i++) {
      final param = parameters[i] as Map<dynamic, dynamic>;
      if (!param.containsKey(r'$ref')) {
        final name = param['name'] as String;
        final inValue = param['in'] as String;
        final key = '$name:$inValue';
        if (paramKeys.contains(key)) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'parameters[$i]'),
            'Duplicate parameter: $name with location $inValue',
            specReference: 'OpenAPI 3.0.0 - Operation Object',
          );
        }
        paramKeys.add(key);
      }
    }
  }

  static void _validateRequestBodyField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('requestBody')) {
      final requestBody = data['requestBody'];
      if (requestBody is! Map) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'requestBody'),
          'requestBody must be a Request Body Object or Reference Object',
          specReference: 'OpenAPI 3.0.0 - Operation Object',
        );
      }
      final requestBodyMap = requestBody;
      if (requestBodyMap.containsKey(r'$ref')) {
        ReferenceObjectValidator.validate(requestBodyMap, ValidationUtils.buildPath(path, 'requestBody'));
      } else {
        RequestBodyObjectValidator.validate(requestBodyMap, ValidationUtils.buildPath(path, 'requestBody'));
      }
    }
  }

  static void _validateCallbacksField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('callbacks')) {
      ValidationUtils.requireMap(data['callbacks'], ValidationUtils.buildPath(path, 'callbacks'));
      // Callback Object validation is handled separately
    }
  }

  static void _validateDeprecatedField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('deprecated')) {
      ValidationUtils.requireBool(data['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }
  }

  static void _validateSecurityField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('security')) {
      ValidationUtils.requireList(data['security'], ValidationUtils.buildPath(path, 'security'));
      // Security Requirement Object validation is handled separately
    }
  }

  static void _validateServersField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('servers')) {
      final servers = ValidationUtils.requireList(data['servers'], ValidationUtils.buildPath(path, 'servers'));
      for (var i = 0; i < servers.length; i++) {
        final server = servers[i];
        if (server is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'servers[$i]'),
            'Server must be a Server Object',
            specReference: 'OpenAPI 3.0.0 - Operation Object',
          );
        }
        ServerObjectValidator.validate(server, ValidationUtils.buildPath(path, 'servers[$i]'));
      }
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {
      'tags',
      'summary',
      'description',
      'externalDocs',
      'operationId',
      'parameters',
      'requestBody',
      'responses',
      'callbacks',
      'deprecated',
      'security',
      'servers',
    };
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Operation Object');
  }
}

