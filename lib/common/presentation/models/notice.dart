import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice.freezed.dart';

@freezed
class Notice with _$Notice {
  const factory Notice({
    required String title,
  }) = _Notice;

  static const unableToRetrieveCurrentUser = Notice(title: 'Unable to retrieve your info');
}
