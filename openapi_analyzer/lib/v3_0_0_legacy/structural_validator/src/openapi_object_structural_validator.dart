import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';
import 'components_object_structural_validator.dart';
import 'info_object_structural_validator.dart';
import 'paths_object_structural_validator.dart';
import 'server_object_structural_validator.dart';

/// Structural validator for the root OpenAPI Object (OpenAPI 3.0.0).
class OpenApiObjectStructuralValidator {
  /// Validates the structural correctness of the root OpenAPI Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateOpenApiField(data, path);
    _validateInfoField(data, path);
    _validatePathsField(data, path);
    _validateServersField(data, path);
    _validateComponentsField(data, path);
    _validateSecurityField(data, path);
    _validateTagsField(data, path);
    _validateExternalDocsField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateOpenApiField(Map<dynamic, dynamic> data, String path) {
    final openapi = ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'openapi', path),
      ValidationUtils.buildPath(path, 'openapi'),
    );

    if (openapi != '3.0.0') {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'openapi'),
        'openapi field must be "3.0.0", got: $openapi',
        specReference: 'OpenAPI 3.0.0 - OpenAPI Object',
        severity: ValidationSeverity.critical,
      );
    }
  }

  static void _validateInfoField(Map<dynamic, dynamic> data, String path) {
    final info = ValidationUtils.requireMap(
      ValidationUtils.requireField(data, 'info', path),
      ValidationUtils.buildPath(path, 'info'),
    );
    InfoObjectStructuralValidator.validate(info, ValidationUtils.buildPath(path, 'info'));
  }

  static void _validatePathsField(Map<dynamic, dynamic> data, String path) {
    final paths = ValidationUtils.requireMap(
      ValidationUtils.requireField(data, 'paths', path),
      ValidationUtils.buildPath(path, 'paths'),
    );
    PathsObjectStructuralValidator.validate(paths, ValidationUtils.buildPath(path, 'paths'));
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
            specReference: 'OpenAPI 3.0.0 - OpenAPI Object',
            severity: ValidationSeverity.critical,
          );
        }
        ServerObjectStructuralValidator.validate(server, ValidationUtils.buildPath(path, 'servers[$i]'));
      }
    }
  }

  static void _validateComponentsField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('components')) {
      final components = ValidationUtils.requireMap(data['components'], ValidationUtils.buildPath(path, 'components'));
      ComponentsObjectStructuralValidator.validate(components, ValidationUtils.buildPath(path, 'components'));
    }
  }

  static void _validateSecurityField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('security')) {
      final security = ValidationUtils.requireList(data['security'], ValidationUtils.buildPath(path, 'security'));
      for (var i = 0; i < security.length; i++) {
        _validateSecurityRequirement(security[i], i, path);
      }
    }
  }

  static void _validateSecurityRequirement(dynamic securityReq, int index, String path) {
    if (securityReq is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'security[$index]'),
        'Security requirement must be a Security Requirement Object',
        specReference: 'OpenAPI 3.0.0 - OpenAPI Object',
        severity: ValidationSeverity.critical,
      );
    }
    // Security Requirement Object is a map of security scheme names to scopes
    final securityReqMap = securityReq;
    for (final key in securityReqMap.keys) {
      final keyStr = key.toString();
      final scopes = securityReqMap[key];
      if (scopes is! List) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'security[$index].$keyStr'),
          'Security requirement scopes must be an array',
          severity: ValidationSeverity.critical,
          specReference: 'OpenAPI 3.0.0 - Security Requirement Object',
        );
      }
      // Each scope must be a string
      for (var j = 0; j < scopes.length; j++) {
        ValidationUtils.requireString(scopes[j], ValidationUtils.buildPath(path, 'security[$index].$keyStr[$j]'));
      }
    }
  }

  static void _validateTagsField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('tags')) {
      final tags = ValidationUtils.requireList(data['tags'], ValidationUtils.buildPath(path, 'tags'));
      for (var i = 0; i < tags.length; i++) {
        _validateTag(tags[i], i, path);
      }
    }
  }

  static void _validateTag(dynamic tag, int index, String path) {
    if (tag is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'tags[$index]'),
        'Tag must be a Tag Object',
        specReference: 'OpenAPI 3.0.0 - OpenAPI Object',
        severity: ValidationSeverity.critical,
      );
    }
    final tagMap = tag;
    // name is REQUIRED
    ValidationUtils.requireString(
      ValidationUtils.requireField(tagMap, 'name', ValidationUtils.buildPath(path, 'tags[$index]')),
      ValidationUtils.buildPath(path, 'tags[$index].name'),
    );

    // Optional fields
    if (tagMap.containsKey('description')) {
      ValidationUtils.requireString(tagMap['description'], ValidationUtils.buildPath(path, 'tags[$index].description'));
    }
    if (tagMap.containsKey('externalDocs')) {
      ValidationUtils.requireMap(tagMap['externalDocs'], ValidationUtils.buildPath(path, 'tags[$index].externalDocs'));
    }
  }

  static void _validateExternalDocsField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('externalDocs')) {
      final externalDocs = ValidationUtils.requireMap(
        data['externalDocs'],
        ValidationUtils.buildPath(path, 'externalDocs'),
      );
      _validateExternalDocs(externalDocs, ValidationUtils.buildPath(path, 'externalDocs'));
    }
  }

  static void _validateExternalDocs(Map<dynamic, dynamic> data, String path) {
    // url is REQUIRED
    ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'url', path),
      ValidationUtils.buildPath(path, 'url'),
    );

    // Optional fields
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'openapi', 'info', 'servers', 'paths', 'components', 'security', 'tags', 'externalDocs'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'OpenAPI Object');
  }
}
