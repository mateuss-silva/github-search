import '../../../../core/common/types.dart';
import '../../../../core/usecase/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/history.dart';
import '../repositories/history_repository.dart';

class GetHistoryUsecase implements Usecase<List<History>, NoParams> {
  final HistoryRepository repository;

  GetHistoryUsecase(this.repository);

  @override
  FutureResult<List<History>> call(NoParams params) async {
    return await repository.getHistory();
  }
}
