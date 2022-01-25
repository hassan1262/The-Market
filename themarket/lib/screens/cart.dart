import 'package:flutter/material.dart';
import 'package:super_market_application/shared/app_bar.dart';
import 'package:super_market_application/shared/cart_card.dart';
import 'package:super_market_application/shared/constants.dart';
import 'package:super_market_application/shared/side_menu_bar.dart';

// ignore: must_be_immutable
class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: TopBar('Cart'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(5.0),
        children: [
          const SizedBox(height: 5.0),
          CartItem('mango.jpeg', 'Mango', 25.0, 1),
          CartItem('banana.jpeg', 'Banana', 15.0, 1),
          CartItem('apple.jpeg', 'Apple', 20.0, 1),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(35.0),
            height: 150,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Delivery Charge: 10.0 L.E',
                      style: TextStyle(
                        color: white,
                        fontSize: fontSizeS,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Sub Total: 60.0 L.E',
                      style: TextStyle(
                        color: white,
                        fontSize: fontSizeS,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: 70.0 L.E',
                      style: TextStyle(
                        color: white,
                        fontSize: fontSizeS,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
