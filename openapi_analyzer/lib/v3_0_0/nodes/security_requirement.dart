import '../node.dart';
import '../list_node.dart';

class SecurityRequirement extends Node {
  final Map<String, List<String>> requirements;

  SecurityRequirement({required this.requirements});
}

class SecurityRequirementsList extends ListNode<SecurityRequirement> {}
