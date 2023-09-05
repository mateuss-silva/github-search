import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/features/github/data/models/simplified_user_model.dart';

void main() {
  const tSimplifiedUser = SimplifiedUserModel(
    id: 1,
    username: "test",
    avatarUrl: "test",
  );

  test("fromJson", () {
    final result = SimplifiedUserModel.fromJson(
      const {
        "id": 1,
        "login": "test",
        "avatar_url": "test",
      },
    );

    expect(result, tSimplifiedUser);
  });

  test("toJson", () {
    final result = tSimplifiedUser.toJson();

    expect(
      result,
      {
        "id": 1,
        "login": "test",
        "avatar_url": "test",
      },
    );
  });
}
