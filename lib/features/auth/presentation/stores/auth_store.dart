import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/presentation/mappers/failure_mapper.dart';
import 'package:flutter_app_samples/common/presentation/models/data_state.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/log_out_user.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  _AuthStore({
    required LogOutUser logOutUser,
  }) : _logOutUser = logOutUser;

  final LogOutUser _logOutUser;

  //----------------------------------------------------------------------------
  // OBSERVABLE PROPERTIES AND GETTERS
  //----------------------------------------------------------------------------
  @observable
  DataState<Unit> _logOutUserState = const DataState.initial();

  @computed
  DataState<Unit> get logOutUserState => _logOutUserState;

  //----------------------------------------------------------------------------
  // ACTIONS
  //----------------------------------------------------------------------------
  Future<void> logOutUser() async {
    _logOutUserState = const DataState.pending();

    final result = await _logOutUser();

    result.fold(
      (failure) => _logOutUserState = DataState.failure(failure.toNotice()),
      (unit) => _logOutUserState = DataState.complete(unit),
    );
  }
}
