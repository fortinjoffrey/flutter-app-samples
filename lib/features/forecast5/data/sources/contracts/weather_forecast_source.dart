import 'package:flutter_app_samples/features/forecast5/data/dtos/weather_forecast_dto.dart';

abstract class WeatherForecastSource {
  Future<List<WeatherForecastDto>> getForecast5DaysForCity(String cityName);
}
