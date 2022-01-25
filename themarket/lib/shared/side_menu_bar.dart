import 'package:flutter/material.dart';
import 'package:super_market_application/shared/constants.dart';

class SideBar extends StatelessWidget {
  const SideBar();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: offWhite,
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.scaleDown,
              ),
            ),
            child: null,
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/Home');
            },
          ),
          ListTile(
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/editprofile');
            },
          ),
          ListTile(
            title: const Text('Cart'),
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            title: const Text('Help'),
            onTap: () {
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            title: const Text('Favourite'),
            onTap: () {
              Navigator.pushNamed(context, '/fav');
            },
          ),
        ],
      ),
    );
  }
}
