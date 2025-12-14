import 'dart:io';

void main() {
  final dir = Directory('lib/v3_0_0/models/openapi_objects');
  final files = dir.listSync().where((e) => e.path.endsWith('.dart')).toList();
  
  for (final file in files) {
    if (file is! File) continue;
    final content = (file as File).readAsStringSync();
    
    // Pattern 1: Replace constructor that calls stages
    final pattern1 = RegExp(
      r'(\w+Node)\(super\.\$id, super\.json\) \{\s*_validateStructure\(\);\s*(?:_createChildNodes\(\);\s*)?_createContent\(\);\s*\}',
      multiLine: true,
    );
    
    var newContent = content.replaceAllMapped(pattern1, (match) {
      final className = match.group(1);
      final hasChildNodes = match.group(0)!.contains('_createChildNodes');
      
      if (hasChildNodes) {
        return '''$className(super.\$id, super.json);

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }''';
      } else {
        return '''$className(super.\$id, super.json);

  void create() {
    _validateStructure();
    _createContent();
  }''';
      }
    });
    
    // Pattern 2: Add _contentCreated = true if missing
    if (!newContent.contains('_contentCreated = true')) {
      newContent = newContent.replaceAllMapped(
        RegExp(r'(void _createContent\(\) \{[^}]+)(\}\s*\})'),
        (match) => '${match.group(1)}\n    _contentCreated = true;${match.group(2)}',
      );
    }
    
    if (newContent != content) {
      file.writeAsStringSync(newContent);
      print('Updated: ${file.path}');
    }
  }
}

