import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/core/error/failure.dart';
import 'package:github_search/app/core/usecase/params.dart';
import 'package:github_search/app/features/github/domain/entities/history.dart';
import 'package:github_search/app/features/github/domain/usecases/get_history.dart';
import 'package:github_search/app/features/github/presentation/stores/history_store.dart';
import 'package:mocktail/mocktail.dart';

class MockGetHistoryUseCase extends Mock implements GetHistoryUsecase {}

void main() {
  late MockGetHistoryUseCase getHistory;
  late HistoryStore store;

  final tHistory = History(
    id: 1,
    query: 'query',
    createdAt: DateTime.parse('2020-01-01 00:00:00'),
  );

  final tHistoryList = <History>[tHistory];

  setUp(() {
    getHistory = MockGetHistoryUseCase();
    store = HistoryStore(getHistory);
    registerFallbackValue(NoParams());
  });

  test('should call the usecase to get history', () async {
    // arrange
    when(() => getHistory(any())).thenAnswer((_) async => Right(tHistoryList));

    // act
    await store.getHistory();

    // assert
    expect(store.value, isA<HistoryLoadedState>());
    expect((store.value as HistoryLoadedState).history, tHistoryList);
    verify(() => getHistory(NoParams())).called(1);
    verifyNoMoreInteractions(getHistory);
  });

  test('should return a failure when usecase fails', () async {
    // arrange
    when(() => getHistory(any()))
        .thenAnswer((_) async => const Left(LocalStoreFailure()));

    // act
    await store.getHistory();

    // assert
    expect(store.value, isA<HistoryErrorState>());
    verify(() => getHistory(NoParams())).called(1);
    verifyNoMoreInteractions(getHistory);
  });
}
