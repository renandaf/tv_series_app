import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';

void main() {
  test('should be a subclass of Series entity', () async {
    final result = seriesDetail.toEntity();
    expect(result, detail);
  });
}
