import 'package:dartz/dartz.dart';

import '../../../../core/common/types.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/simplified_user.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/github_repository.dart';
import '../datasources/github_datasource.dart';

class GitHubRepositoryImpl implements GitHubRepository {
  final GitHubDataSource datasource;

  GitHubRepositoryImpl(this.datasource);

  @override
  FutureResult<List<SimplifiedUser>> searchUsers(String query) async {
    try {
      final result = await datasource.searchUser(query);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser(String username) async {
    try {
      final result = await datasource.getUser(username);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
