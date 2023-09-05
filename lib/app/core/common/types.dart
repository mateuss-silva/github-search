import 'package:dartz/dartz.dart';

import '../error/failure.dart';

typedef Json = Map<String, dynamic>;

typedef FutureResult<T> = Future<Either<Failure, T>>;
