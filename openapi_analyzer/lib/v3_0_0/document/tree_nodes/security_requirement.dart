part of '../document.dart';

@CopyWith()
@JsonSerializable()
class SecurityRequirement extends TreeNode {
  final Map<String, List<String>> requirements;

  SecurityRequirement({required this.requirements});

  factory SecurityRequirement.fromJson(Map<String, dynamic> json) {
    return _$SecurityRequirementFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SecurityRequirementToJson(this);
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class SecurityRequirementsList extends ListTreeNode<SecurityRequirement> {
  SecurityRequirementsList(List<SecurityRequirement> requirements) : super(requirements);

  factory SecurityRequirementsList.fromJson(List<dynamic> json) {
    return SecurityRequirementsList(json.map((i) => SecurityRequirement.fromJson(i)).toList());
  }

  List<dynamic> toJson() {
    return map((item) => _$SecurityRequirementToJson(item)).toList();
  }
}

