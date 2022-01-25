import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:super_market_application/shared/app_bar.dart';
import 'package:super_market_application/shared/card_list.dart';
import 'package:super_market_application/shared/constants.dart';
import 'package:super_market_application/shared/side_menu_bar.dart';

getUserIn() {
  var user = FirebaseAuth.instance.currentUser;
  print(user!.email);
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUserIn();
    return Scaffold(
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: TopBar('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    color: green,
                    fontSize: fontSizeHH,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                crossAxisCount: 1,
                children: [
                  Cards('fruits.jpeg', 'Fruits'),
                  Cards('bakery.jpeg', 'Bread & Bakery'),
                  Cards('vegtables.jpeg', 'Vegtables'),
                  Cards('personal-care.jpeg', 'Personal Care'),
                  Cards('pasta-rice.jpeg', 'Pasta & Rice'),
                  Cards('meats.jpeg', 'Meats'),
                  Cards('snacks.jpeg', 'Snacks'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
