part of 'injection_container.dart';

void _registerUsecases() {
  sl.registerFactory<FetchCurrentUser>(
    () => FetchCurrentUser(userRepository: sl<UserRepository>()),
  );

  sl.registerFactory<LogInUser>(
    () => LogInUser(userRepository: sl<UserRepository>()),
  );

  sl.registerFactory<LogOutUser>(
    () => LogOutUser(userRepository: sl<UserRepository>()),
  );
}
