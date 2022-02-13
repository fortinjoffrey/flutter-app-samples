import 'package:flutter_app_samples/common/data/domain_abstracts/domain_mappable.dart';
import 'package:flutter_app_samples/common/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
// class UserDto with _$UserDto {
class UserDto with _$UserDto implements DomainMappable<User> {
  const factory UserDto({
    required String email,
    required String username,
  }) = _UserDto;
  const UserDto._();

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  @override
  User toEntity() => User(email: email, username: username);
}

extension UserToDto on User {
  UserDto toDto(User user) => UserDto(
        email: user.email,
        username: user.username,
      );
}
