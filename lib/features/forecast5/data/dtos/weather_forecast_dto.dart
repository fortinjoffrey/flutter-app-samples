import 'package:flutter_app_samples/common/data/domain_abstracts/domain_mappable.dart';
import 'package:flutter_app_samples/common/typedef.dart';
import 'package:flutter_app_samples/features/forecast5/domain/entities/weather_forecast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_forecast_dto.freezed.dart';

@freezed
class WeatherForecastDto with _$WeatherForecastDto implements DomainMappable<WeatherForecast> {
  const factory WeatherForecastDto({
    required String timestamp,
    required String main,
    required String description,
    required int temperature,
    required String iconId,
  }) = _WeatherForecastDto;
  const WeatherForecastDto._();

  factory WeatherForecastDto.fromJson(JsonMap json) {
    final weatherMap = (json['weather'] as List<dynamic>)[0] as JsonMap;
    return WeatherForecastDto(
      timestamp: json['dt_txt'] as String,
      main: weatherMap['main'] as String,
      description: weatherMap['description'] as String,
      temperature: ((json['main'] as JsonMap)['temp'] as num).toInt(),
      iconId: weatherMap['icon'] as String,
    );
  }

  @override
  WeatherForecast toEntity() {
    return WeatherForecast(
      date: DateTime.parse(timestamp),
      main: main,
      description: description,
      temperature: temperature,
      iconId: iconId,
    );
  }
}
