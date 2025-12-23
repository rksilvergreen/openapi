import 'dart:collection';

abstract class SecurityRequirement {
  Map<String, List<String>> get requirements;
}

abstract class SecurityRequirementsList implements ListBase<SecurityRequirement> {}
