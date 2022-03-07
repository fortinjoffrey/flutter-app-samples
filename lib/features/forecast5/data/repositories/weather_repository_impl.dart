import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/data/exceptions/exception_mapper.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/features/forecast5/data/sources/contracts/weather_forecast_source.dart';
import 'package:flutter_app_samples/features/forecast5/domain/entities/weather_forecast.dart';
import 'package:flutter_app_samples/features/forecast5/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required WeatherForecastSource weatherForecastSource,
  }) : _weatherForecastSource = weatherForecastSource;

  final WeatherForecastSource _weatherForecastSource;

  @override
  Future<Either<Failure, List<WeatherForecast>>> getForecast5DaysForCity(String cityName) async {
    try {
      final forecasts = await _weatherForecastSource.getForecast5DaysForCity(cityName);

      return Right(forecasts.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ExceptionMapper.toFailure(e));
    }
  }
}
