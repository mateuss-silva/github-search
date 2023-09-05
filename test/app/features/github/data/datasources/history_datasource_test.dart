import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/features/github/data/datasources/history_datasource_impl.dart';
import 'package:github_search/app/features/github/data/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late HistoryDataSourceImpl historyDataSource;

  final historySetup = [
    json.encode(
        HistoryModel(id: 1, query: "mat", createdAt: DateTime(2021, 10, 10))
            .toJson()),
    json.encode(
        HistoryModel(id: 2, query: "tes", createdAt: DateTime(2022, 10, 2))
            .toJson()),
    json.encode(
        HistoryModel(id: 3, query: "car", createdAt: DateTime(2023, 10, 11))
            .toJson()),
  ];

  setUp(() async {
    SharedPreferences.setMockInitialValues({"history": historySetup});
    historyDataSource = HistoryDataSourceImpl();
  });

  group("HistoryDataSource success", () {
    test("should return list of history", () async {
      final result = await historyDataSource.getHistory();
      expect(result, isA<List<HistoryModel>>());
      expect(result.length, 3);
    });

    test("addHistory should return true", () async {
      final result = await historyDataSource.add("test");
      final history = await historyDataSource.getHistory();

      expect(result, true);
      expect(history.length, 4);
    });
  });
}
