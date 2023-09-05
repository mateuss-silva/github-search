import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/core/error/exceptions.dart';
import 'package:github_search/app/core/error/failure.dart';
import 'package:github_search/app/features/github/data/datasources/github_datasource.dart';
import 'package:github_search/app/features/github/data/models/user_model.dart';
import 'package:github_search/app/features/github/data/repositories/github_repository_impl.dart';
import 'package:github_search/app/features/github/domain/entities/simplified_user.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubRemoteDataSource extends Mock implements GitHubDataSource {}

void main() {
  late MockGithubRemoteDataSource mockGithubRemoteDataSource;
  late GitHubRepositoryImpl githubRepositoryImpl;

  final tSearchResult = [
    const SimplifiedUser(id: 1, avatarUrl: "1", username: "1"),
    const SimplifiedUser(id: 2, avatarUrl: "2", username: "2"),
  ];

  final tUser = UserModel(
    id: 1,
    avatarUrl: "1",
    username: "1",
    name: "1",
    bio: "1",
    location: "1",
    email: "1",
    followers: 1,
    following: 1,
    publicRepos: 1,
    publicGists: 1,
    twitterUsername: '1',
    createdAt: DateTime.parse("2021-01-01T00:00:00Z"),
  );

  setUp(() {
    mockGithubRemoteDataSource = MockGithubRemoteDataSource();
    githubRepositoryImpl = GitHubRepositoryImpl(mockGithubRemoteDataSource);
  });

  group("Github repository success", () {
    test("should return a list of users when the call to remote data source",
        () async {
      when(() => mockGithubRemoteDataSource.searchUser(any()))
          .thenAnswer((_) async => tSearchResult);

      final result = await githubRepositoryImpl.searchUsers("test");

      expect(result, Right(tSearchResult));
      verify(() => mockGithubRemoteDataSource.searchUser("test")).called(1);
      verifyNoMoreInteractions(mockGithubRemoteDataSource);
    });

    test("should return a user when the call to remote data source", () async {
      when(() => mockGithubRemoteDataSource.getUser(any()))
          .thenAnswer((_) async => tUser);

      final result = await githubRepositoryImpl.getUser("test");

      expect(result, Right(tUser));
      verify(() => mockGithubRemoteDataSource.getUser("test")).called(1);
      verifyNoMoreInteractions(mockGithubRemoteDataSource);
    });
  });

  group("Github repository failure", () {
    test("should return a failure when the call to remote data source",
        () async {
      when(() => mockGithubRemoteDataSource.searchUser(any()))
          .thenThrow(ServerException());

      final result = await githubRepositoryImpl.searchUsers("test");

      expect(result, const Left(ServerFailure()));
      verify(() => mockGithubRemoteDataSource.searchUser("test")).called(1);
      verifyNoMoreInteractions(mockGithubRemoteDataSource);
    });

    test("should return a failure when the call to remote data source",
        () async {
      when(() => mockGithubRemoteDataSource.getUser(any()))
          .thenThrow(ServerException());

      final result = await githubRepositoryImpl.getUser("test");

      expect(result, const Left(ServerFailure()));
      verify(() => mockGithubRemoteDataSource.getUser("test")).called(1);
      verifyNoMoreInteractions(mockGithubRemoteDataSource);
    });
  });
}
