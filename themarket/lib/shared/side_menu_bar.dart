import 'package:flutter/material.dart';
import 'package:super_market_application/shared/constants.dart';

class SideBar extends StatelessWidget {
  const SideBar();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFFFFCEB),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFFFC300),
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          Ink(
            child: ListTile(
              title: const Text('Home',style: TextStyle(
                  color: Color(0xFFFFFCEB),
                ),),
              onTap: () {
                Navigator.pushNamed(context, '/Home');
              },
            ),
            color: Color(0xFF000814),
          ),
          Ink(
            child: ListTile(
              title: const Text(
                'View Profile',style: TextStyle(
                  color: Color(0xFFFFFCEB),
                  
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/editprofile');
              },
            ),
            color: Color(0xFF000814),
          ),
          Ink(
            child: ListTile(
              title: const Text(
                'Cart',
                style: TextStyle(
                  color: Color(0xFFFFFCEB),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
            color: Color(0xFF000814),
          ),
          Ink(
            child: ListTile(
              title: const Text('About Us',style: TextStyle(
                  color: Color(0xFFFFFCEB),
                ),),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            color: Color(0xFF000814),
          ),
          Ink(
            child: ListTile(
              title: const Text('FAQs',style: TextStyle(
                  color: Color(0xFFFFFCEB),
                ),),
              onTap: () {
                Navigator.pushNamed(context, '/faq');
              },
            ),
            color: Color(0xFF000814),
          ),
          Ink(
            child: ListTile(
              title: const Text('Favorite',style: TextStyle(
                  color: Color(0xFFFFFCEB),
                ),),
              onTap: () {
                Navigator.pushNamed(context, '/fav');
              },
            ),
            color: Color(0xFF000814),
          ),
        ],
      ),
    );
  }
}
