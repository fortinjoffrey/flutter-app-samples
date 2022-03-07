import 'package:dartz/dartz.dart';
import 'package:flutter_app_samples/common/domain/entities/failure.dart';
import 'package:flutter_app_samples/common/domain/entities/user.dart';
import 'package:flutter_app_samples/features/auth/data/repositories/user_repository_impl.dart';
import 'package:flutter_app_samples/features/auth/data/sources/contracts/auth_source.dart';
import 'package:flutter_app_samples/features/auth/data/sources/impls/local_auth_source.dart';
import 'package:flutter_app_samples/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/fetch_current_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/log_in_user.dart';
import 'package:flutter_app_samples/features/auth/domain/usecases/log_out_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late LogInUser logInUser;
  late LogOutUser logOutUser;
  late FetchCurrentUser fetchCurrentUser;
  late UserRepository userRepository;
  late AuthSource authSource;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    authSource = LocalAuthSource(sharedPreferences: sharedPreferences);
    userRepository = UserRepositoryImpl(authSource: authSource);
    logInUser = LogInUser(userRepository: userRepository);
    logOutUser = LogOutUser(userRepository: userRepository);
    fetchCurrentUser = FetchCurrentUser(userRepository: userRepository);
  });

  test('should retrieve user info after a successful login', () async {
    // arrange
    const user = User(email: 'johndoe@gmail.com', username: 'John doe');

    // act
    final logInUserResult = await logInUser(LogInUserParams(user.email, 'password'));
    final fetchingCurrentUserResult = await fetchCurrentUser();

    // assert

    // Expect user login successful
    expect(logInUserResult, isA<Right<Failure, Unit>>());
    // Expect current user fetching successful
    expect(fetchingCurrentUserResult, isA<Right<Failure, User?>>());
    // Expect the fetched user to be the same as the one logged in
    expect(
      user,
      fetchingCurrentUserResult.fold(
        (failure) => null,
        (currentUser) => currentUser,
      ),
    );
  });

  test('should not retrieve user info after login and logout', () async {
    // arrange
    const user = User(email: 'johndoe@gmail.com', username: 'John doe');

    // act
    final logInUserResult = await logInUser(LogInUserParams(user.email, 'password'));
    final logOutUserResult = await logOutUser();
    final fetchingCurrentUserResult = await fetchCurrentUser();

    // assert

    // Expect user login successful
    expect(logInUserResult, isA<Right<Failure, Unit>>());
    // Expect user logout successful
    expect(logOutUserResult, isA<Right<Failure, Unit>>());
    // Expect current user fetching successful
    expect(fetchingCurrentUserResult, isA<Right<Failure, User?>>());
    // Expect the fetched user to be null
    expect(
      null,
      fetchingCurrentUserResult.fold(
        (failure) => null,
        (currentUser) => currentUser,
      ),
    );
  });
}
