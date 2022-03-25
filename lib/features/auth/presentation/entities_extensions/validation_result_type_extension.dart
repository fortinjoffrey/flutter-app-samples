import 'package:flutter_app_samples/common/presentation/models/notice.dart';
import 'package:flutter_app_samples/features/auth/domain/entities/validation_result_type.dart';

extension ValidationResultTypeX on ValidationResultType {
  Notice toNotice() {
    return when(
      valid: () => const Notice(
        title: 'Field is valid',
      ),
      empty: (field) => field.when(
        email: () => const Notice(title: 'Email must not be empty'),
        password: () => const Notice(title: 'Password must not be empty'),
      ),
      invalid: (field) => field.when(
        email: () => const Notice(title: 'Email must be valid'),
        password: () =>
            const Notice(title: 'Password must contain 8 or more characters, at least a lowercase or an uppercase'),
      ),
      invalidLength: (field) => field.maybeWhen(
        password: () => const Notice(title: 'Password must contain 8 or more characters'),
        orElse: () => const Notice(title: 'Invalid length'),
      ),
    );
  }
}
