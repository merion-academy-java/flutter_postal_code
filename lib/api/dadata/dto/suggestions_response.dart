import 'dart:convert';

class SuggestionsResponse {
  List<SuggestionResponse> suggestions = [];

  static SuggestionsResponse fromJson(Map<String, dynamic> data) {
    SuggestionsResponse suggestionsResponse = SuggestionsResponse();

    List<dynamic> suggestionsJson = data['suggestions'];
    suggestionsResponse.suggestions = suggestionsJson
        .map((e) => SuggestionResponse.fromJson(e as Map<String, dynamic>))
        .toList();
    return suggestionsResponse;
  }
}

class SuggestionResponse {
  String value;
  String unrestrictedValue;
  String city;
  String address;
  String postalCode;

  // "postal_code": "127642",
  // "country": "Россия",
  // "country_iso_code": "RU",
  // "federal_district": "Центральный",
  // "region_fias_id": "0c5b2444-70a0-4932-980c-b4dc0d3f02b5",
  // "region_kladr_id": "7700000000000",
  // "region_iso_code": "RU-MOW",
  // "region_with_type": "г Москва",
  // "region_type": "г",
  // "region_type_full": "город",
  // "region": "Москва",
  // "area_fias_id": null,
  // "area_kladr_id": null,
  // "area_with_type": null,
  // "area_type": null,
  // "area_type_full": null,
  // "area": null,
  // "city_fias_id": "0c5b2444-70a0-4932-980c-b4dc0d3f02b5",
  // "city_kladr_id": "7700000000000",
  // "city_with_type": "г Москва",

  SuggestionResponse(
      {required this.value,
      required this.unrestrictedValue,
      required this.city,
      required this.address,
      required this.postalCode});

  static SuggestionResponse fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json['data'];
    return SuggestionResponse(
        value: json['value'] ?? '',
        unrestrictedValue: json['unrestricted_value'] ?? '',
        city: data['city_with_type'] ?? '',
        address: data['street_with_type'] ?? '',
        postalCode: data['postal_code'] ?? '');
  }
}
