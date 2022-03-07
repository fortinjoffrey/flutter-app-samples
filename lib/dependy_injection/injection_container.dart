import 'package:dio/dio.dart';
import 'package:flutter_app_samples/features/auth/data/repositories/user_repository_impl.dart';
import 'package:flutter_app_samples/features/auth/data/sources/contracts/auth_source.dart';
import 'package:flutter_app_samples/features/auth/data/sources/impls/local_auth_source.dart';
import 'package:flutter_app_samples/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/fetch_current_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/log_in_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/log_out_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/validation/validate_email.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/validation/validate_password.dart';
import 'package:flutter_app_samples/features/auth/presentation/stores/auth_store.dart';
import 'package:flutter_app_samples/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:flutter_app_samples/features/forecast5/data/repositories/weather_repository_impl.dart';
import 'package:flutter_app_samples/features/forecast5/data/sources/contracts/weather_forecast_source.dart';
import 'package:flutter_app_samples/features/forecast5/data/sources/remote/remote_weather_forecast_config.dart';
import 'package:flutter_app_samples/features/forecast5/data/sources/remote/remote_weather_forecast_source.dart';
import 'package:flutter_app_samples/features/forecast5/domain/repositories/weather_repository.dart';
import 'package:flutter_app_samples/features/forecast5/domain/usecases/get_weather_forecast_5_days_for_city.dart';
import 'package:flutter_app_samples/features/forecast5/presentation/viewmodels/weather_forecast_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ic_repositories.dart';
part 'ic_sources.dart';
part 'ic_stores.dart';
part 'ic_usecases.dart';
part 'ic_viewmodels.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  await _registerSources();
  _registerRepositories();
  _registerUsecases();
  _registerStores();
  _registerViewmodels();
}
