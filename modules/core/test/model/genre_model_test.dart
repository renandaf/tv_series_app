import 'package:flutter_test/flutter_test.dart';

import '../dummy_object.dart';

void main() {
  test('should be a subclass of Movie entity', () async {
    final result = genreModel.toEntity();
    expect(result, genre);
  });
}
