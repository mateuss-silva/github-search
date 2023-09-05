import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/core/entities/entity.dart';
import 'package:github_search/app/features/github/domain/entities/history.dart';

void main() {
  final tHistory = History(
    id: 1,
    query: 'query',
    createdAt: DateTime.parse('2020-01-01 00:00:00'),
  );

  test('should be a subclass of History entity', () async {
    // assert
    expect(tHistory, isA<Entity>());
  });
}
