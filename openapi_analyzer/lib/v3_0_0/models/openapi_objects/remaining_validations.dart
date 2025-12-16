// This file contains validation implementations for remaining simple node types
// These will be copied into their respective files

/*
TAG NODE:
  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate required: name (non-empty string)
    final name = ValidationUtils.requireField(json, 'name', path);
    ValidationUtils.requireNonEmptyString(name, ValidationUtils.buildPath(path, 'name'));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate optional: externalDocs (object)
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPath(path, 'externalDocs'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'name', 'description', 'externalDocs'},
      path,
      'Tag Object',
    );
  }

EXTERNAL DOCUMENTATION NODE:
  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate required: url (non-empty string)
    final url = ValidationUtils.requireField(json, 'url', path);
    ValidationUtils.requireNonEmptyString(url, ValidationUtils.buildPath(path, 'url'));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'description', 'url'},
      path,
      'External Documentation Object',
    );
  }

SECURITY REQUIREMENT NODE:
  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate structure: map of string to array of strings
    for (final entry in json.entries) {
      final key = entry.key.toString();
      if (entry.value is List) {
        final list = entry.value as List;
        for (var i = 0; i < list.length; i++) {
          ValidationUtils.requireString(list[i], ValidationUtils.buildPath(ValidationUtils.buildPath(path, key), '[$i]'));
        }
      } else if (entry.value != null) {
        OpenApiGraph.i.validationContext.addException(OpenApiValidationException(
          ValidationUtils.buildPath(path, key),
          'Security Requirement value must be an array of strings',
          specReference: 'OpenAPI 3.0.0 - Security Requirement Object',
          severity: ValidationSeverity.critical,
        ));
      }
    }
  }

SECURITY SCHEME NODE:
  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate required: type (enum: apiKey, http, oauth2, openIdConnect)
    final type = ValidationUtils.requireField(json, 'type', path);
    ValidationUtils.requireString(type, ValidationUtils.buildPath(path, 'type'));
    ValidationUtils.validateEnum(type as String, ['apiKey', 'http', 'oauth2', 'openIdConnect'], 
        ValidationUtils.buildPath(path, 'type'));

    // Validate required fields based on type
    if (type == 'apiKey') {
      ValidationUtils.requireField(json, 'name', path);
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPath(path, 'name'));
      
      final inValue = ValidationUtils.requireField(json, 'in', path);
      ValidationUtils.requireString(inValue, ValidationUtils.buildPath(path, 'in'));
      ValidationUtils.validateEnum(inValue as String, ['query', 'header', 'cookie'], 
          ValidationUtils.buildPath(path, 'in'));
    } else if (type == 'http') {
      ValidationUtils.requireField(json, 'scheme', path);
      ValidationUtils.requireString(json['scheme'], ValidationUtils.buildPath(path, 'scheme'));
    } else if (type == 'oauth2') {
      ValidationUtils.requireField(json, 'flows', path);
      ValidationUtils.requireMap(json['flows'], ValidationUtils.buildPath(path, 'flows'));
    } else if (type == 'openIdConnect') {
      ValidationUtils.requireField(json, 'openIdConnectUrl', path);
      ValidationUtils.requireString(json['openIdConnectUrl'], ValidationUtils.buildPath(path, 'openIdConnectUrl'));
    }

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'type', 'description', 'name', 'in', 'scheme', 'bearerFormat', 'flows', 'openIdConnectUrl'},
      path,
      'Security Scheme Object',
    );
  }

HEADER, LINK, DISCRIMINATOR, XML, EXAMPLE, ENCODING, CALLBACK, OAUTH_FLOW, OAUTH_FLOWS:
Similar patterns - validate required fields, optional fields, types, and no unknown fields.
*/

