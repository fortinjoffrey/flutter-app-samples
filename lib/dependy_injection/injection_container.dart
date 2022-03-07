import 'package:flutter_app_samples/features/auth/data/repositories/user_repository_impl.dart';
import 'package:flutter_app_samples/features/auth/data/sources/contracts/auth_source.dart';
import 'package:flutter_app_samples/features/auth/data/sources/impls/local_auth_source.dart';
import 'package:flutter_app_samples/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/fetch_current_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/log_in_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/log_out_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/validation/validate_email.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/validation/validate_password.dart';
import 'package:flutter_app_samples/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ic_repositories.dart';
part 'ic_sources.dart';
part 'ic_usecases.dart';
part 'ic_viewmodels.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  _registerSources();
  _registerRepositories();
  _registerUsecases();
  _registerViewmodels();
}
