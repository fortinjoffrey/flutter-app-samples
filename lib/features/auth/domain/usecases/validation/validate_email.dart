import 'package:flutter_app_samples/common/domain/entities/field.dart';
import 'package:flutter_app_samples/common/domain/usecases/usecase.dart';
import 'package:flutter_app_samples/features/auth/domain/entities/validation_result_type.dart';

class ValidateEmail implements UseCase<ValidationResultType, String> {
  @override
  ValidationResultType call(String? email) {
    if (email == null || email.isEmpty) {
      return const ValidationResultType.empty(Field.email());
    }

    final regex = RegExp('^.+@.+[.].+');

    if (regex.hasMatch(email)) {
      return const ValidationResultType.valid();
    }
    return const ValidationResultType.invalid(Field.email());
  }
}
