import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_application/models/cart.dart';
import 'package:super_market_application/providers/cartProvider.dart';
import 'package:super_market_application/shared/constants.dart';

// ignore: must_be_immutable
class CartCard extends StatefulWidget {
  Cart cart;
  int index;
  CartCard(this.cart, this.index);

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  String _defaultPrice() {
    final String defaultPrice = this.widget.cart.price;
    return defaultPrice;
  }

  String _price() {
    String defaultPriceReturn = _defaultPrice();
    double price = double.parse(defaultPriceReturn) * this.widget.cart.quantity;
    return price.toString();
  }

  void _incrementCounter() {
    setState(() {
      this.widget.cart.quantity++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (this.widget.cart.quantity == 1) return;
      this.widget.cart.quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.cart.picture,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100.0,
                      child: Text(
                        '${this.widget.cart.name}',
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Provider.of<CartProviders>(context, listen: false)
                                .editProducts(
                              widget.index,
                              widget.cart.quantity,
                              this._price(),
                            );
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<CartProviders>(context, listen: false)
                                .removeProducts(widget.index);
                          },
                          icon: Icon(
                            Icons.delete_outlined,
                            color: red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '${this._price()} L.E',
                  style: TextStyle(
                    color: black,
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
                        '${this.widget.cart.quantity}',
                        style: TextStyle(
                          color: red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _incrementCounter();
                        },
                        icon: Icon(
                          Icons.add,
                          color: red,
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
  }
}
