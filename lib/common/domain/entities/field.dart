import 'package:freezed_annotation/freezed_annotation.dart';

part 'field.freezed.dart';

@freezed
class Field with _$Field {
  const factory Field.email() = _Email;
  const factory Field.password() = _Password;
}
