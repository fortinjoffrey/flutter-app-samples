import 'package:flutter_app_samples/common/domain/entities/field.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  // TODO: enrich this union with new cases for domain failures
  const factory Failure.unableToProcess() = UnableToProcess;
  const factory Failure.unexpectedError() = UnexpectedError;

  // TODO: these validation rules must not be considered as failure since it is a "standard" behavior
  // TODO: They shoud be a part of a ValidationResultType enum that is the right part of use case
  // TODO: enum should be composed of"valid" "invalid", "empty"...

  // VALIDATION RULES ----------------------------------------------------------
  const factory Failure.emptyField(Field field) = _EmptyField;
  const factory Failure.invalidField(Field field) = _InvalidField;
  const factory Failure.invalidFieldLength(Field field) = _InvalidFieldLength;
}
