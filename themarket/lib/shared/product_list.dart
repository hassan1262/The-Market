import 'package:flutter/material.dart';
import 'package:super_market_application/models/product.dart';

import 'constants.dart';

// ignore: must_be_immutable
class ProductItem extends StatefulWidget {
  final bool _isFav = false;
  int _quantity = 1;
  Product data;
  int index;
  ProductItem(this.data, this.index);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    void _incrementCounter() {
      setState(() {
        this.widget._quantity++;
      });
    }

    void _decrementCounter() {
      setState(() {
        if (this.widget._quantity == 1) return;
        this.widget._quantity--;
      });
    }

    dynamic arguments = ModalRoute.of(context)!.settings.arguments as Map;
    if (arguments['categoryName'] == widget.data.category) {
      return Card(
        elevation: 5.0,
        color: offWhite,
        child: Row(
          children: [
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 130.0,
                        child: Text(
                          '${this.widget.data.name}',
                          style: TextStyle(
                            fontSize: fontSizeM,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Item added to the cart successfully',
                                  style: TextStyle(
                                    fontSize: fontSizeS,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Remove'),
                                    child: const Text(
                                      'Remove',
                                      style: TextStyle(
                                        fontSize: fontSizeS,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      primary: red,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Confirm'),
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(
                                        fontSize: fontSizeS,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      primary: green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            icon: Icon(
                              Icons.shopping_bag_outlined,
                              color: green,
                              size: iconSize,
                            ),
                          ),
                          FavInteraction(this.widget._isFav),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '${this.widget.data.price} L.E',
                    style: TextStyle(
                      color: green,
                      fontSize: fontSizeM,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            _decrementCounter();
                          },
                          icon: Icon(
                            Icons.remove,
                            color: green,
                            size: iconSize,
                          ),
                        ),
                        Text(
                          '${this.widget._quantity}',
                          style: TextStyle(
                            fontSize: fontSizeS,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _incrementCounter();
                          },
                          icon: Icon(
                            Icons.add,
                            color: green,
                            size: iconSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else
      return Container();
  }
}

// ignore: must_be_immutable
class FavInteraction extends StatefulWidget {
  bool isFavorite;
  FavInteraction(this.isFavorite);

  @override
  _FavInteractionState createState() => _FavInteractionState();
}

class _FavInteractionState extends State<FavInteraction> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: _iconChecker(),
    );
  }

  _iconChecker() {
    if (this.widget.isFavorite == false) {
      return Icon(
        Icons.favorite_outline,
        color: red,
      );
    } else
      return Icon(
        Icons.favorite_outlined,
        color: red,
      );
  }

  _toggleFavorite() {
    setState(
      () {
        if (!this.widget.isFavorite) {
          this.widget.isFavorite = true;
        } else {
          this.widget.isFavorite = false;
        }
      },
    );
  }
}
