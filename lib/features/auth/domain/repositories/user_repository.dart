import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/entities/user.dart';
import 'package:flutter_app_samples/common/domain/repositories/repository.dart';

abstract class UserRepository implements Repository {
  Future<Either<Failure, User?>> getUser();
  Future<Either<Failure, Unit>> logInUser(String email, String password);
  Future<Either<Failure, Unit>> logOutUser();
}
