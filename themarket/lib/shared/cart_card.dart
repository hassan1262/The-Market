import 'package:flutter/material.dart';
import 'constants.dart';

// ignore: must_be_immutable
class CartItem extends StatefulWidget {
  late String image;
  late String name;
  late double price;
  int quantity;
  CartItem(this.image, this.name, this.price, this.quantity);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    void _incrementCounter() {
      setState(() {
        this.widget.quantity++;
      });
    }

    void _decrementCounter() {
      setState(() {
        if (this.widget.quantity == 1) return;
        this.widget.quantity--;
      });
    }

    return Card(
      elevation: 5.0,
      color: offWhite,
      child: Row(
        children: [
          Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/${this.widget.image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 100.0,
                      child: Text(
                        '${this.widget.name}',
                        style: TextStyle(
                          fontSize: fontSizeH,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete_outlined,
                            color: red,
                            size: iconSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '${this.widget.price} L.E',
                  style: TextStyle(
                    color: green,
                    fontSize: fontSizeM,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
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
                        '${this.widget.quantity}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
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
  }
}
