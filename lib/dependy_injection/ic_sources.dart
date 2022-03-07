part of 'injection_container.dart';

Future<void> _registerSources() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerFactory<AuthSource>(
    () => LocalAuthSource(sharedPreferences: sharedPreferences),
  );

  // TODO: What if multiple source needs Dio but does not want these options ?
  // TODO: might be interesting to register instance for type with tags ?
  sl.registerFactory<Dio>(
    () => Dio(
      RemoteWeatherForecastConfig(),
    ),
  );

  sl.registerFactory<WeatherForecastSource>(
    () => RemoteWeatherForecastSource(
      dio: sl<Dio>(),
      // TODO: shoud be in an env config json file
      apiKey: '9791a55822bfe1d6d080b29b57334f3d',
    ),
  );
}
