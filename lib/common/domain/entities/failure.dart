import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  // TODO: enrich this union with new cases for domain failures
  const factory Failure.unableToProcess() = UnableToProcess;
  const factory Failure.unexpectedError() = UnexpectedError;
}
