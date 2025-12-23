import '../../../validation_exception.dart';

/// Context for collecting validation exceptions during OpenAPI processing.
/// 
/// Validation exceptions are collected rather than thrown immediately to allow
/// processing to continue and find all issues in a single pass.
class ValidationContext {
  final List<OpenApiValidationException> _exceptions = [];

  /// Adds a validation exception to the context.
  void addException(OpenApiValidationException exception) {
    _exceptions.add(exception);
  }

  /// Returns all collected exceptions.
  List<OpenApiValidationException> get exceptions => List.unmodifiable(_exceptions);

  /// Returns true if any exceptions have been collected.
  bool get hasExceptions => _exceptions.isNotEmpty;

  /// Returns true if any critical severity exceptions have been collected.
  bool get hasCriticalErrors => _exceptions.any((e) => e.severity == ValidationSeverity.critical);

  /// Returns true if any moderate or critical severity exceptions have been collected.
  bool get hasModerateOrCriticalErrors => 
      _exceptions.any((e) => e.severity == ValidationSeverity.moderate || e.severity == ValidationSeverity.critical);

  /// Throws an exception if validation has failed according to the strictness level.
  /// 
  /// - [strict]: All severities (critical, moderate, low) cause failure
  /// - [moderate]: Only critical and moderate severities cause failure
  /// - [permissive]: Only critical severity causes failure
  void throwIfFailed(ValidationStrictness strictness) {
    final criticalErrors = _exceptions.where((e) => e.severity == ValidationSeverity.critical).toList();
    final moderateErrors = _exceptions.where((e) => e.severity == ValidationSeverity.moderate).toList();
    final lowErrors = _exceptions.where((e) => e.severity == ValidationSeverity.low).toList();

    // Determine which errors should cause failure based on strictness
    List<OpenApiValidationException> failingErrors;
    List<OpenApiValidationException> warningErrors;

    switch (strictness) {
      case ValidationStrictness.strict:
        failingErrors = [...criticalErrors, ...moderateErrors, ...lowErrors];
        warningErrors = [];
        break;
      case ValidationStrictness.moderate:
        failingErrors = [...criticalErrors, ...moderateErrors];
        warningErrors = lowErrors;
        break;
      case ValidationStrictness.permissive:
        failingErrors = criticalErrors;
        warningErrors = [...moderateErrors, ...lowErrors];
        break;
    }

    // Print warnings
    if (warningErrors.isNotEmpty) {
      print('\n=== Validation Warnings ===');
      for (final error in warningErrors) {
        print(error.toString());
      }
      print('');
    }

    // Throw if there are failing errors
    if (failingErrors.isNotEmpty) {
      final buffer = StringBuffer('\n=== Validation Failed ===\n');
      for (final error in failingErrors) {
        buffer.writeln(error.toString());
      }
      throw ValidationFailedException(buffer.toString(), failingErrors);
    }
  }

  /// Clears all collected exceptions.
  void clear() {
    _exceptions.clear();
  }
}

/// Exception thrown when validation fails with collected errors.
class ValidationFailedException implements Exception {
  final String message;
  final List<OpenApiValidationException> errors;

  ValidationFailedException(this.message, this.errors);

  @override
  String toString() => message;
}

