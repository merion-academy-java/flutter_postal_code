import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapComponent extends StatelessWidget {
  final PositionCallback callback;

  const MapComponent({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return  FlutterMap(
      options: MapOptions(
          initialCenter: const LatLng(55.75, 37.61),
          initialZoom: 15,
          onPositionChanged: callback
      ),

      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
      ],
    );
  }
}
