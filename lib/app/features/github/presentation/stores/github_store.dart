import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/simplified_user.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/search_users_usecase.dart';

part 'github_state.dart';

class GitHubStore extends ValueNotifier<GitHubState> {
  final SearchUsersUsecase _searchUsers;
  final GetUserUsecase _getUser;
  GitHubStore(this._searchUsers, this._getUser)
      : super(const GitHubIdleState(null));

  void onSelectUser(SimplifiedUser user) async {
    value = GitHubLoadingState(value.user);

    final result = await _getUser(user.username);

    result.fold(
      (failure) => value = GitHubErrorState(failure.message, value.user),
      (user) => value = GitHubIdleState(user),
    );
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return;

    value = GitHubLoadingState(value.user);

    final result = await _searchUsers(query);

    result.fold(
      (failure) => value = (GitHubErrorState(failure.message, value.user)),
      (users) => value = (GitHubLoadedState(users, value.user)),
    );
  }
}
