import '../list_node.dart';
import 'dart:collection';
import 'security_requirement.dart';
import 'package:openapi_analyzer/v3_0_0/objects/security_requirement.dart';

class SecurityRequirementsListNode extends ListNode<SecurityRequirementNode, SecurityRequirement>
    implements SecurityRequirementsList {
  SecurityRequirementsListNode(super.json, super.document, super.jsonPointer);
}
