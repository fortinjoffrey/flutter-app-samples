import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/entities/field.dart';
import 'package:flutter_app_samples/common/domain/usecases/usecase.dart';

class ValidatePassword implements UseCase<Either<Failure, Unit>, String> {
  @override
  Either<Failure, Unit> call(String? password) {
    if (password == null || password.isEmpty) {
      return const Left(Failure.emptyField(Field.password()));
    }

    if (password.length < 8) {
      return const Left(Failure.invalidFieldLength(Field.password()));
    }

    final regexs = [
      RegExp('[a-z]+'),
      RegExp('[A-Z]+'),
    ];

    final regexMatchesNumber = regexs.where((regex) => regex.hasMatch(password)).toList().length;

    return regexMatchesNumber >= 1 ? const Right(unit) : const Left(Failure.invalidField(Field.password()));
  }
}
