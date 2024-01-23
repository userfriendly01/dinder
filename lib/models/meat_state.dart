import 'package:dinder/models/app_user_state.dart';
import 'package:dinder/models/restaurant_state.dart';

class MeatParticipants {
  final List<MeatParticipant> participants;

  MeatParticipants({required this.participants});

  factory MeatParticipants.initial() {
    return MeatParticipants(participants: []);
  }

  factory MeatParticipants.fromJson(Map<String, dynamic> json) {
    // final restaurantList = array.map((item) => Restaurant.fromJson(item)).toList();
    // return Restaurants(restaurants: restaurantList);
    return switch (json) {
      {'participants': List<dynamic> participants} => MeatParticipants(
          participants: participants
              .map((item) => MeatParticipant.fromJson(item))
              .toList()),
      _ => throw const FormatException('Failed to load participants')
    };
  }

  MeatParticipants copyWith({List<MeatParticipant>? participants}) {
    return MeatParticipants(participants: participants ?? this.participants);
  }
}

class MeatParticipant {
  final Restaurants selectedRestaurants;
  final String participantId;

  MeatParticipant(
      {required this.selectedRestaurants, required this.participantId});

  factory MeatParticipant.initial() {
    return MeatParticipant(
        selectedRestaurants: Restaurants.initial(), participantId: "");
  }

  factory MeatParticipant.fromJson(Map<String, dynamic> json) {
    return MeatParticipant(
      participantId: json["participantId"],
      selectedRestaurants: Restaurants.fromJson(
          {"restaurants": json['selectedRestaurants'] as List<dynamic>}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'participantId': participantId,
      'selectedRestaurants':
          selectedRestaurants.restaurants.map((r) => r.toJson())
    };
  }

  MeatParticipant copyWith(
      {Restaurants? selectedRestaurants, String? participantId}) {
    return MeatParticipant(
        selectedRestaurants: selectedRestaurants ?? this.selectedRestaurants,
        participantId: participantId ?? this.participantId);
  }
}

class Meat {
  final String id;
  final String date;
  final List<String> cities;
  final String state;
  final String zipcode;
  final Restaurants availableRestaurants;
  final Restaurants matchedRestaurants;
  final MeatParticipants participants;
  //Kaleigh & Faith Note: we may want to filter the list when we first get it from the API on
  //restarant name so they dont have to swipe left for 16 nadeaus subs

  //I dont think we need to save the "left swiped" restaurants within the local state because we would update
  //the database and have a listener for when a match was identified that would push a notification to both users

  //Kaleigh Note 4: .... LOL
  Meat(
      {required this.id,
      required this.date,
      required this.cities,
      required this.state,
      required this.zipcode,
      required this.availableRestaurants,
      required this.matchedRestaurants,
      required this.participants});

  factory Meat.initial() {
    return Meat(
        id: "",
        date: "",
        cities: [],
        state: "",
        zipcode: "",
        availableRestaurants: Restaurants.initial(),
        matchedRestaurants: Restaurants.initial(),
        participants: MeatParticipants.initial());
  }

  Meat copyWith(
      {String? id,
      String? date,
      List<String>? cities,
      String? state,
      String? zipcode,
      Restaurants? availableRestaurants,
      Restaurants? matchedRestaurants,
      MeatParticipants? participants}) {
    return Meat(
        id: id ?? this.id,
        date: date ?? this.date,
        cities: cities ?? this.cities,
        state: state ?? this.state,
        zipcode: zipcode ?? this.zipcode,
        availableRestaurants: availableRestaurants ?? this.availableRestaurants,
        matchedRestaurants: matchedRestaurants ?? this.matchedRestaurants,
        participants: participants ?? this.participants);
  }

  factory Meat.fromJson(Map<String, dynamic> json) {
    return Meat(
        id: json["id"],
        date: json["date"],
        cities: json["cities"],
        state: json["state"],
        zipcode: json["zipcode"],
        availableRestaurants: Restaurants.fromJson(
            {"restaurants": json['availableRestaurants'] as List<dynamic>}),
        matchedRestaurants: Restaurants.fromJson(
            {"restaurants": json['matchedRestaurants'] as List<dynamic>}),
        participants: MeatParticipants.fromJson(
            {"participants": json['participants'] as List<dynamic>}));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'zipcode': zipcode,
      'availableRestaurants':
          availableRestaurants.restaurants.map((r) => r.toJson()),
      'matchedRestaurants':
          matchedRestaurants.restaurants.map((r) => r.toJson()),
      'participants': participants.participants.map((p) => p.toJson()),
    };
  }

  @override
  String toString() {
    return "Meat(id: $id), date: $date, cities: $cities, state: $state, zipcode: $zipcode, availableRestaurants: $availableRestaurants, matchedRestaurants: $matchedRestaurants, participants: $participants";
  }
}
