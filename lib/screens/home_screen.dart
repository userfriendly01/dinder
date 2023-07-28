import 'package:dinder/actions/general_actions.dart';
import 'package:dinder/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) => store.state.toMap(),
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomMenu(currentIndex: 0),
          body: Column(
            children: [
              Text("HOME!"),
              Text('yo ${state['name']}'),
              IconButton(onPressed: () {
                StoreProvider.of<AppState>(context)
                  .dispatch(UpdateNameAction('Kaleigh and Faith'));
              }, icon: Icon(Icons.cookie))
            ],
          ),
      );
      },
    );
  }
}