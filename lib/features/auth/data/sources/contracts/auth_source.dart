import 'package:flutter_app_samples/common/data/dtos/user_dto.dart';

abstract class AuthSource {
  Future<UserDto?> getUser();
  Future<void> logInUser(String email, String password);
  Future<void> logOutUser();
}
