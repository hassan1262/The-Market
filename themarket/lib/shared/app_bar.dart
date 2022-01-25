import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_application/providers/product_provider.dart';
import 'package:super_market_application/shared/constants.dart';

// ignore: must_be_immutable
class TopBar extends StatelessWidget {
  String _title;

  TopBar([this._title = '']);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        this._title,
        style: TextStyle(
          color: green,
        ),
      ),
      iconTheme: IconThemeData(
        color: green,
      ),
      backgroundColor: offWhite,
      elevation: 0.0,
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app_sharp),
          onPressed: () async {
            Provider.of<ProductProviders>(context, listen: false).destroyList();
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed("/signin");
          },
        ),
      ],
    );
  }
}
