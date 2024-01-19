import 'package:dinder/models/app_user_state.dart';
import 'package:dinder/models/restaurant_state.dart';

class MeatParticipant {
  final Restaurants selectedRestaurants;
  final String participantId;

  MeatParticipant(
      {required this.selectedRestaurants, required this.participantId});

  factory MeatParticipant.initial() {
    return MeatParticipant(
        selectedRestaurants: Restaurants.initial(), participantId: "");
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
  final List<String> cities;
  final String state;
  final String zipcode;
  final Restaurants availableRestaurants;
  final Restaurants matchedRestaurants;
  final List<MeatParticipant> participants;
  //Kaleigh & Faith Note: we may want to filter the list when we first get it from the API on
  //restarant name so they dont have to swipe left for 16 nadeaus subs

  //I dont think we need to save the "left swiped" restaurants within the local state because we would update
  //the database and have a listener for when a match was identified that would push a notification to both users

  //Kaleigh Note 4: .... LOL
  Meat(
      {required this.id,
      required this.cities,
      required this.state,
      required this.zipcode,
      required this.availableRestaurants,
      required this.matchedRestaurants,
      required this.participants});

  factory Meat.initial() {
    return Meat(
        id: "",
        cities: [],
        state: "",
        zipcode: "",
        availableRestaurants: Restaurants.initial(),
        matchedRestaurants: Restaurants.initial(),
        participants: []);
  }

  Meat copyWith(
      {String? id,
      List<String>? cities,
      String? state,
      String? zipcode,
      Restaurants? availableRestaurants,
      Restaurants? matchedRestaurants,
      List<MeatParticipant>? participants}) {
    return Meat(
        id: id ?? this.id,
        cities: cities ?? this.cities,
        state: state ?? this.state,
        zipcode: zipcode ?? this.zipcode,
        availableRestaurants: availableRestaurants ?? this.availableRestaurants,
        matchedRestaurants: matchedRestaurants ?? this.matchedRestaurants,
        participants: participants ?? this.participants);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'zipcode': zipcode,
      'availableRestaurants':
          availableRestaurants.restaurants.map((r) => r.toJson()),
      'matchedRestaurants':
          matchedRestaurants.restaurants.map((r) => r.toJson()),
      'participants': participants.map((p) => p.toJson()),
    };
  }

  @override
  String toString() {
    return "Meat(id: $id), cities: $cities, state: $state, zipcode: $zipcode, availableRestaurants: $availableRestaurants, matchedRestaurants: $matchedRestaurants, participants: $participants";
  }
}
