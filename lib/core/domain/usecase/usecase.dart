import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class Usecase<Type, Param> {
  Future<Either<Failure, Type>>? call(Param parameter);
}
