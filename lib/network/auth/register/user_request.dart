import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;
  final String password;

  UserRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}
