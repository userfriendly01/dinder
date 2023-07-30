//Kaleigh Note 7: These apis are designed kinda dumb.. When we start a new meat I think we will have to
//prompts for the state, which we could hard code as the abreiviations for values but name for the label
//At the same time we can Call the API to get all city names and when they select the state we can filter
//down the city list for the dropdown -
//https://rapidapi.com/makingdatameaningful/api/restaurants-near-me-usa/

class LocationOptions {
  final List<Map<String, String>> states = [
    {"label": "New Hampshire", "value": "NH"},
    {"label": "Massachusetts", "value": "MA"}
  ];
  final List<String> cities;

  LocationOptions({required this.cities});

  factory LocationOptions.initial() {
    return LocationOptions(cities: []);
  }

  LocationOptions copyWith({List<String>? cities}) {
    return LocationOptions(cities: cities ?? this.cities);
  }

  @override
  String toString() {
    return "LocationOptions(cities: $cities)";
  }
}
