import 'dart:convert';

import 'package:dinder/actions/app_user_actions.dart';
import 'package:dinder/models/restaurant_state.dart';
import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/models/app_state.dart';
import '../actions/friends_list_actions.dart';
import 'package:dinder/shared/app_bar.dart';
import '../actions/meat_actions.dart';
import '../models/app_user_state.dart';
import '../models/meat_state.dart';
import '../services/firestore.dart';
import '../services/auth.dart';
import 'package:http/http.dart' as http;

Future<http.Response> fetchRestaurants(String zipcode) {
  return http.get(
      Uri.parse(
          'https://restaurants-near-me-usa.p.rapidapi.com/restaurants/location/zipcode/$zipcode/0'),
      headers: {
        'X-RapidAPI-Key': '17a02516f1mshb1bab854052a656p16a8cajsnedeb620fc3f7',
        'X-RapidAPI-Host': 'restaurants-near-me-usa.p.rapidapi.com'
      });
}

class FreshMeatScreen extends StatefulWidget {
  const FreshMeatScreen({super.key});

  @override
  State<FreshMeatScreen> createState() => _FreshMeatScreenState();
}

class _FreshMeatScreenState extends State<FreshMeatScreen> {
  final TextEditingController zipcodeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  List<String> _selectedFriendsList = [];
  String _errorMessage = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    var picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInitialBuild: (viewModel) {
        if (viewModel.friendsList.isEmpty) {
          viewModel.loadFriends();
        }
      },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const DinderAppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text(
                    "Create A New Meat!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const Padding(padding: EdgeInsets.all(30)),
                  const Text("Where do you want to meat?"),
                  TextField(
                    controller: zipcodeController,
                    decoration: const InputDecoration(hintText: "Zipcode"),
                  ),
                  const Padding(padding: EdgeInsets.all(25)),
                  const Text("When do you want to meat?"),
                  const Padding(padding: EdgeInsets.all(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: const Text('Select date'),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedTime.format(context),
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          ElevatedButton(
                            onPressed: () => _selectTime(context),
                            child: const Text('Select time'),
                            //TODO - Save Time
                          ),
                        ],
                      )
                    ],
                  ),

                  const Padding(padding: EdgeInsets.all(25)),
                  Text(vm.friendsList.isEmpty
                      ? "Oh no! You need some friends"
                      : "Select your friends"),
                  ListView.separated(
                    primary: false,
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    // physics: const ClampingScrollPhysics(),
                    itemCount: vm.friendsList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(color: Colors.grey);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final friend = vm.friendsList[index];
                      return ListTile(
                        title: Text("${friend.displayName}"),
                        selected: _selectedFriendsList.contains(friend.id),
                        selectedTileColor:
                            const Color.fromARGB(255, 196, 169, 208),
                        onTap: () {
                          List<String> updatedList = _selectedFriendsList;
                          if (_selectedFriendsList.contains(friend.id)) {
                            print("REMOVE ${friend.id}");
                            updatedList.remove(friend.id);
                          } else {
                            print("ADD ${friend.id}");
                            updatedList.add(friend.id);
                          }
                          setState(() {
                            _selectedFriendsList = updatedList;
                          });
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  // If user has no friends we render a button that navigates to the friend page
                  vm.friendsList.isNotEmpty
                      ? ElevatedButton(
                          onPressed: () async {
                            bool isZipValid = RegExp(r"^\d{5}(-\d{4})?$",
                                    caseSensitive: false)
                                .hasMatch(zipcodeController.text);
                            if (_selectedFriendsList.isEmpty) {
                              setState(() {
                                _errorMessage = "Oops, select some friends.";
                              });
                            } else if (zipcodeController.text == "") {
                              setState(() {
                                _errorMessage = "Oh no!  Enter a zipcode.";
                              });
                            } else if (!isZipValid) {
                              setState(() {
                                _errorMessage =
                                    "Hmmmm... I don't think that zipcode is real...";
                              });
                            } else {
                              setState(() {
                                _errorMessage = "";
                              });
                              final response = await fetchRestaurants(
                                  zipcodeController.text);
                              final resty = Restaurants.fromJson(
                                  jsonDecode(response.body));
                              vm.createMeat(
                                  _selectedFriendsList,
                                  resty,
                                  zipcodeController.text,
                                  selectedDate.toString());
                              // Todo: navigate to the next screen
                            }
                          },
                          child: const Text("Create Meat-Up"))
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/friends");
                          },
                          child: const Text("Find some Friends")),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomMenu(currentIndex: 2),
        );
      },
    );
  }
}

class _ViewModel {
  final String? displayName;
  final void Function() loadFriends;
  final void Function(List<String>, Restaurants, String, String) createMeat;
  final List<AppUser> friendsList;

  const _ViewModel({
    required this.displayName,
    required this.loadFriends,
    required this.createMeat,
    required this.friendsList,
  });

  static fromStore(Store<AppState> store) {
    final FirestoreService firestoreService = FirestoreService.instance;

    List<AppUser> formatFriends() {
      return store.state.friendsListState.friends
          .where(
              (element) => store.state.userState.friends.contains(element.id))
          .toList();
    }

    MeatParticipants formatParticipants(List<String> participants) {
      final formattedParticipants = participants
          .map((p) => MeatParticipant(
              selectedRestaurants: Restaurants.initial(), participantId: p))
          .toList();
      return MeatParticipants(participants: formattedParticipants);
    }

    return _ViewModel(
        displayName: store.state.userState.displayName != ""
            ? "${store.state.userState.displayName}'s"
            : "My",
        friendsList: formatFriends(),
        loadFriends: () async {
          final possibleFriends = await firestoreService.getAllUsers().first;
          store.dispatch(LoadFriendsList(possibleFriends));
        },
        createMeat: (List<String> participants,
            Restaurants availableRestaurants,
            String zipcode,
            String date) async {
          final inclusiveParticipants = [
            ...participants,
            store.state.userState.id
          ];
          final instance = Meat(
              id: "",
              date: date,
              state: "",
              matchedRestaurants: Restaurants.initial(),
              cities: [],
              availableRestaurants: availableRestaurants,
              zipcode: zipcode,
              participants: formatParticipants(inclusiveParticipants));

          final meatId = await firestoreService.createMeat(instance);
          inclusiveParticipants
              .forEach((p) => firestoreService.updateUserActiveMeat(p, meatId));

          store.dispatch(CreateMeat(instance.copyWith(id: meatId)));
        });
  }
}
