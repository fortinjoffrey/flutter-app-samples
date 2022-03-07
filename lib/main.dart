import 'package:flutter/material.dart';
import 'package:flutter_app_samples/common/domain/entities/user.dart';
import 'package:flutter_app_samples/common/presentation/theme/theme.dart';
import 'package:flutter_app_samples/dependy_injection/injection_container.dart' as ic;
import 'package:flutter_app_samples/features/auth/domain/usecases/fetch_current_user.dart';
import 'package:flutter_app_samples/features/auth/presentation/views/login_view.dart';
import 'package:flutter_app_samples/features/forecast5/presentation/views/weather_forecast_view.dart';

enum Env { debug, prod }

const env = Env.debug;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.registerDependencies();

  final currentUserResult = await ic.sl<FetchCurrentUser>()();
  final currentUser = currentUserResult.fold((_) => null, (user) => user);

  runApp(MyApp(currentUser: currentUser));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    this.currentUser,
  }) : super(key: key);

  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: currentUser != null ? WeatherForecastView(username: currentUser!.username) : const LoginView(),
    );
  }
}
