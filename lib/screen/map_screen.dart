import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_postal_code/api/dadata/dto/suggestions_response.dart';
import 'package:flutter_postal_code/api/dadata/fetch/suggestions_fetch.dart';
import 'package:flutter_postal_code/components/address_component.dart';
import 'package:flutter_postal_code/components/map_component.dart';
import 'package:flutter_postal_code/components/postal_component.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? latLng = const LatLng(55.75, 37.61);
  bool isLoading = true;
  SuggestionResponse? address;
  SuggestionResponse? postalUnit;

  void onPositionChanged(MapPosition position, bool hasGesture) {
    if (position.center != null) {
      setState(() {
        isLoading = true;
        latLng = position.center;
        updateData(position.center!);
      });
    }
  }

  void updateData(LatLng newLatLng) {
    Future.delayed(const Duration(seconds: 1), () async {
      if (newLatLng == latLng) {
        setState(() {
          isLoading = true;
        });
        try {
          SuggestionsResponse suggestionsResponse = await fetchSuggestions(
              lat: latLng!.latitude, lon: latLng!.longitude);

          SuggestionsResponse postalUnitResponse = await fetchPostalInfo(
              postalCode: suggestionsResponse.suggestions[0].postalCode);

          setState(() {
            address = suggestionsResponse.suggestions[0];
            postalUnit = postalUnitResponse.suggestions[0];
            isLoading = false;
          });
        } catch (e) {
          print(e);
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateData(latLng!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapComponent(callback: onPositionChanged),
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: isLoading == false ? [
              PostalComponent(
                isLoading: isLoading,
                postalUnit: postalUnit,
              ),
              AddressComponent(
                isLoading: isLoading,
                address: address,
                latLng: latLng,
              ),
            ] : [
              AddressComponent(
                isLoading: isLoading,
                address: address,
                latLng: latLng,
              ),
            ],
          ),
        )
      ],
    );
  }
}
