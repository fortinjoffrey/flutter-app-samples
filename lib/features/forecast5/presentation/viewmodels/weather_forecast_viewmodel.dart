import 'package:flutter_app_samples/common/presentation/mappers/failure_mapper.dart';
import 'package:flutter_app_samples/common/presentation/models/data_state.dart';
import 'package:flutter_app_samples/features/forecast5/domain/entities/weather_forecast.dart';
import 'package:flutter_app_samples/features/forecast5/domain/usecases/get_weather_forecast_5_days_for_city.dart';
import 'package:mobx/mobx.dart';

part 'weather_forecast_viewmodel.g.dart';

class WeatherForecastViewmodel = _WeatherForecastViewmodel with _$WeatherForecastViewmodel;

abstract class _WeatherForecastViewmodel with Store {
  _WeatherForecastViewmodel({
    required GetWeatherForecast5DaysForCity getWeatherForecast5DaysForCity,
  }) : _getWeatherForecast5DaysForCity = getWeatherForecast5DaysForCity;

  final GetWeatherForecast5DaysForCity _getWeatherForecast5DaysForCity;

  //----------------------------------------------------------------------------
  // OBSERVABLE PROPERTIES AND GETTERS
  //----------------------------------------------------------------------------

  String _cityname = '';

  String get cityname => _cityname;

  @observable
  DataState<List<WeatherForecast>> forecastsFetchingState = const DataState.initial();

  @computed
  bool get isForecastsFetchingStatePending => forecastsFetchingState.maybeWhen(
        pending: () => false,
        orElse: () => true,
      );

  @computed
  List<WeatherForecast> get uniquePerDayForecasts => forecastsFetchingState.maybeWhen(
        complete: (forecasts) {
          // Only keeps 1 temp per day (here at 3:00 PM)
          return forecasts.where((forecast) => forecast.date.hour == 15).toList();
        },
        orElse: () => [],
      );

  //----------------------------------------------------------------------------
  // ACTIONS
  //----------------------------------------------------------------------------
  Future<void> fetchForecast5Days({String? cityname}) async {
    _cityname = cityname ?? _cityname;

    forecastsFetchingState = const DataState.pending();

    final result = await _getWeatherForecast5DaysForCity(_cityname);

    result.fold(
      (failure) => forecastsFetchingState = DataState.failure(failure.toNotice()),
      (forecasts) => forecastsFetchingState = DataState.complete(forecasts),
    );
  }
}
