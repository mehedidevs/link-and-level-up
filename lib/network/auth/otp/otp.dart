import 'package:json_annotation/json_annotation.dart';

part 'otp.g.dart';

@JsonSerializable()
class OTPRequest {
  final String email;

  OTPRequest({required this.email});

  factory OTPRequest.fromJson(Map<String, dynamic> json) =>
      _$OTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OTPRequestToJson(this);
}



@JsonSerializable()
class OTPResponse {
  final String message;

  OTPResponse({required this.message});

  factory OTPResponse.fromJson(Map<String, dynamic> json) =>
      _$OTPResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OTPResponseToJson(this);
}