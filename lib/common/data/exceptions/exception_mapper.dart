import 'package:flutter_app_samples/common/data/exceptions/source_exception.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';

/// A class that maps [Exception] to a [Failure]
abstract class ExceptionMapper {
  static Failure toFailure(dynamic e) {
    if (e is SourceException) {
      return e.maybeMap(
        orElse: () => const Failure.unableToProcess(),
      );
    }
    return const Failure.unexpectedError();
  }
}
