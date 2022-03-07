import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/usecases/usecase.dart';
import 'package:flutter_app_samples/features/auth/domain/repositories/user_repository.dart';

class LogOutUser implements UseCase<Future<Either<Failure, Unit>>, void> {
  LogOutUser({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, Unit>> call([void params]) async {
    return _userRepository.logOutUser();
  }
}
