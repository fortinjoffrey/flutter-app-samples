import 'package:dio/dio.dart';
import 'package:flutter_app_samples/common/data/exceptions/exception_handler.dart';
import 'package:flutter_app_samples/common/data/helpers/source_utils.dart';
import 'package:flutter_app_samples/common/typedef.dart';
import 'package:flutter_app_samples/features/forecast5/data/dtos/weather_forecast_dto.dart';
import 'package:flutter_app_samples/features/forecast5/data/sources/contracts/weather_forecast_source.dart';
import 'package:flutter_app_samples/features/forecast5/data/sources/remote/remote_weather_forecast_endpoints.dart'
    as endpoints;

class RemoteWeatherForecastSource implements WeatherForecastSource {
  const RemoteWeatherForecastSource({
    required this.dio,
    required this.apiKey,
  });

  final Dio dio;
  final String apiKey;

  @override
  Future<List<WeatherForecastDto>> getForecast5DaysForCity(String cityname) async {
    try {
      final response = await dio.get<JsonMap>(
        _replaceParams(endpoints.forecast, {
          'cityname': cityname,
          'units': 'metric',
        }),
      );

      final data = getResponseData<Map<String, dynamic>>(response);

      return getDtosFromDynamicList<WeatherForecastDto, JsonMap>(
        data['list'] as List<dynamic>,
        (json) => WeatherForecastDto.fromJson(json),
      );
    } catch (e) {
      ExceptionHandler.handleErrorAndThrow(e);
    }
  }

  String _replaceParams(String endpoint, Map<String, String> params) {
    params['appid'] = apiKey;
    return endpoints.replaceParams(endpoint, params);
  }
}
