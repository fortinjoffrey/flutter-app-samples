import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/usecases/usecase.dart';
import 'package:flutter_app_samples/features/forecast5/domain/entities/weather_forecast.dart';
import 'package:flutter_app_samples/features/forecast5/domain/repositories/weather_repository.dart';

class GetWeatherForecast5DaysForCity implements UseCase<Future<Either<Failure, List<WeatherForecast>>>, String> {
  GetWeatherForecast5DaysForCity({
    required WeatherRepository weatherRepository,
  }) : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;

  @override
  Future<Either<Failure, List<WeatherForecast>>> call(String cityName) async {
    return _weatherRepository.getForecast5DaysForCity(cityName);
  }
}
