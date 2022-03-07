import 'package:dio/dio.dart';

class RemoteWeatherForecastConfig extends BaseOptions {
  RemoteWeatherForecastConfig() : super(baseUrl: url);

  // TODO: should be configure from Env values (through json files)
  static const url = 'https://api.openweathermap.org/data/2.5';
}
