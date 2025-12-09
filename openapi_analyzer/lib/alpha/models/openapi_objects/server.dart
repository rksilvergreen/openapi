import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import 'json_helpers.dart';

part '_gen/server.g.dart';

/// Server Variable for server URL template substitution.
@CopyWith()
@JsonSerializable()
class ServerVariable implements OpenapiObject {
  @JsonKey(name: 'enum')
  final List<String>? enum_;
  @JsonKey(name: 'default')
  final String default_;
  final String? description;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  ServerVariable({
    this.enum_,
    required this.default_,
    this.description,
    this.extensions,
  });

  factory ServerVariable.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final serverVariable = _$ServerVariableFromJson(jsonWithoutExtensions(json));
    return serverVariable.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$ServerVariableToJson(this);
}

/// Server object representing a server.
@CopyWith()
@JsonSerializable()
class Server implements OpenapiObject {
  final String url;
  final String? description;
  final Map<String, ServerVariable>? variables;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Server({
    required this.url,
    this.description,
    this.variables,
    this.extensions,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final server = _$ServerFromJson(jsonWithoutExtensions(json));
    return server.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$ServerToJson(this);
}

