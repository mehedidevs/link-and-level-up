import 'package:json_annotation/json_annotation.dart';

part 'athlete_response.g.dart';

@JsonSerializable()
class AthleteResponse {
  final String? message;

  const AthleteResponse({
    this.message,
  });

  factory AthleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AthleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AthleteResponseToJson(this);
}