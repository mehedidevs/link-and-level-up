import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'athlete/createprofile/athlete_profile_request.dart';
import 'athlete/createprofile/athlete_response.dart';
import 'auth/login/login_request.dart';
import 'auth/login/login_response.dart';
import 'auth/register/sign_up_response.dart';
import 'auth/register/user_request.dart';

part 'api_service.g.dart'; // This will link the generated file.

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("auth/login")
  Future<LoginResponse>? login(@Body() LoginRequest loginRequest);

  @POST("auth/register")
  Future<SignUpResponse> signUp(@Body() UserRequest request);

  // http://3.142.144.94:3000/auth/register

  @POST("/auth/register_special_user/{id}")
  Future<AthleteResponse> registerAthlete(
      @Path("id") int id,
      @Query("type") String type,
      @Body() AthleteProfileRequest request);
}
