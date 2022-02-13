import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState<T> {
  const factory DataState.initial() = _Initial;
  const factory DataState.pending() = _Pending;
  const factory DataState.failure(Failure failure) = _Failure;
  const factory DataState.complete(T data) = _Complete;
}
