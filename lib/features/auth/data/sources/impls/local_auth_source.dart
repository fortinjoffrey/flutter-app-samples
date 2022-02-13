import 'dart:convert';

import 'package:flutter_app_samples/common/data/dtos/user_dto.dart';
import 'package:flutter_app_samples/features/auth/data/sources/contracts/auth_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthSource implements AuthSource {
  const LocalAuthSource({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const _userKey = 'user';

  @override
  Future<UserDto?> getUser() async {
    final userString = _sharedPreferences.getString(_userKey);

    // TODO: might return a specific Exception like NoUserFound
    if (userString == null) return null;

    return UserDto.fromJson(jsonDecode(userString) as Map<String, dynamic>);
  }

  @override
  Future<void> logInUser(UserDto userDto) async {
    await _sharedPreferences.setString(_userKey, jsonEncode(userDto.toJson()));
  }

  @override
  Future<void> logOutUser() async {
    _sharedPreferences.remove(_userKey);
  }
}
