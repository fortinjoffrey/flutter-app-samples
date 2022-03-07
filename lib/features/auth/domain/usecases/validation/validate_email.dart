import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/entities/field.dart';
import 'package:flutter_app_samples/common/domain/usecases/usecase.dart';

class ValidateEmail implements UseCase<Either<Failure, Unit>, String> {
  @override
  Either<Failure, Unit> call(String? email) {
    if (email == null || email.isEmpty) {
      return const Left(Failure.emptyField(Field.email()));
    }

    final regex = RegExp('^.+@.+[.].+');
    return regex.hasMatch(email) ? const Right(unit) : const Left(Failure.invalidField(Field.email()));
  }
}
