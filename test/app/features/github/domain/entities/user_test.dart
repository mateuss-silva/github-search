import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/core/entities/entity.dart';
import 'package:github_search/app/features/github/domain/entities/user.dart';

void main() {
  final tUser = User(
    id: 1,
    username: "login",
    avatarUrl: "avatarUrl",
    name: "name",
    twitterUsername: "twitterUsername",
    location: "location",
    email: "email",
    bio: "bio",
    publicRepos: 1,
    publicGists: 1,
    followers: 1,
    following: 1,
    createdAt: DateTime.parse("2021-01-01 00:00:00.000"),
  );

  test("should be a entity", () {
    expect(tUser, isA<Entity>());
  });
}
