import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';
import '../../athlete/home/components/athlete_search_bar.dart';
import '../../athlete/profile/components/app_bar.dart';


class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends State<AddLocationPage> {
  double pageNumber = 7;
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarker();
  }

  void _createMarker() async {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProgressiveAppBar(pageNumber: pageNumber),
        body: Stack(
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
            ),
            const Positioned(
                top: AppDefaults.space,
                left: AppDefaults.space,
                right: AppDefaults.space,
                child: AthleteSearchBar()),
            Positioned(
                bottom: AppDefaults.space,
                left: AppDefaults.space,
                right: AppDefaults.space,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login,
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Add Location',
                    style: AppDefaults.buttonTextStyle,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
