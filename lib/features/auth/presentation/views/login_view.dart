import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_samples/common/domain/entities/user.dart';
import 'package:flutter_app_samples/common/presentation/models/data_state.dart';
import 'package:flutter_app_samples/common/presentation/theme/app_colors.dart';
import 'package:flutter_app_samples/dependy_injection/injection_container.dart';
import 'package:flutter_app_samples/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:flutter_app_samples/features/auth/presentation/views/components/auth_text_form_field.dart';
import 'package:flutter_app_samples/features/auth/presentation/views/components/column_with_spacing.dart';
import 'package:flutter_app_samples/features/forecast5/presentation/views/weather_forecast_view.dart';
import 'package:flutter_app_samples/main.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final vm = sl<LoginViewmodel>();

  final reactionDisposers = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();

    reactionDisposers.add(
      reaction<DataState<User>>(
        (_) => vm.loginState,
        (loginState) {
          loginState.maybeWhen(
            complete: (user) => Navigator.of(context).pushReplacement(
              CupertinoPageRoute<void>(
                builder: (context) => WeatherForecastView(
                  username: user.username,
                ),
              ),
            ),
            orElse: () {},
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    reactionDisposers.forEach((disposer) => disposer());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login view'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: vm.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ColumnWithSpacing(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (env == Env.debug)
                      GestureDetector(
                        onTap: vm.prefillForm,
                        child: const Center(child: Text('Tap to fill form fields')),
                      ),
                    const _FormFieldTitle(text: 'Email'),
                    _EmailFormField(vm: vm),
                    const _FormFieldTitle(text: 'Password'),
                    _PasswordFormField(vm: vm),
                    _LoginButton(vm: vm),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
    required this.vm,
  }) : super(key: key);

  final LoginViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: vm.isLoginStatePending ? null : vm.submitForm,
        child: Observer(
          builder: (_) => vm.loginState.maybeWhen(
            pending: () => const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: AppColors.grey1,
              ),
            ),
            orElse: () => const Text('Log in'),
          ),
        ),
      ),
    );
  }
}

class _EmailFormField extends StatelessWidget {
  const _EmailFormField({
    Key? key,
    required this.vm,
  }) : super(key: key);

  final LoginViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return AuthTextFormField(
      controller: vm.emailController,
      focusNode: vm.emailNode,
      readOnly: vm.formReadOnly,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => vm.email = value,
      validator: (_) => vm.validateEmail(),
    );
  }
}

class _PasswordFormField extends StatelessWidget {
  const _PasswordFormField({
    Key? key,
    required this.vm,
  }) : super(key: key);

  final LoginViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return AuthTextFormField(
      controller: vm.passwordController,
      focusNode: vm.passwordNode,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (value) => vm.password = value,
      obscureText: true,
      validator: (_) => vm.validatePassword(),
    );
  }
}

class _FormFieldTitle extends StatelessWidget {
  const _FormFieldTitle({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
