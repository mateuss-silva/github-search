import '../../domain/entities/simplified_user.dart';
import '../models/user_model.dart';

abstract interface class GitHubDataSource {
  Future<List<SimplifiedUser>> searchUser(String query);

  Future<UserModel> getUser(String username);
}