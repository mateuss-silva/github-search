import '../../../../core/common/types.dart';
import '../entities/simplified_user.dart';
import '../entities/user.dart';

abstract interface class GitHubRepository {
  FutureResult<List<SimplifiedUser>> searchUsers(String query);

  FutureResult<User> getUser(String username);
}
