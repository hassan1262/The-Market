import 'package:flutter/material.dart';
import 'package:super_market_application/shared/constants.dart';

// ignore: must_be_immutable
class Cards extends StatefulWidget {
  String? image;
  String? categoryName;
  Cards(this.image, this.categoryName);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        // or Gesture detector
        onTap: () {
          Navigator.pushNamed(
            context,
            '/products',
            arguments: {'categoryName': this.widget.categoryName},
            // pass argument when going to the next screen
          );
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/${this.widget.image}'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 1,
              child: Container(
                color: Colors.black45,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${this.widget.categoryName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSizeM,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
