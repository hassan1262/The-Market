import 'package:flutter/material.dart';
import 'package:super_market_application/shared/constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: textInputDecoration.copyWith(
        hintText: 'search for an item...',
        hintStyle: TextStyle(
          fontSize: fontSizeM,
        ),
        suffixIcon: Icon(
          Icons.search_outlined,
        ),
      ),
    );
  }
}
