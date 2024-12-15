// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['loginStatus', 'user', 'accessToken', 'refreshToken'],
  );
  return LoginResponse(
    loginStatus: json['loginStatus'] as bool,
    specializedUserId: (json['specializedUserId'] as num?)?.toInt(),
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'loginStatus': instance.loginStatus,
      'specializedUserId': instance.specializedUserId,
      'user': instance.user,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['user_id', 'type', 'first_name', 'last_name', 'email'],
  );
  return User(
    userId: (json['user_id'] as num).toInt(),
    type: json['type'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    profilePicture: json['profilePicture'] as String?,
    img: json['img'] as String?,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.userId,
      'type': instance.type,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'profilePicture': instance.profilePicture,
      'img': instance.img,
      'email': instance.email,
    };
