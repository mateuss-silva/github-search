part of 'history_store.dart';

abstract base class HistoryState extends Equatable {
  const HistoryState();
  @override
  List<Object?> get props => [];
}

final class HistoryIdleState extends HistoryState {
  const HistoryIdleState();
}

final class HistoryLoadingState extends HistoryState {
  const HistoryLoadingState();
}

final class HistoryLoadedState extends HistoryState {
  final List<History> history;

  const HistoryLoadedState(this.history);
}

final class HistoryErrorState extends HistoryState {
  final String message;

  const HistoryErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
