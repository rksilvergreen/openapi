import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'referenceable.dart';
import 'enums.dart';
import 'discriminator.dart';
import 'xml.dart';
import 'external_documentation.dart';
import 'json_helpers.dart';

part '_gen/schema_object.g.dart';

/// Schema Object - an extended subset of JSON Schema.
@CopyWith()
@JsonSerializable()
class SchemaObject implements OpenapiObject {
  // JSON Schema Core keywords
  @JsonKey(name: r'$ref')
  final String? ref;
  final String? title;
  final String? description;
  @JsonKey(name: 'default')
  final dynamic default_;

  // Type and format
  final SchemaType? type;
  final String? format;

  // Numeric validations
  final num? multipleOf;
  final num? maximum;
  final num? exclusiveMaximum;
  final num? minimum;
  final num? exclusiveMinimum;

  // String validations
  final int? maxLength;
  final int? minLength;
  final String? pattern;

  // Array validations
  final int? maxItems;
  final int? minItems;
  final bool uniqueItems;
  // @JsonKey(name: 'items', fromJson: _schemaFromJson, toJson: _schemaRefToJson)
  final Referenceable<SchemaObject>? items;

  // Object validations
  final int? maxProperties;
  final int? minProperties;
  @JsonKey(name: 'required')
  final List<String>? required_;
  // @JsonKey(name: 'properties', fromJson: _propertiesFromJson, toJson: _propertiesToJson)
  final Map<String, Referenceable<SchemaObject>>? properties;
  // @JsonKey(name: 'patternProperties', fromJson: _patternPropertiesFromJson, toJson: _patternPropertiesToJson)
  final Map<String, Referenceable<SchemaObject>>? patternProperties;
  // @JsonKey(name: 'additionalProperties', fromJson: additionalPropertiesFromJson, toJson: _additionalPropertiesToJson)
  final dynamic additionalProperties; // bool or SchemaObject

  // Composition
  // @JsonKey(name: 'allOf', fromJson: _allOfFromJson, toJson: _allOfToJson)
  final List<Referenceable<SchemaObject>>? allOf;
  // @JsonKey(name: 'oneOf', fromJson: _oneOfFromJson, toJson: _oneOfToJson)
  final List<Referenceable<SchemaObject>>? oneOf;
  // @JsonKey(name: 'anyOf', fromJson: _anyOfFromJson, toJson: _anyOfToJson)
  final List<Referenceable<SchemaObject>>? anyOf;
  // @JsonKey(name: 'not', fromJson: _schemaFromJson, toJson: _schemaRefToJson)
  final Referenceable<SchemaObject>? not;

  // Conditional
  @JsonKey(name: 'if')
  final Referenceable<SchemaObject>? if_;
  // @JsonKey(name: 'then', fromJson: _schemaFromJson, toJson: _schemaRefToJson)
  final Referenceable<SchemaObject>? then;
  @JsonKey(name: 'else')
  final Referenceable<SchemaObject>? else_;

  // Generic
  @JsonKey(name: 'enum')
  final List<dynamic>? enum_;
  @JsonKey(name: 'const')
  final dynamic const_;

  // OpenAPI-specific
  final bool nullable;
  final Discriminator? discriminator;
  final bool readOnly;
  final bool writeOnly;
  final XML? xml;
  final ExternalDocumentation? externalDocs;
  final dynamic example;
  final bool deprecated;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  SchemaObject({
    this.ref,
    this.title,
    this.description,
    this.default_,
    this.type,
    this.format,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.maxItems,
    this.minItems,
    this.uniqueItems = false,
    this.items,
    this.maxProperties,
    this.minProperties,
    this.required_,
    this.properties,
    this.patternProperties,
    this.additionalProperties,
    this.allOf,
    this.oneOf,
    this.anyOf,
    this.not,
    this.if_,
    this.then,
    this.else_,
    this.enum_,
    this.const_,
    this.nullable = false,
    this.discriminator,
    this.readOnly = false,
    this.writeOnly = false,
    this.xml,
    this.externalDocs,
    this.example,
    this.deprecated = false,
    this.extensions,
  });

  factory SchemaObject.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final schema = _$SchemaObjectFromJson(jsonWithoutExtensions(json));
    return schema.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$SchemaObjectToJson(this);
}

// // Helper functions for Referenceable parsing
// Referenceable<SchemaObject>? _schemaFromJson(dynamic json) =>
//     Referenceable.fromJson<SchemaObject>(json, SchemaObject.fromJson);

// dynamic additionalPropertiesFromJson(dynamic json) {
//   if (json == null) {
//     return null;
//   }
//   if (json is bool) {
//     return json;
//   }
//   if (json is Map) {
//     // Empty object {} means additionalProperties: true
//     if (json.isEmpty) {
//       return true;
//     }
//     // Parse as Referenceable<SchemaObject>
//     return Referenceable.fromJson<SchemaObject>(json, SchemaObject.fromJson);
//   }
//   throw ArgumentError('additionalProperties must be bool or Schema Object, got ${json.runtimeType}');
// }

// Map<String, Referenceable<SchemaObject>>? _propertiesFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<SchemaObject>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<SchemaObject>(entry.value, SchemaObject.fromJson);
//     if (value != null) {
//       result[entry.key.toString()] = value;
//     }
//   }
//   return result;
// }

// Map<String, Referenceable<SchemaObject>>? _patternPropertiesFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<SchemaObject>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<SchemaObject>(entry.value, SchemaObject.fromJson);
//     if (value != null) {
//       result[entry.key.toString()] = value;
//     }
//   }
//   return result;
// }

// List<Referenceable<SchemaObject>>? _allOfFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! List) return null;
//   return json
//       .map((item) => Referenceable.fromJson<SchemaObject>(item, SchemaObject.fromJson))
//       .whereType<Referenceable<SchemaObject>>()
//       .toList();
// }

// List<Referenceable<SchemaObject>>? _oneOfFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! List) return null;
//   return json
//       .map((item) => Referenceable.fromJson<SchemaObject>(item, SchemaObject.fromJson))
//       .whereType<Referenceable<SchemaObject>>()
//       .toList();
// }

// List<Referenceable<SchemaObject>>? _anyOfFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! List) return null;
//   return json
//       .map((item) => Referenceable.fromJson<SchemaObject>(item, SchemaObject.fromJson))
//       .whereType<Referenceable<SchemaObject>>()
//       .toList();
// }

// dynamic _schemaRefToJson(Referenceable<SchemaObject>? schema) {
//   if (schema == null) return null;
//   if (schema.isReference()) return schema.asReference();
//   return schema.asValue()?.toJson();
// }

// Map<String, dynamic>? _propertiesToJson(Map<String, Referenceable<SchemaObject>>? properties) {
//   if (properties == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in properties.entries) {
//     result[entry.key] = _schemaRefToJson(entry.value);
//   }
//   return result;
// }

// Map<String, dynamic>? _patternPropertiesToJson(Map<String, Referenceable<SchemaObject>>? properties) {
//   if (properties == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in properties.entries) {
//     result[entry.key] = _schemaRefToJson(entry.value);
//   }
//   return result;
// }

// List<dynamic>? _allOfToJson(List<Referenceable<SchemaObject>>? allOf) {
//   if (allOf == null) return null;
//   return allOf.map((item) => _schemaRefToJson(item)).toList();
// }

// List<dynamic>? _oneOfToJson(List<Referenceable<SchemaObject>>? oneOf) {
//   if (oneOf == null) return null;
//   return oneOf.map((item) => _schemaRefToJson(item)).toList();
// }

// List<dynamic>? _anyOfToJson(List<Referenceable<SchemaObject>>? anyOf) {
//   if (anyOf == null) return null;
//   return anyOf.map((item) => _schemaRefToJson(item)).toList();
// }

// dynamic _additionalPropertiesToJson(dynamic additionalProperties) {
//   if (additionalProperties == null) return null;
//   if (additionalProperties is bool) return additionalProperties;
//   if (additionalProperties is Referenceable<SchemaObject>) {
//     return _schemaRefToJson(additionalProperties);
//   }
//   throw ArgumentError('Cannot serialize additionalProperties of type ${additionalProperties.runtimeType}');
// }
