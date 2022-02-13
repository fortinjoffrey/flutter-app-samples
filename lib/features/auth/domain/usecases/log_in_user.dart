import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/entities/user.dart';
import 'package:flutter_app_samples/common/domain/usecases/usecase.dart';
import 'package:flutter_app_samples/features/auth/domain/repositories/user_repository.dart';

class LogInUser implements UseCase<Either<Failure, Unit>, User> {
  LogInUser({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, Unit>> call(User user) async {
    return _userRepository.logInUser(user);
  }
}
