import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithPolylineScreen extends StatefulWidget {
  const MapWithPolylineScreen({Key? key}) : super(key: key);

  @override
  State<MapWithPolylineScreen> createState() => _MapWithPolylineScreenState();
}

class _MapWithPolylineScreenState extends State<MapWithPolylineScreen> {
  late GoogleMapController _mapController;

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(19.432608, -99.133209), // CDMX
    zoom: 12,
  );

  final Set<Polyline> _polylines = {};
  final List<LatLng> _points = [
    LatLng(19.432608, -99.133209), // CDMX Centro
    LatLng(19.427025, -99.167665), // Chapultepec
    LatLng(19.404384, -99.174403), // Coyoacán
  ];

  @override
  void initState() {
    super.initState();
    _createPolyline();
  }

  void _createPolyline() {
    final polyline = Polyline(
      polylineId: const PolylineId("ruta1"),
      color: Colors.blue,
      width: 5,
      points: _points,
    );

    setState(() {
      _polylines.add(polyline);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Polilínea")),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _mapController = controller,
        polylines: _polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }
}
