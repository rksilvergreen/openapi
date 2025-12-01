import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';
import 'schema_object_structural_validator.dart';
import 'reference_object_structural_validator.dart';

/// Structural validator for Components Objects (OpenAPI 3.0.0).
class ComponentsObjectStructuralValidator {
  /// Validates the structural correctness of a Components Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    final keyPattern = _getComponentKeyPattern();

    // Validate each component type
    _validateSchemasComponent(data, path, keyPattern);
    _validateResponsesComponent(data, path, keyPattern);
    _validateParametersComponent(data, path, keyPattern);
    _validateExamplesComponent(data, path, keyPattern);
    _validateRequestBodiesComponent(data, path, keyPattern);
    _validateHeadersComponent(data, path, keyPattern);
    _validateSecuritySchemesComponent(data, path, keyPattern);
    _validateLinksComponent(data, path, keyPattern);
    _validateCallbacksComponent(data, path, keyPattern);

    _validateAllowedFields(data, path);
  }

  static RegExp _getComponentKeyPattern() {
    return RegExp(r'^[a-zA-Z0-9\.\-_]+$');
  }

  static void _validateComponentKey(String keyStr, String componentType, String path) {
    final keyPattern = _getComponentKeyPattern();
    if (!keyPattern.hasMatch(keyStr)) {
      throw OpenApiValidationException(
        path,
        'Component key "$keyStr" does not match required pattern: ^[a-zA-Z0-9\\.\\-_]+\$',
        specReference: 'OpenAPI 3.0.0 - Components Object',
        severity: ValidationSeverity.critical,
      );
    }
  }

  static void _validateSchemasComponent(Map<dynamic, dynamic> data, String path, RegExp keyPattern) {
    if (data.containsKey('schemas')) {
      final schemas = ValidationUtils.requireMap(data['schemas'], ValidationUtils.buildPath(path, 'schemas'));
      for (final key in schemas.keys) {
        final keyStr = key.toString();
        _validateComponentKey(keyStr, 'schemas', ValidationUtils.buildPath(path, 'schemas.$keyStr'));

        final schema = schemas[key];
        if (schema is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'schemas.$keyStr'),
            'Schema must be a Schema Object or Reference Object',
            specReference: 'OpenAPI 3.0.0 - Components Object',
            severity: ValidationSeverity.critical,
          );
        }
        final schemaMap = schema;
        if (schemaMap.containsKey(r'$ref')) {
          ReferenceObjectStructuralValidator.validate(schemaMap, ValidationUtils.buildPath(path, 'schemas.$keyStr'));
        } else {
          SchemaObjectStructuralValidator.validate(schemaMap, ValidationUtils.buildPath(path, 'schemas.$keyStr'));
        }
      }
    }
  }

  static void _validateResponsesComponent(Map<dynamic, dynamic> data, String path, RegExp keyPattern) {
    if (data.containsKey('responses')) {
      final responses = ValidationUtils.requireMap(data['responses'], ValidationUtils.buildPath(path, 'responses'));
      for (final key in responses.keys) {
        final keyStr = key.toString();
        _validateComponentKey(keyStr, 'responses', ValidationUtils.buildPath(path, 'responses.$keyStr'));

        final response = responses[key];
        if (response is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'responses.$keyStr'),
            'Response must be a Response Object or Reference Object',
            specReference: 'OpenAPI 3.0.0 - Components Object',
            severity: ValidationSeverity.critical,
          );
        }
      }
    }
  }

  static void _validateParametersComponent(Map<dynamic, dynamic> data, String path, RegExp keyPattern) {
    if (data.containsKey('parameters')) {
      final parameters = ValidationUtils.requireMap(data['parameters'], ValidationUtils.buildPath(path, 'parameters'));
      for (final key in parameters.keys) {
        final keyStr = key.toString();
        _validateComponentKey(keyStr, 'parameters', ValidationUtils.buildPath(path, 'parameters.$keyStr'));

        final param = parameters[key];
        if (param is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'parameters.$keyStr'),
            'Parameter must be a Parameter Object or Reference Object',
            specReference: 'OpenAPI 3.0.0 - Components Object',
            severity: ValidationSeverity.critical,
          );
        }
      }
    }
  }

  static void _validateExamplesComponent(Map<dynamic, dynamic> data, String path, RegExp keyPattern) {
    if (data.containsKey('examples')) {
      final examples = ValidationUtils.requireMap(data['examples'], ValidationUtils.buildPath(path, 'examples'));
      for (final key in examples.keys) {
        final keyStr = key.toString();
        _validateComponentKey(keyStr, 'examples', ValidationUtils.buildPath(path, 'examples.$keyStr'));
      }
    }
  }

  static void _validateRequestBodiesComponent(Map<dynamic, dynamic> data, String path, RegExp keyPattern) {
    if (data.containsKey('requestBodies')) {
      final requestBodies = ValidationUtils.requireMap(
        data['requestBodies'],
        ValidationUtils.buildPath(path, 'requestBodies'),
      );
      for (final key in requestBodies.keys) {
        final keyStr = key.toString();
        _validateComponentKey(keyStr, 'requestBodies', ValidationUtils.buildPath(path, 'requestBodies.$keyStr'));

        final requestBody = requestBodies[key];
        if (requestBody is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'requestBodies.$keyStr'),
            'Request Body must be a Request Body Object or Reference Object',
            specReference: 'OpenAPI 3.0.0 - Components Object',
            severity: ValidationSeverity.critical,
          );
        }
      }
    }
  }

  static void _validateHeadersComponent(Map<dynamic, dynamic> data, String path, RegExp keyPattern) {
    if (data.containsKey('headers')) {
      final headers = ValidationUtils.requireMap(data['headers'], ValidationUtils.buildPath(path, 'headers'));
      for (final key in headers.keys) {
        final keyStr = key.toString();
        _validateComponentKey(keyStr, 'headers', ValidationUtils.buildPath(path, 'headers.$keyStr'));

        final header = headers[key];
        if (header is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'headers.$keyStr'),
            'Header must be a Header Object or Reference Object',
            specReference: 'OpenAPI 3.0.0 - Components Object',
            severity: ValidationSeverity.critical,
          );
        }
      }
    }
  }

  static void _validateSecuritySchemesComponent(Map<dynamic, dynamic> data, String path, RegExp keyPattern) {
    if (data.containsKey('securitySchemes')) {
      final securitySchemes = ValidationUtils.requireMap(
        data['securitySchemes'],
        ValidationUtils.buildPath(path, 'securitySchemes'),
      );
      for (final key in securitySchemes.keys) {
        final keyStr = key.toString();
        _validateComponentKey(keyStr, 'securitySchemes', ValidationUtils.buildPath(path, 'securitySchemes.$keyStr'));

        final securityScheme = securitySchemes[key];
        if (securityScheme is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'securitySchemes.$keyStr'),
            'Security Scheme must be a Security Scheme Object or Reference Object',
            specReference: 'OpenAPI 3.0.0 - Components Object',
            severity: ValidationSeverity.critical,
          );
        }
      }
    }
  }

  static void _validateLinksComponent(Map<dynamic, dynamic> data, String path, RegExp keyPattern) {
    if (data.containsKey('links')) {
      final links = ValidationUtils.requireMap(data['links'], ValidationUtils.buildPath(path, 'links'));
      for (final key in links.keys) {
        final keyStr = key.toString();
        _validateComponentKey(keyStr, 'links', ValidationUtils.buildPath(path, 'links.$keyStr'));
      }
    }
  }

  static void _validateCallbacksComponent(Map<dynamic, dynamic> data, String path, RegExp keyPattern) {
    if (data.containsKey('callbacks')) {
      final callbacks = ValidationUtils.requireMap(data['callbacks'], ValidationUtils.buildPath(path, 'callbacks'));
      for (final key in callbacks.keys) {
        final keyStr = key.toString();
        _validateComponentKey(keyStr, 'callbacks', ValidationUtils.buildPath(path, 'callbacks.$keyStr'));
      }
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {
      'schemas',
      'responses',
      'parameters',
      'examples',
      'requestBodies',
      'headers',
      'securitySchemes',
      'links',
      'callbacks',
    };
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Components Object');
  }
}
