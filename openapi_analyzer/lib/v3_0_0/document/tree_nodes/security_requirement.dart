part of '../document.dart';

@CopyWith()
@JsonSerializable()
class SecurityRequirement extends TreeNode {
  final Map<String, List<String>> requirements;

  SecurityRequirement({required this.requirements});

  factory SecurityRequirement.fromJson(Map<String, dynamic> json) {
    return _$SecurityRequirementFromJson(json);
  }
}

@CopyWith()
@JsonSerializable(createFactory: false)
class SecurityRequirementsList extends ListTreeNode<SecurityRequirement> {
  SecurityRequirementsList(List<SecurityRequirement> requirements) : super(requirements);

  factory SecurityRequirementsList.fromJson(List<dynamic> json) {
    return SecurityRequirementsList(json.map((i) => SecurityRequirement.fromJson(i)).toList());
  }
}

