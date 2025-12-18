import '../list_node.dart';
import 'dart:collection';
import 'security_requirement.dart';

abstract class SecurityRequirementsList implements ListBase<SecurityRequirement> {}

class SecurityRequirementsListNode extends ListNode<SecurityRequirementNode, SecurityRequirement>
    implements SecurityRequirementsList {
  SecurityRequirementsListNode(super.json, super.document, super.jsonPointer);
}
