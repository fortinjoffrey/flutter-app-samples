part of 'injection_container.dart';

Future<void> _registerSources() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerFactory<AuthSource>(
    () => LocalAuthSource(sharedPreferences: sharedPreferences),
  );
}
