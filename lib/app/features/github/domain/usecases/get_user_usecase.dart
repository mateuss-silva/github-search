import '../../../../core/common/types.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/github_repository.dart';

class GetUserUsecase implements Usecase<User, String> {
  final GitHubRepository repository;

  GetUserUsecase(this.repository);

  @override
  FutureResult<User> call(String username) {
    return repository.getUser(username);
  }
}
