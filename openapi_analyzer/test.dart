
void main() {
  Map<String, dynamic> superMap = {
    'foo': 1,
    'baz': {
      'bar': 2,
      'qux': 3,
    }
  };

  Map<String, dynamic> subMap = superMap['baz'] as Map<String, dynamic>;
  subMap['qux'] = 4;

  print(superMap);
}