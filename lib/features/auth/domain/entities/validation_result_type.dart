import 'package:flutter_app_samples/common/domain/entities/field.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_result_type.freezed.dart';

@freezed
class ValidationResultType with _$ValidationResultType {
  // Reason for this ignore: this private constructor is necessary
  //                         in order to add getter and methods to this class
  // ignore: unused_element
  // const ValidationResultType._(); // Added constructor
  const factory ValidationResultType.valid() = _Valid;
  const factory ValidationResultType.empty(Field field) = _Empty;
  const factory ValidationResultType.invalid(Field field) = _Invalid;
  const factory ValidationResultType.invalidLength(Field field) = _InvalidLength;
}
