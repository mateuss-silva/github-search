import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/usecase/params.dart';
import '../../domain/entities/history.dart';
import '../../domain/usecases/get_history.dart';

part 'history_state.dart';

class HistoryStore extends ValueNotifier<HistoryState> {
  final GetHistoryUsecase _getHistory;
  HistoryStore(this._getHistory) : super(const HistoryIdleState());

  void onSelectHistory(History history) async {
    //TODO: implement onSelectHistory
  }

  Future<void> getHistory() async {
    value = const HistoryLoadingState();

    final result = await _getHistory(NoParams());

    result.fold(
      (failure) => value = HistoryErrorState(failure.message),
      (users) => value = HistoryLoadedState(users),
    );
  }
}
