import 'package:dinder/actions/app_user_actions.dart';
import 'package:dinder/models/restaurant_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/shared/app_bar.dart';
import '../services/firestore.dart';
import '../shared/bottom_menu.dart';
import '../actions/meat_actions.dart';
import '../models/app_state.dart';
import '../models/meat_state.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipeYourMeatScreen extends StatefulWidget {
  const SwipeYourMeatScreen({super.key});

  @override
  State<SwipeYourMeatScreen> createState() => _SwipeYourMeatScreenState();
}

class _SwipeYourMeatScreenState extends State<SwipeYourMeatScreen> {
  final CardSwiperController controller = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {

        List<Card> cards = vm.availableRestaurants.map((r) {
          return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(r.restaurantName)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(r.cuisineType ?? "")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(r.phone ?? "No phone number listed")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(r.website ?? "", textAlign: TextAlign.center,)
                          )
                        ],
                      ),
                    ],
                  ),
                );
        }).toList();



        return Scaffold(
          appBar: const DinderAppBar(),
          bottomNavigationBar: BottomMenu(currentIndex: 0),
          body: SafeArea(
            child: Column(
              children: [
                Flexible(
                  child: CardSwiper(
                    numberOfCardsDisplayed: 1,
                    controller: controller,
                    cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index], 
                    cardsCount: vm.availableRestaurants.length,
                    isLoop: false,
                  ),
                ),
              ],
            )
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final String? displayName;
  final Meat activeMeat;
  final List<Restaurant> availableRestaurants;

  //dont know if we'll use this and add a reducer function or just Meat()
  //May want to read into forms in flutter a bit

  const _ViewModel({
    required this.displayName,
    required this.activeMeat,
    required this.availableRestaurants
  });

  static fromStore(Store<AppState> store) {
    final FirestoreService firestoreService = FirestoreService.instance;

    return _ViewModel(
        displayName: store.state.userState.displayName,
        activeMeat: store.state.meatState,
        availableRestaurants: store.state.meatState.availableRestaurants.restaurants,
    );
  }
}
