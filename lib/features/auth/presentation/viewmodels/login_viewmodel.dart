import 'package:flutter/material.dart';
import 'package:flutter_app_samples/common/domain/entities/user.dart';
import 'package:flutter_app_samples/common/presentation/mappers/failure_mapper.dart';
import 'package:flutter_app_samples/common/presentation/models/data_state.dart';
import 'package:flutter_app_samples/common/presentation/models/notice.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/fetch_current_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/log_in_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/validation/validate_email.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/validation/validate_password.dart';
import 'package:flutter_app_samples/main.dart';
import 'package:mobx/mobx.dart';

part 'login_viewmodel.g.dart';

class LoginViewmodel = _LoginViewmodel with _$LoginViewmodel;

abstract class _LoginViewmodel with Store {
  _LoginViewmodel({
    required ValidateEmail validateEmail,
    required ValidatePassword validatePassword,
    required LogInUser logInUser,
    required FetchCurrentUser fetchCurrentUser,
  })  : _validateEmail = validateEmail,
        _validatePassword = validatePassword,
        _logInUser = logInUser,
        _fetchCurrentUser = fetchCurrentUser;

  final ValidateEmail _validateEmail;
  final ValidatePassword _validatePassword;
  final LogInUser _logInUser;
  final FetchCurrentUser _fetchCurrentUser;

  //----------------------------------------------------------------------------
  // OBSERVABLE PROPERTIES AND GETTERS
  //----------------------------------------------------------------------------
  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @observable
  String? email;

  @observable
  String? password;

  @observable
  DataState<User> loginState = const DataState.initial();

  @computed
  bool get isLoginStatePending => loginState.maybeWhen(
        pending: () => true,
        orElse: () => false,
      );

  @computed
  bool get formReadOnly => loginState.maybeWhen(
        pending: () => true,
        orElse: () => false,
      );

  //----------------------------------------------------------------------------
  // ACTIONS
  //----------------------------------------------------------------------------

  /// This should only be used for DEBUG
  void prefillForm() {
    assert(env == Env.debug);
    const email = 'johndoe@gmail.com';
    const password = 'password';

    emailController.text = email;
    passwordController.text = password;

    this.email = email;
    this.password = password;
  }

  String? validateEmail() {
    final result = _validateEmail(email);

    return result.fold(
      (failure) => failure.toNotice().title,
      (_) => null,
    );
  }

  String? validatePassword() {
    final result = _validatePassword(password);

    return result.fold(
      (failure) => failure.toNotice().title,
      (_) => null,
    );
  }

  Future<void> submitForm() async {
    final isFormValid = formKey.currentState?.validate();
    if (isFormValid == null || isFormValid == false) {
      // Abort if form is invalid
      return;
    }

    final email = this.email;
    final password = this.password;

    if (email == null || password == null) {
      return;
    }

    _unfocusFormNodes();

    loginState = const DataState.pending();

    final response = await _logInUser(LogInUserParams(email, password));

    response.fold(
      (failure) => loginState = DataState.failure(failure.toNotice()),
      (_) async {
        final result = await _fetchCurrentUser();

        result.fold(
          (failure) => loginState = DataState.failure(failure.toNotice()),
          (user) {
            loginState =
                user == null ? const DataState.failure(Notice.unableToRetrieveCurrentUser) : DataState.complete(user);
          },
        );
      },
    );
  }

  void _unfocusFormNodes() {
    emailNode.unfocus();
    passwordNode.unfocus();
  }
}
