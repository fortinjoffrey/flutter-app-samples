import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/data/exceptions/exception_mapper.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/entities/user.dart';
import 'package:flutter_app_samples/features/auth/data/sources/contracts/auth_source.dart';
import 'package:flutter_app_samples/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required AuthSource authSource}) : _authSource = authSource;

  final AuthSource _authSource;

  @override
  Future<Either<Failure, User?>> getUser() async {
    try {
      final userDto = await _authSource.getUser();
      return Right(userDto?.toEntity());
    } catch (e) {
      return Left(ExceptionMapper.toFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> logInUser(String email, String password) async {
    try {
      await _authSource.logInUser(email, password);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionMapper.toFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> logOutUser() async {
    try {
      await _authSource.logOutUser();
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionMapper.toFailure(e));
    }
  }
}
