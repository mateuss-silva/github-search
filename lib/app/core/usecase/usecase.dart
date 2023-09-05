import 'package:dartz/dartz.dart';
import '../error/failure.dart';

abstract interface class Usecase<Entity, Params> {
  Future<Either<Failure, Entity>> call(Params params);
}
