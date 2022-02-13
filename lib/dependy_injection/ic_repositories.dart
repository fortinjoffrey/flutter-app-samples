part of 'injection_container.dart';

void _registerRepositories() {
  sl.registerFactory<UserRepository>(
    () => UserRepositoryImpl(
      authSource: sl<AuthSource>(),
    ),
  );
}
