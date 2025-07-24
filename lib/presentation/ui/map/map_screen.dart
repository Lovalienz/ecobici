import 'package:ecobici/domain/models/network_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class MapWithPolylineScreen extends StatefulWidget {
  final Station selectedStation;

  const MapWithPolylineScreen({super.key, required this.selectedStation});

  @override
  State<MapWithPolylineScreen> createState() => _MapWithPolylineScreenState();
}

class _MapWithPolylineScreenState extends State<MapWithPolylineScreen> {
  late GoogleMapController _mapController;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};
  LatLng? _userLocation;
  late double _selectedLat;
  late double _selectedLon;
  @override
  void initState() {
    _selectedLat = double.parse(widget.selectedStation.latitude);
    _selectedLon = double.parse(widget.selectedStation.longitude);
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('selected_station'),
        position: LatLng(_selectedLat, _selectedLon),
      ),
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);

      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: _userLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blue,
          width: 5,
          points: [_userLocation!, LatLng(_selectedLat, _selectedLon)],
        ),
      );

      _mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              (_userLocation!.latitude <= _selectedLat)
                  ? _userLocation!.latitude
                  : _selectedLon,
              (_userLocation!.longitude <= _selectedLat)
                  ? _userLocation!.longitude
                  : _selectedLon,
            ),
            northeast: LatLng(
              (_userLocation!.latitude > _selectedLat)
                  ? _userLocation!.latitude
                  : _selectedLat,
              (_userLocation!.longitude > _selectedLon)
                  ? _userLocation!.longitude
                  : _selectedLon,
            ),
          ),
          100,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.selectedStation.name)),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_selectedLat, _selectedLon),
              zoom: 15,
            ),
            onMapCreated: (controller) => _mapController = controller,
            polylines: _polylines,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
          ),

          Positioned(
            bottom: 30,
            right: 20,
            child: CupertinoButton.filled(
              onPressed: () async {
                try {
                  await _determinePosition();
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              color: Colors.blue,
              child: const Text('Cómo llegar'),
            ),
          ),
        ],
      ),
    );
  }
}
