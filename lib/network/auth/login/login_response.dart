import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(required: true)
  final bool loginStatus;

  @JsonKey(defaultValue: null)
  final int? specializedUserId;

  @JsonKey(required: true)
  final User user;

  @JsonKey(required: true)
  final String accessToken;

  @JsonKey(required: true)
  final String refreshToken;

  const LoginResponse({
    required this.loginStatus,
    this.specializedUserId,
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'user_id', required: true)
  final int userId;

  @JsonKey(required: true)
  final String type;

  @JsonKey(name: 'first_name', required: true)
  final String firstName;

  @JsonKey(name: 'last_name', required: true)
  final String lastName;

  @JsonKey(defaultValue: null)
  final String? profilePicture;

  @JsonKey(defaultValue: null)
  final String? img;

  @JsonKey(required: true)
  final String email;

  const User({
    required this.userId,
    required this.type,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    this.img,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}