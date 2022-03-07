import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' show Unit;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_samples/common/presentation/models/data_state.dart';
import 'package:flutter_app_samples/dependy_injection/injection_container.dart';
import 'package:flutter_app_samples/features/auth/presentation/stores/auth_store.dart';
import 'package:flutter_app_samples/features/auth/presentation/views/login_view.dart';
import 'package:flutter_app_samples/features/forecast5/domain/entities/weather_forecast.dart';
import 'package:flutter_app_samples/features/forecast5/presentation/viewmodels/weather_forecast_viewmodel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

mixin ReactionUsage {
  final reactionDisposers = <ReactionDisposer>[];

  /// Adds a reaction
  void addReaction(ReactionDisposer value) {
    reactionDisposers.add(value);
  }

  /// Disposes all added reactions
  /// This method must be called in view's dispose method
  void disposeReactions() {
    reactionDisposers.forEach((disposer) => disposer());
  }
}

class WeatherForecastView extends StatefulWidget {
  const WeatherForecastView({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  State<WeatherForecastView> createState() => _WeatherForecastViewState();
}

class _WeatherForecastViewState extends State<WeatherForecastView> with ReactionUsage {
  final vm = sl<WeatherForecastViewmodel>();
  final authStore = sl<AuthStore>();

  static const defaultCityName = 'Paris';

  @override
  void initState() {
    super.initState();
    addReaction(
      reaction<DataState<Unit>>(
        (_) => authStore.logOutUserState,
        (logOutUserState) {
          logOutUserState.maybeWhen(
            complete: (_) => Navigator.of(context).pushReplacement(
              CupertinoPageRoute<void>(
                builder: (context) => const LoginView(),
              ),
            ),
            orElse: () {},
          );
        },
      ),
    );
    vm.fetchForecast5Days(cityName: defaultCityName);
  }

  @override
  void dispose() {
    disposeReactions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.username}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: authStore.logOutUser,
          ),
        ],
      ),
      body: Observer(
        builder: (_) => vm.forecastsFetchingState.when(
          initial: () => const SizedBox.shrink(),
          pending: () => const Center(child: CircularProgressIndicator()),
          failure: (notice) => Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                Text(notice.title),
                ElevatedButton.icon(
                  onPressed: () => vm.fetchForecast5Days(cityName: defaultCityName),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                )
              ],
            ),
          ),
          complete: (_) => CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => WeatherForecastDayTile(
                    weatherForecast: vm.uniquePerDayForecasts[index],
                  ),
                  childCount: vm.uniquePerDayForecasts.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherForecastDayTile extends StatelessWidget {
  const WeatherForecastDayTile({
    Key? key,
    required this.weatherForecast,
  }) : super(key: key);

  final WeatherForecast weatherForecast;

  @override
  Widget build(BuildContext context) {
    //Tuesday, February 15, 2022
    final date = DateFormat.MMMMEEEEd().format(weatherForecast.date);
    final weatherInfo = '${weatherForecast.temperature}°C, ${weatherForecast.main}: ${weatherForecast.description}';

    return ListTile(
      // TODO: This url must not be there since it is a source dependent information
      // TODO: Do no use this package to cache image but cache image in data layer
      leading: CachedNetworkImage(
        imageUrl: 'http://openweathermap.org/img/wn/${weatherForecast.iconId}@2x.png',
        width: 40,
        height: 40,
      ),
      title: Text(date),
      subtitle: Text(weatherInfo),
    );
  }
}
