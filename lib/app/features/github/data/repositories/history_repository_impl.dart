import 'package:dartz/dartz.dart';

import '../../../../core/common/types.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/history.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_datasource.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource datasource;

  HistoryRepositoryImpl(this.datasource);

  @override
  FutureResult<List<History>> getHistory() async {
    try {
      final result = await datasource.getHistory();
      return Right(result);
    } on LocalStoreException {
      return const Left(LocalStoreFailure());
    }
  }

  @override
  FutureResult<bool> add(String query) async {
    try {
      final result = await datasource.add(query);
      return Right(result);
    } on LocalStoreException {
      return const Left(LocalStoreFailure());
    }
  }
}
