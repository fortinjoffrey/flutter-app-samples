import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/presentation/models/notice.dart';

extension FailureMapper on Failure {
  /// Maps a domain [Failure] to a presentation [Notice]

  Notice toNotice() {
    return maybeWhen(
      // -----------------------------------------------------------------------
      // VALIDATION FAILURES
      // -----------------------------------------------------------------------
      emptyField: (field) => field.when(
        email: () => const Notice(title: 'Email must not be empty'),
        password: () => const Notice(title: 'Password must not be empty'),
      ),
      invalidField: (field) => field.when(
        email: () => const Notice(title: 'Email must be valid'),
        password: () =>
            const Notice(title: 'Password must contain 8 or more characters, at least a lowercase or an uppercase'),
      ),
      invalidFieldLength: (field) => field.maybeWhen(
        password: () => const Notice(title: 'Password must contain 8 or more characters'),
        orElse: () => const Notice(title: 'Invalid length'),
      ),
      // -----------------------------------------------------------------------
      orElse: () => const Notice(title: 'An error occured'),
    );
  }
}
