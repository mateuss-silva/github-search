import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/core/error/failure.dart';
import 'package:github_search/app/features/github/domain/entities/user.dart';
import 'package:github_search/app/features/github/domain/repositories/github_repository.dart';
import 'package:github_search/app/features/github/domain/usecases/get_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubRepository extends Mock implements GitHubRepository {}

void main() {
  late MockGithubRepository mockGithubRepository;
  late GetUserUsecase usecase;

  final tUser = User(
    id: 1,
    avatarUrl: 'avatarUrl',
    username: 'username',
    name: 'name',
    bio: 'bio',
    location: 'location',
    email: 'email',
    followers: 1,
    following: 1,
    publicGists: 1,
    publicRepos: 1,
    twitterUsername: "twitterUsername",
    createdAt: DateTime.parse('2020-01-01 00:00:00'),
  );

  setUp(() {
    mockGithubRepository = MockGithubRepository();
    usecase = GetUserUsecase(mockGithubRepository);
  });

  test('should call the repository to get user', () async {
    // arrange
    when(() => mockGithubRepository.getUser(any()))
        .thenAnswer((_) async => Right(tUser));

    // act
    final result = await usecase('query');

    // assert
    expect(result, Right(tUser));
    verify(() => mockGithubRepository.getUser('query')).called(1);
    verifyNoMoreInteractions(mockGithubRepository);
  });

  test('should return a failure when repository fails', () async {
    // arrange
    when(() => mockGithubRepository.getUser(any()))
        .thenAnswer((_) async => const Left(ServerFailure()));

    // act
    final result = await usecase('query');

    // assert
    expect(result, const Left(ServerFailure()));
    verify(() => mockGithubRepository.getUser('query')).called(1);
    verifyNoMoreInteractions(mockGithubRepository);
  });
}
