import 'package:dinder/models/app_user_state.dart';
import 'package:dinder/models/restaurant_state.dart';

class MeatParticipant {
  final List<Restaurant> selectedRestaurants;
  final String participantId;

  MeatParticipant({required this.selectedRestaurants, required this.participantId});

  factory MeatParticipant.initial() {
    return MeatParticipant(selectedRestaurants: [], participantId: "");
  }
  MeatParticipant copyWith({List<Restaurant>? selectedRestaurants, String? participantId}) {
    return MeatParticipant(
      selectedRestaurants: selectedRestaurants ?? this.selectedRestaurants,
      participantId: participantId ?? this.participantId
    );
  }
}

class Meat {
  final String meatId;
  final List<String> cities;
  final String state;
  final String zipcode;
  final List<Restaurant> availableRestaurants;
  final List<Restaurant> matchedRestaurants;
  final List<MeatParticipant> participants;
  //Kaleigh & Faith Note: we may want to filter the list when we first get it from the API on
  //restarant name so they dont have to swipe left for 16 nadeaus subs

  //I dont think we need to save the "left swiped" restaurants within the local state because we would update
  //the database and have a listener for when a match was identified that would push a notification to both users

  //Kaleigh Note 4: .... LOL
  Meat(
      {required this.meatId,
      required this.cities,
      required this.state,
      required this.zipcode,
      required this.availableRestaurants,
      required this.matchedRestaurants,
      required this.participants});

  factory Meat.initial() {
    return Meat(meatId: "", cities: [], state: "", zipcode: "", availableRestaurants: [], matchedRestaurants: [], participants: []);
  }

  Meat copyWith(
      {String? meatId,
      List<String>? cities,
      String? state,
      String? zipcode,
      List<Restaurant>? availableRestaurants,
      List<Restaurant>? matchedRestaurants,
      List<MeatParticipant>? participants}) {
    return Meat(
        meatId: meatId ?? this.meatId,
        cities: cities ?? this.cities,
        state: state ?? this.state,
        zipcode: zipcode ?? this.zipcode,
        availableRestaurants: availableRestaurants ?? this.availableRestaurants,
        matchedRestaurants: matchedRestaurants ?? this.matchedRestaurants,
        participants: participants ?? this.participants);
  }

  @override
  String toString() {
    return "Meat(meatId: $meatId), cities: $cities, state: $state, zipcode: $zipcode, availableRestaurants: $availableRestaurants, matchedRestaurants: $matchedRestaurants, participants: $participants";
  }
}
