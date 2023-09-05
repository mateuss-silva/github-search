import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/core/error/exceptions.dart';
import 'package:github_search/app/core/error/failure.dart';
import 'package:github_search/app/features/github/data/datasources/history_datasource.dart';
import 'package:github_search/app/features/github/data/models/history_model.dart';
import 'package:github_search/app/features/github/data/repositories/history_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockHistoryDatasource extends Mock implements HistoryDataSource {}

void main() {
  late MockHistoryDatasource mockHistoryDatasource;
  late HistoryRepositoryImpl historyRepositoryImpl;

  final tHistory = HistoryModel(
      id: 1,
      query: "query",
      createdAt: DateTime.parse("2021-01-01 00:00:00.000"));

  setUp(() {
    mockHistoryDatasource = MockHistoryDatasource();
    historyRepositoryImpl = HistoryRepositoryImpl(mockHistoryDatasource);
  });

  final tHistoryList = [tHistory];

  group("History repository success", () {
    test("should return a list of history when the call to local data source",
        () async {
      when(() => mockHistoryDatasource.getHistory())
          .thenAnswer((_) async => tHistoryList);

      final result = await historyRepositoryImpl.getHistory();

      expect(result, Right(tHistoryList));
      verify(() => mockHistoryDatasource.getHistory()).called(1);
      verifyNoMoreInteractions(mockHistoryDatasource);
    });

    test("should add a value to the history", () async {
      when(() => mockHistoryDatasource.add(any()))
          .thenAnswer((_) async => true);

      final result = await historyRepositoryImpl.add("new");

      expect(result, const Right(true));
      verify(() => mockHistoryDatasource.add("new")).called(1);
      verifyNoMoreInteractions(mockHistoryDatasource);
    });
  });

  group("History repository failure", () {
    test("should return a failure when get history", () async {
      when(() => mockHistoryDatasource.getHistory())
          .thenThrow(LocalStoreException());

      final result = await historyRepositoryImpl.getHistory();

      expect(result, const Left(LocalStoreFailure()));
      verify(() => mockHistoryDatasource.getHistory()).called(1);
      verifyNoMoreInteractions(mockHistoryDatasource);
    });

    test("should return a failure when add new history", () async {
      when(() => mockHistoryDatasource.add(any()))
          .thenThrow(LocalStoreException());

      final result = await historyRepositoryImpl.add("new");

      expect(result, const Left(LocalStoreFailure()));
      verify(() => mockHistoryDatasource.add("new")).called(1);
      verifyNoMoreInteractions(mockHistoryDatasource);
    });
  });
}
