import '../../../../core/common/types.dart';
import '../entities/history.dart';

abstract interface class HistoryRepository {
  FutureResult<List<History>> getHistory();
  FutureResult<bool> add(String query);
}
