import 'package:flutter/material.dart';
import 'package:dinder/screens/friends_screen.dart';
import 'package:dinder/screens/home_screen.dart';
import 'package:dinder/screens/my_profile_screen.dart';

class BottomMenu extends StatelessWidget {
  int currentIndex;

  BottomMenu({
    super.key,
    required this.currentIndex
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        Widget screen = Container();
        switch (index) {
          case 0:
            screen = HomeScreen();
            break;
          case 1:
            screen = FriendsScreen();
            break;
          case 2:
            screen = MyProfileScreen();
            break;
        }
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Friends',
          activeIcon: Icon(Icons.people)
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedIconTheme: IconThemeData(color: Colors.deepPurple),
    );
  }
}