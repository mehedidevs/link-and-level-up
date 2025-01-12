import 'package:json_annotation/json_annotation.dart';

part 'verify_otp.g.dart';

@JsonSerializable()
class VerifyOtpRequest {
  final String email;
  @JsonKey(name: 'user_otp')
  final int userOtp;

  VerifyOtpRequest({
    required this.email,
    required this.userOtp,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}

@JsonSerializable()
class VerifyOtpResponse {
  final String message;

  VerifyOtpResponse({required this.message});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);
}
