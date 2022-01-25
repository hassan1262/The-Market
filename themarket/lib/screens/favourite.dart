import 'package:flutter/material.dart';
import 'package:super_market_application/shared/app_bar.dart';
import 'package:super_market_application/shared/side_menu_bar.dart';

// ignore: must_be_immutable
class Favourite extends StatelessWidget {
  Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: TopBar('Favourite'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 10.0),
          // ProductItem('mango.jpeg', 'Mango', 25.0, true, 1),
          // ProductItem('banana.jpeg', 'Banana', 15.0, true, 1),
          // ProductItem('apple.jpeg', 'Apple', 20.0, true, 1),
        ],
      ),
    );
  }
}
