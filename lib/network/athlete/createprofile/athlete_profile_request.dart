// lib/features/athlete/data/models/athlete_profile_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'athlete_profile_request.g.dart';

@JsonSerializable()
class AthleteProfileRequest {
  final int age;
  final double weight;
  final double height;
  @JsonKey(name: 'sport_interest')
  final String sportInterest;
  @JsonKey(name: 'sport_level')
  final String sportLevel;
  final String gender;
  final double latitude;
  final double longitude;

  AthleteProfileRequest({
    required this.age,
    required this.weight,
    required this.height,
    required this.sportInterest,
    required this.sportLevel,
    required this.gender,
    required this.latitude,
    required this.longitude,
  });

  factory AthleteProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$AthleteProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AthleteProfileRequestToJson(this);
}

//athlete_profile_request
