import 'package:flutter_app_samples/common/domain/entities/field.dart';
import 'package:flutter_app_samples/common/domain/usecases/usecase.dart';
import 'package:flutter_app_samples/features/auth/domain/entities/validation_result_type.dart';

class ValidatePassword implements UseCase<ValidationResultType, String> {
  @override
  ValidationResultType call(String? password) {
    if (password == null || password.isEmpty) {
      return const ValidationResultType.empty(Field.password());
    }

    if (password.length < 8) {
      return const ValidationResultType.invalidLength(Field.password());
    }

    final regexs = [
      RegExp('[a-z]+'),
      RegExp('[A-Z]+'),
    ];

    final regexMatchesNumber = regexs.where((regex) => regex.hasMatch(password)).toList().length;

    if (regexMatchesNumber >= 1) {
      return const ValidationResultType.valid();
    }

    return const ValidationResultType.invalid(Field.password());
  }
}
