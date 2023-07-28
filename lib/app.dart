import 'package:flutter/material.dart';

class DinderApp extends StatelessWidget {
  const DinderApp({super.key});

  String get name => 'dinder';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Dinder",
        home: Scaffold(
          appBar: AppBar(title: Text("Look at this Fancy App")),
          body: Center(child: Text("Here I am!")),
        ));
  }
}
