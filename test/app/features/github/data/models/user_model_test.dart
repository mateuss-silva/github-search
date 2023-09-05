import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/features/github/data/models/user_model.dart';

void main() {
  final tUser = UserModel(
    id: 1,
    username: "test",
    avatarUrl: "test",
    name: "test",
    location: "test",
    bio: "test",
    publicRepos: 1,
    followers: 1,
    following: 1,
    email: "test",
    createdAt: DateTime.parse("2021-01-01T00:00:00.000"),
    publicGists: 1,
    twitterUsername: "test",
  );

  group("fromJson", () {
    test("should return a valid model", () {
      final result = UserModel.fromJson(
        const {
          "id": 1,
          "login": "test",
          "avatar_url": "test",
          "name": "test",
          "location": "test",
          "bio": "test",
          "public_repos": 1,
          "followers": 1,
          "following": 1,
          "email": "test",
          "created_at": "2021-01-01T00:00:00.000",
          "public_gists": 1,
          "twitter_username": "test",
        },
      );

      expect(result, tUser);
    });
  });

  group("toJson", () {
    test("should return a JSON map containing the proper data", () {
      final result = tUser.toJson();

      expect(
        result,
        {
          "id": 1,
          "login": "test",
          "avatar_url": "test",
          "name": "test",
          "location": "test",
          "bio": "test",
          "public_repos": 1,
          "followers": 1,
          "following": 1,
          "email": "test",
          "created_at": "2021-01-01T00:00:00.000",
          "public_gists": 1,
          "twitter_username": "test",
        },
      );
    });
  });
}
