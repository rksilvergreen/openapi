/// Helper function to extract x-* extension fields from JSON map.
Map<String, dynamic>? extractExtensions(Map<String, dynamic> json) {
  final extensions = <String, dynamic>{};
  for (final entry in json.entries) {
    if (entry.key.startsWith('x-')) {
      extensions[entry.key] = entry.value;
    }
  }
  return extensions.isEmpty ? null : extensions;
}

/// Helper function to create a copy of JSON map without x-* fields.
Map<String, dynamic> jsonWithoutExtensions(Map<String, dynamic> json) {
  final result = <String, dynamic>{};
  for (final entry in json.entries) {
    if (!entry.key.startsWith('x-')) {
      result[entry.key] = entry.value;
    }
  }
  return result;
}
