import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_application/providers/cartProvider.dart';
import 'package:super_market_application/providers/product_provider.dart';
import 'package:super_market_application/shared/cart_card.dart';

// ignore: must_be_immutable
class Cart extends StatefulWidget {
  Cart();
  final double deliveryCharge = 5.0;
  late bool check;
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool showHide() {
    if (Provider.of<CartProviders>(context, listen: true).totalCartPrice() ==
        0.0) {
      this.widget.check = false;
    } else {
      this.widget.check = true;
    }
    return this.widget.check;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Consumer<CartProviders>(
                  builder: (context, CartProviders cart, child) {
                    return cart.getProduct.length != 0
                        ? ListView.builder(
                            itemCount: cart.getProduct.length,
                            itemBuilder: (context, index) {
                              return CartCard(cart.getProduct[index], index);
                            },
                          )
                        : Center(
                            child: Text(
                              'Empty Cart',
                            ),
                          );
                  },
                ),
              ),
              Visibility(
                visible: showHide(),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  height: 150,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Delivery Charge: ${this.widget.deliveryCharge} L.E',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Consumer<CartProviders>(
                            builder: (context, CartProviders cart, child) {
                              return Text(
                                'Sub. Total: ${Provider.of<CartProviders>(context, listen: false).totalCartPrice().toString()} L.E',
                              );
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<CartProviders>(
                            builder: (context, CartProviders cart, child) {
                              return Text(
                                'Total: ${(Provider.of<CartProviders>(context, listen: false).totalCartPrice() + this.widget.deliveryCharge).toString()} L.E',
                              );
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await Provider.of<CartProviders>(context,
                                      listen: false)
                                  .checkOut();
                              Provider.of<CartProviders>(context, listen: false)
                                  .clearList();
                              Provider.of<ProductProviders>(context,
                                      listen: false)
                                  .destroyList();
                              Navigator.pushNamed(context, '/Home');
                            },
                            child: Text(
                              'Check out',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
