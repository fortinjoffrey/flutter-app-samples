import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/usecases/usecase.dart';
import 'package:flutter_app_samples/features/auth/domain/repositories/user_repository.dart';

/// TODO: declare this class using freezed
/// TODO: think about the usecases params names since they might be shared
class LogInUserParams {
  const LogInUserParams(this.email, this.password);

  final String email;
  final String password;
}

class LogInUser implements UseCase<Future<Either<Failure, Unit>>, LogInUserParams> {
  LogInUser({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, Unit>> call(LogInUserParams params) async {
    return _userRepository.logInUser(params.email, params.password);
  }
}
