import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/entities/user.dart';
import 'package:flutter_app_samples/common/domain/usecases/usecase.dart';
import 'package:flutter_app_samples/features/auth/domain/repositories/user_repository.dart';

class FetchCurrentUser implements UseCase<Either<Failure, User?>, void> {
  FetchCurrentUser({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, User?>> call([void params]) async {
    return _userRepository.getUser();
  }
}
