import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/usecase/params.dart';
import '../../domain/entities/history.dart';
import '../../domain/usecases/get_history.dart';

part 'history_state.dart';

class HistoryStore extends ValueNotifier<HistoryState> {
  final GetHistoryUsecase _getHistory;
  HistoryStore(this._getHistory) : super(const HistoryIdleState());

  Future<void> getHistory() async {
    value = const HistoryLoadingState();

    final result = await _getHistory(NoParams());

    result.fold(
      (failure) => value = HistoryErrorState(failure.message),
      (users) {
        users.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        value = HistoryLoadedState(users);
      },
    );
  }
}
