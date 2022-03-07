part of 'injection_container.dart';

void _registerViewmodels() {
  sl.registerFactory<LoginViewmodel>(
    () => LoginViewmodel(
      logInUser: sl<LogInUser>(),
      validateEmail: sl<ValidateEmail>(),
      validatePassword: sl<ValidatePassword>(),
      fetchCurrentUser: sl<FetchCurrentUser>(),
    ),
  );

}
