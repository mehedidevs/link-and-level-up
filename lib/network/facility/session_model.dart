import 'package:json_annotation/json_annotation.dart';

part 'session_model.g.dart';

@JsonSerializable()
class SessionModel {
  @JsonKey(name: 'facility_sessions_id')
  final int facilitySessionsId;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;

  SessionModel({
    required this.facilitySessionsId,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.startTime,
    required this.endTime,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}

// models/facilitator_home_response.dart
@JsonSerializable()
class FacilitatorHomeResponse {
  final int page;
  final int limit;
  final FacilitatorHomeData data;

  FacilitatorHomeResponse({
    required this.page,
    required this.limit,
    required this.data,
  });

  factory FacilitatorHomeResponse.fromJson(Map<String, dynamic> json) =>
      _$FacilitatorHomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FacilitatorHomeResponseToJson(this);
}

@JsonSerializable()
class FacilitatorHomeData {
  @JsonKey(name: 'ongoingSessions')
  final List<SessionModel> ongoingSessions;
  @JsonKey(name: 'upcomingSessions')
  final List<SessionModel> upcomingSessions;
  @JsonKey(name: 'completedSessions')
  final List<SessionModel> completedSessions;

  FacilitatorHomeData({
    required this.ongoingSessions,
    required this.upcomingSessions,
    required this.completedSessions,
  });

  factory FacilitatorHomeData.fromJson(Map<String, dynamic> json) =>
      _$FacilitatorHomeDataFromJson(json);

  Map<String, dynamic> toJson() => _$FacilitatorHomeDataToJson(this);
}
