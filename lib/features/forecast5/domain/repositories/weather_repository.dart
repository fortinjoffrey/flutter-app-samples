import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/repositories/repository.dart';
import 'package:flutter_app_samples/features/forecast5/domain/entities/weather_forecast.dart';

abstract class WeatherRepository implements Repository {
  Future<Either<Failure, List<WeatherForecast>>> getForecast5DaysForCity(String cityName);
}
