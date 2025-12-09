import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import '../referenceable.dart';
import 'parameter.dart';
import 'operation.dart';
import 'server.dart';
import 'json_helpers.dart';

part '_gen/paths.g.dart';

/// Holds the relative paths to the individual endpoints and their operations.
@CopyWith()
@JsonSerializable(createFactory: false)
class Paths implements OpenapiObject {
  final Map<String, PathItem> paths;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Paths({
    required this.paths,
    this.extensions,
  });

  factory Paths.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final paths = <String, PathItem>{};
    final cleanedJson = jsonWithoutExtensions(json);
    for (final entry in cleanedJson.entries) {
      final key = entry.key.toString();
      if (entry.value is Map) {
        paths[key] = PathItem.fromJson(Map<String, dynamic>.from(entry.value));
      }
    }
    return Paths(
      paths: paths,
      extensions: extensions,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$PathsToJson(this);
}

/// Describes the operations available on a single path.
@CopyWith()
@JsonSerializable()
class PathItem implements OpenapiObject {
  @JsonKey(name: r'$ref')
  final String? ref;
  final String? summary;
  final String? description;
  @JsonKey(name: 'get')
  final Operation? get_;
  final Operation? put;
  final Operation? post;
  final Operation? delete;
  final Operation? options;
  final Operation? head;
  final Operation? patch;
  final Operation? trace;
  final List<Server>? servers;
  // @JsonKey(fromJson: _parametersFromJson, toJson: _parametersToJson)
  final List<Referenceable<Parameter>>? parameters;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  PathItem({
    this.ref,
    this.summary,
    this.description,
    this.get_,
    this.put,
    this.post,
    this.delete,
    this.options,
    this.head,
    this.patch,
    this.trace,
    this.servers,
    this.parameters,
    this.extensions,
  });

  factory PathItem.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final pathItem = _$PathItemFromJson(jsonWithoutExtensions(json));
    return pathItem.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$PathItemToJson(this);
}

// List<Referenceable<Parameter>>? _parametersFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! List) return null;
//   return json.map((item) => Referenceable.fromJson<Parameter>(item, Parameter.fromJson)).whereType<Referenceable<Parameter>>().toList();
// }

// List<dynamic>? _parametersToJson(List<Referenceable<Parameter>>? parameters) {
//   if (parameters == null) return null;
//   return parameters.map((p) {
//     if (p.isReference()) return p.asReference();
//     return p.asValue()?.toJson();
//   }).toList();
// }
