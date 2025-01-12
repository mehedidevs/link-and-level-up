import 'package:json_annotation/json_annotation.dart';

part 'forgotpassword.g.dart';

class ResetPasswordRequest {
  final String email;
  @JsonKey(name: 'user_otp')
  final int userOtp;
  final String password;

  ResetPasswordRequest({
    required this.email,
    required this.userOtp,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'user_otp': userOtp,
    'password': password,
  };
}

@JsonSerializable()
class ResetPasswordResponse {
  final String message;

  ResetPasswordResponse({required this.message});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}
