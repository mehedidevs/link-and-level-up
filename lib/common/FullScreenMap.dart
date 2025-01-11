// full_screen_map.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullScreenMap extends StatelessWidget {
  final LatLng initialLocation;
  final BitmapDescriptor customMarker;
  final Function(LatLng) onLocationSelected;

  const FullScreenMap({
    Key? key,
    required this.initialLocation,
    required this.customMarker,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('selected_location'),
            position: initialLocation,
            icon: customMarker,
            draggable: true,
            onDragEnd: onLocationSelected,
          ),
        },
        onTap: onLocationSelected,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapToolbarEnabled: true,
      ),
    );
  }
}
