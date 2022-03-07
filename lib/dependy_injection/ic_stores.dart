part of 'injection_container.dart';

void _registerStores() {
  sl.registerLazySingleton<AuthStore>(
    () => AuthStore(
      logOutUser: sl<LogOutUser>(),
    ),
  );
}
