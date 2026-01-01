part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class SecurityRequirement {
  @JsonKey(required: true, disallowNullValue: true)
  final Map<String, List<String>> requirements;

  SecurityRequirement({required this.requirements});

  factory SecurityRequirement.fromJson(Map<String, dynamic> json) {
    return _$SecurityRequirementFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SecurityRequirementToJson(this);
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class SecurityRequirementNode extends TreeNode {
  Map<String, List<String>> requirements;

  SecurityRequirementNode({
    required this.requirements,
  });

  Map<String, dynamic> toJson() {
    return _$SecurityRequirementNodeToJson(this);
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class SecurityRequirementsList extends ListTreeNode<SecurityRequirementNode> {
  List<dynamic> toJson() {
    return map((item) => _$SecurityRequirementNodeToJson(item)).toList();
  }
}

