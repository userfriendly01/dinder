// Kaleigh Note 6: build this off of this rapid api.. I couldnt find a better api
// just browsing a bit but once we filter for unique values, should be a solid, city specific list
// https://rapidapi.com/makingdatameaningful/api/restaurants-near-me-usa/

class Restaurants {
  final List<Restaurant> restaurants;

  Restaurants({required this.restaurants});

  factory Restaurants.initial() {
    return Restaurants(restaurants: []);
  }

  factory Restaurants.fromJson(Map<String, dynamic> json) {
    // final restaurantList = array.map((item) => Restaurant.fromJson(item)).toList();
    // return Restaurants(restaurants: restaurantList);
    return switch (json) {
      {'restaurants': List<dynamic> restaurants} => Restaurants(
          restaurants:
              restaurants.map((item) => Restaurant.fromJson(item)).toList()),
      _ => throw const FormatException('Failed to load restaurants')
    };
  }

  Restaurants copyWith({List<Restaurant>? restaurants}) {
    return Restaurants(restaurants: restaurants ?? this.restaurants);
  }
}

class Restaurant {
  final int id;
  final String restaurantName;
  final String? address;
  final String? cityName;
  final String? cuisineType;
  final String? hoursInterval;
  final String? website;
  final String? phone;

  Restaurant(
      {required this.id,
      required this.restaurantName,
      this.address,
      this.cityName,
      this.cuisineType,
      this.hoursInterval,
      this.phone,
      this.website});

  factory Restaurant.initial() {
    return Restaurant(
        id: 0,
        restaurantName: "",
        address: "",
        cityName: "",
        cuisineType: "",
        hoursInterval: "",
        phone: "",
        website: "");
  }

  Restaurant copyWith(
      {int? id,
      String? restaurantName,
      String? address,
      String? cityName,
      String? cuisineType,
      String? hoursInterval,
      String? website,
      String? phone}) {
    return Restaurant(
        id: id ?? this.id,
        restaurantName: restaurantName ?? this.restaurantName,
        address: address ?? this.address,
        cityName: cityName ?? this.cityName,
        cuisineType: cuisineType ?? this.cuisineType,
        hoursInterval: hoursInterval ?? this.hoursInterval,
        website: website ?? this.website,
        phone: phone ?? this.phone);
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    print("json");
    print(json);
    return switch (json) {
      {
        'id': int id,
        'restaurantName': String restaurantName,
        'address': String address,
        'cityName': String cityName,
        'cuisineType': String cuisineType,
        'hoursInterval': String hoursInterval,
        'website': String website,
        'phone': String phone
      } =>
        Restaurant(
            id: id,
            restaurantName: restaurantName,
            address: address,
            cityName: cityName,
            cuisineType: cuisineType,
            hoursInterval: hoursInterval,
            website: website,
            phone: phone),
      _ => throw const FormatException('Failed to load Restaurant')
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'address': address,
      'cityName': cityName,
      'cuisineType': cuisineType,
      'hoursInterval': hoursInterval,
      'website': website,
      'phone': phone
    };
  }

  @override
  String toString() {
    return "Restaurant(id: $id, restaurantName: $restaurantName, address: $address, cityName: $cityName, cuisineType: $cuisineType, hoursInterval: $hoursInterval, website: $website, phone: $phone)";
  }
}
