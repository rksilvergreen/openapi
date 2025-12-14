import 'validation_exception.dart';
import 'validation_utils.dart';
import 'operation_object_validator.dart';
import 'parameter_object_validator.dart';
import 'reference_object_validator.dart';
import 'server_object_validator.dart';

/// Validator for Path Item Objects according to OpenAPI 3.0.0 specification.
class PathItemObjectValidator {
  /// Validates a Path Item Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    // If it's a reference, validate and return early
    if (_validateReferenceField(data, path)) {
      return;
    }

    _validateHttpMethodFields(data, path);
    _validateSummaryField(data, path);
    _validateDescriptionField(data, path);
    _validateServersField(data, path);
    _validateParametersField(data, path);
    _validateAllowedFields(data, path);
  }

  static bool _validateReferenceField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey(r'$ref')) {
      ReferenceObjectValidator.validate(data, path);
      return true;
    }
    return false;
  }

  static void _validateHttpMethodFields(Map<dynamic, dynamic> data, String path) {
    const httpMethods = ['get', 'put', 'post', 'delete', 'options', 'head', 'patch', 'trace'];
    for (final method in httpMethods) {
      if (data.containsKey(method)) {
        _validateHttpMethod(data[method], method, path);
      }
    }
  }

  static void _validateHttpMethod(dynamic operation, String method, String path) {
    if (operation is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, method),
        'Operation must be an Operation Object',
        specReference: 'OpenAPI 3.0.0 - Path Item Object',
      );
    }
    OperationObjectValidator.validate(
      operation,
      ValidationUtils.buildPath(path, method),
    );
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

  static void _validateServersField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('servers')) {
      final servers = ValidationUtils.requireList(data['servers'], ValidationUtils.buildPath(path, 'servers'));
      for (var i = 0; i < servers.length; i++) {
        _validateServer(servers[i], i, path);
      }
    }
  }

  static void _validateServer(dynamic server, int index, String path) {
    if (server is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'servers[$index]'),
        'Server must be a Server Object',
        specReference: 'OpenAPI 3.0.0 - Path Item Object',
      );
    }
    ServerObjectValidator.validate(
      server,
      ValidationUtils.buildPath(path, 'servers[$index]'),
    );
  }

  static void _validateParametersField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('parameters')) {
      final parameters = ValidationUtils.requireList(
        data['parameters'],
        ValidationUtils.buildPath(path, 'parameters'),
      );
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
          specReference: 'OpenAPI 3.0.0 - Path Item Object',
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
            specReference: 'OpenAPI 3.0.0 - Path Item Object',
          );
        }
        paramKeys.add(key);
      }
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {
      r'$ref',
      'summary',
      'description',
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
    };
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Path Item Object');
  }
}
