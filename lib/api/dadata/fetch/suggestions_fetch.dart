import 'dart:convert';

import 'package:flutter_postal_code/api/dadata/dto/suggestions_response.dart';
import 'package:http/http.dart' as http;

const token = 'Token 169785968f67b4ce16a4958232a400678337b712';

Future<SuggestionsResponse> fetchSuggestions(
    {required double lat, required double lon}) async {
  //POST http://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address
  // { "lat": 55.878, "lon": 37.653 }
  Uri uri = Uri.parse(
      "http://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address");
  final response = await http.post(uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: jsonEncode(
          <String, String>{'lat': lat.toString(), 'lon': lon.toString()}));
  if (response.statusCode != 200) {
    print(response.statusCode);
    print(response.body);
    throw Exception('Fetch error');
  }
  return SuggestionsResponse.fromJson(json.decode(response.body));
}

Future<SuggestionsResponse> fetchPostalInfo({required String postalCode}) async {
  //POST http://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/postal_unit
  Uri uri = Uri.parse(
      "http://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/postal_unit");
  final response = await http.post(uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: jsonEncode(<String, String>{'query':postalCode}));

  if (response.statusCode != 200) {
    print(response.statusCode);
    print(response.body);
    throw Exception('Fetch error');
  }
  return SuggestionsResponse.fromJson(json.decode(response.body));
}
