import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/features/github/data/models/history_model.dart';

void main() {
  final tHistoryModel =
      HistoryModel(id: 1, query: "mat", createdAt: DateTime(2021, 10, 10));

  group("fromJson", () {
    test("should return a valid model", () {
      final result = HistoryModel.fromJson(
        {
          "id": 1,
          "query": "mat",
          "createdAt": DateTime(2021, 10, 10).toIso8601String(),
        },
      );

      expect(result, tHistoryModel);
    });
  });

  group("toJson", () {
    test("should return a valid json", () {
      final result = tHistoryModel.toJson();

      expect(
        result,
        {
          "id": 1,
          "query": "mat",
          "createdAt": DateTime(2021, 10, 10).toIso8601String(),
        },
      );
    });
  });
}
