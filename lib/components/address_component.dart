import 'package:flutter/material.dart';
import 'package:flutter_postal_code/api/dadata/dto/suggestions_response.dart';
import 'package:flutter_postal_code/components/container_component.dart';
import 'package:latlong2/latlong.dart';

class AddressComponent extends StatelessWidget {
  final bool isLoading;
  final SuggestionResponse? address;
  final LatLng? latLng;

  const AddressComponent(
      {super.key,
      required this.isLoading,
      required this.address,
      required this.latLng});

  @override
  Widget build(BuildContext context) {
    return ContainerComponent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children(),
      ),
    );
  }

  List<Widget> children() {
    if (isLoading) {
      return [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: const CircularProgressIndicator())
      ];
    }

    if (address != null && latLng != null) {
      return [
        Text(
          address!.city,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 16,),
        Text(
          address!.address,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
        const SizedBox(height: 8,),
        Text(
          '${latLng!.latitude}, ${latLng!.longitude}',
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ];
    }

    return [
      const Text(
        "Ошибка в получении данных",
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ];
  }
}
