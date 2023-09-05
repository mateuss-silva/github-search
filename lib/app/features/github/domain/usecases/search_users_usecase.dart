import '../../../../core/common/types.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/simplified_user.dart';
import '../repositories/github_repository.dart';
import '../repositories/history_repository.dart';

class SearchUsersUsecase implements Usecase<List<SimplifiedUser>, String> {
  final GitHubRepository repository;
  final HistoryRepository history;

  SearchUsersUsecase(this.repository, this.history);

  @override
  FutureResult<List<SimplifiedUser>> call(String query) async {
    history.add(query);
    return repository.searchUsers(query);
  }
}
