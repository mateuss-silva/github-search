part of 'github_store.dart';

abstract base class GitHubState extends Equatable {
  const GitHubState(this.user);

  final User? user;

  @override
  List<Object?> get props => [user];
}

final class GitHubIdleState extends GitHubState {
  const GitHubIdleState(super.user);
}

final class GitHubLoadingState extends GitHubState {
  const GitHubLoadingState(super.user);
}

final class GitHubLoadedState extends GitHubState {
  final List<SimplifiedUser> users;

  const GitHubLoadedState(this.users, super.user);

  @override
  List<Object?> get props => [users, user];
}

final class GitHubErrorState extends GitHubState {
  final String message;

  const GitHubErrorState(this.message, super.user);

  @override
  List<Object?> get props => [message, user];
}
