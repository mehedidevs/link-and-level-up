import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/LoadingOverlay.dart';
import '../../../core/constants/keys.dart';
import '../../../db/secure_storage_service.dart';
import '../../../network/athlete/createprofile/athlete_profile_request.dart';
import '../../../network/network_client.dart';
import '../../parent/home/components/athlete_search_bar.dart';
import '../../parent/profile/components/app_bar.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends State<AddLocationPage> {
  // Page tracking
  double pageNumber = 7;
  bool _isLoading = false;

  // Map related variables
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  final _networkClient = NetworkClient();

  @override
  void initState() {
    super.initState();
    _createMarker();
  }

  void _createMarker() {
    const markerIcon = BitmapDescriptor.defaultMarker;
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('customMarker'),
          position: _center,
          icon: markerIcon,
        ),
      );
    });
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> createAthlete(BuildContext context) async {
    try {
      setState(() => _isLoading = true);

      var storage = SecureStorageService();

      // Save current location first
      await storage.saveDouble(latitudeDouble, _center.latitude);
      await storage.saveDouble(longitudeDouble, _center.longitude);

      // Fetch all required data from secure storage
      final age = await storage.getInt(ageInt);
      final weight = await storage.getDouble(weightDouble);
      final latitude = await storage.getDouble(latitudeDouble);
      final longitude = await storage.getDouble(longitudeDouble);
      final height = await storage.getDouble(heightDouble);
      final sportInterest = await storage.getString(sportInterestString);
      final sportLevel = await storage.getString(sportLevelString);
      final gender = await storage.getString(genderString);

      // Debug log
      print("Info: age:$age, weight:$weight, sportLevel:$sportLevel, "
          "gender:$gender, sportInterest:$sportInterest, height:$height, "
          "lat:$latitude, lng:$longitude");

      // Validate required fields
      if (age == null ||
          weight == null ||
          height == null ||
          sportInterest == null ||
          sportLevel == null ||
          gender == null ||
          latitude == null ||
          longitude == null) {
        throw Exception('Missing required profile information');
      }
      final usrId = await storage.getInt(userId);
      print("user id get ${storage.getInt(userId)}");
      print("user id get await $usrId");

      // Create the request
      final request = AthleteProfileRequest(
        age: age,
        weight: weight,
        height: height,
        sportInterest: sportInterest,
        sportLevel: sportLevel,
        gender: gender,
        latitude: latitude,
        longitude: longitude,
      );

      final response = await _networkClient.apiService.registerAthlete(
        usrId ?? 0, // id parameter
        'athlete', // type parameter
        request, // request body
      );

      if (!mounted) return;

      // Show success message
      _showSuccess(response.message ?? 'Profile created successfully');

      // Navigate to login screen
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login,
        (Route<dynamic> route) => false,
      );
    } on DioException catch (e) {
      String errorMessage = 'Failed to create athlete profile';

      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection';
      }

      _showError(errorMessage);
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProgressiveAppBar(pageNumber: pageNumber),
        body: LoadingOverlay(
          isLoading: _isLoading,
          message: 'Creating athlete profile...',
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                style: AppDefaults.aubergineMapStyle,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: _markers,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
              const Positioned(
                top: AppDefaults.space,
                left: AppDefaults.space,
                right: AppDefaults.space,
                child: AthleteSearchBar(),
              ),
              Positioned(
                bottom: AppDefaults.space,
                left: AppDefaults.space,
                right: AppDefaults.space,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => createAthlete(context),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Add Location',
                          style: AppDefaults.buttonTextStyle,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
