import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/presentation/models/notice.dart';

extension FailureMapper on Failure {
  /// Maps a domain [Failure] to a presentation [Notice]

  Notice toNotice() {
    return maybeWhen(
      // -----------------------------------------------------------------------
      orElse: () => const Notice(title: 'An error occured'),
    );
  }
}
