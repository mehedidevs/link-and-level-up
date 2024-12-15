// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'athlete_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AthleteProfileRequest _$AthleteProfileRequestFromJson(
        Map<String, dynamic> json) =>
    AthleteProfileRequest(
      age: (json['age'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      sportInterest: json['sport_interest'] as String,
      sportLevel: json['sport_level'] as String,
      gender: json['gender'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$AthleteProfileRequestToJson(
        AthleteProfileRequest instance) =>
    <String, dynamic>{
      'age': instance.age,
      'weight': instance.weight,
      'height': instance.height,
      'sport_interest': instance.sportInterest,
      'sport_level': instance.sportLevel,
      'gender': instance.gender,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
