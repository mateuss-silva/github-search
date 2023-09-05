import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/core/entities/entity.dart';
import 'package:github_search/app/features/github/domain/entities/simplified_user.dart';

void main() {
  const tSimplifiedUser = SimplifiedUser(
    id: 1,
    avatarUrl: "avatarUrl",
    username: "username",
  );

  test('should be a entity', () async {
    // assert
    expect(tSimplifiedUser, isA<Entity>());
  });
}
