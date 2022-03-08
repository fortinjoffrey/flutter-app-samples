import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' show Unit;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_samples/common/presentation/components/center_failure.dart';
import 'package:flutter_app_samples/common/presentation/components/center_progress_indicator.dart';
import 'package:flutter_app_samples/common/presentation/components/rounded_search_bar.dart';
import 'package:flutter_app_samples/common/presentation/components/sized_divider.dart';
import 'package:flutter_app_samples/common/presentation/mixins/reaction_mixin.dart';
import 'package:flutter_app_samples/common/presentation/models/data_state.dart';
import 'package:flutter_app_samples/common/presentation/theme/app_widgets_constants.dart';
import 'package:flutter_app_samples/dependy_injection/injection_container.dart';
import 'package:flutter_app_samples/features/auth/presentation/stores/auth_store.dart';
import 'package:flutter_app_samples/features/auth/presentation/views/components/column_with_spacing.dart';
import 'package:flutter_app_samples/features/auth/presentation/views/login_view.dart';
import 'package:flutter_app_samples/features/forecast5/domain/entities/weather_forecast.dart';
import 'package:flutter_app_samples/features/forecast5/presentation/viewmodels/weather_forecast_viewmodel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class WeatherForecastView extends StatefulWidget {
  const WeatherForecastView({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  State<WeatherForecastView> createState() => _WeatherForecastViewState();
}

class _WeatherForecastViewState extends State<WeatherForecastView> with ReactionMixin {
  final vm = sl<WeatherForecastViewmodel>();
  final authStore = sl<AuthStore>();

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

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Welcome back ${widget.username}')));
    });
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
        title: const Text('Weather 5 days forecast'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: authStore.logOutUser,
          ),
        ],
      ),
      body: Column(
        children: [
          _SearchBar(vm: vm),
          _ResultForSearchText(vm: vm),
          Expanded(
            child: Observer(
              builder: (_) => vm.forecastsFetchingState.when(
                initial: () => sizedBoxShrink,
                pending: () => const CenterProgressIndicator(),
                failure: (notice) => CenterFailure(text: notice.title, onRetry: vm.fetchForecast5Days),
                complete: (_) => RefreshIndicator(
                  onRefresh: vm.fetchForecast5Days,
                  child: CustomScrollView(
                    slivers: [
                      _WeatherForecastSliverList(vm: vm),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherForecastSliverList extends StatelessWidget {
  const _WeatherForecastSliverList({
    Key? key,
    required this.vm,
  }) : super(key: key);

  final WeatherForecastViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _WeatherForecastDayTile(
          weatherForecast: vm.uniquePerDayForecasts[index],
        ),
        childCount: vm.uniquePerDayForecasts.length,
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key? key,
    required this.vm,
  }) : super(key: key);

  final WeatherForecastViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Observer(
        builder: (_) => RoundedSearchBar(
          hintText: 'Paris, New York...',
          onSubmit: (text) => vm.fetchForecast5Days(cityname: text),
          enabled: vm.isForecastsFetchingStatePending,
          onClear: () {},
        ),
      ),
    );
  }
}

class _ResultForSearchText extends StatelessWidget {
  const _ResultForSearchText({
    Key? key,
    required this.vm,
  }) : super(key: key);

  final WeatherForecastViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => vm.forecastsFetchingState.maybeWhen(
        complete: (data) => ColumnWithSpacing(
          spacing: 10,
          children: [
            Text(
              'Weather 5 days forecast for "${vm.cityname}"',
            ),
            const SizedDivider(),
          ],
        ),
        orElse: () => sizedBoxShrink,
      ),
    );
  }
}

class _WeatherForecastDayTile extends StatelessWidget {
  const _WeatherForecastDayTile({
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
