import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_market_application/models/cart.dart';

class CartProviders extends ChangeNotifier {
  final CollectionReference orderHistoryCollection =
      FirebaseFirestore.instance.collection('Orders');
  List<Cart> products = <Cart>[];
  List<Cart> get getProduct {
    return products;
  }

  void addProducts(String picture, String name, int quantity, String price,
      String totalPrice) {
    Cart product = new Cart(picture, name, quantity, price, totalPrice);
    products.add(product);
    notifyListeners();
  }

  Future<void> checkOut() async {
    double res = totalCartPrice();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid') ?? '';
    String? email = prefs.getString('email');
    DateTime now = DateTime.now();
    String id = now.hour.toString() +
        now.minute.toString() +
        now.second.toString() +
        now.toString();
    String result = uid + id;
    String f = '';
    for (int i = 0; i < products.length; i++) {
      f = f + ' ' + products[i].name;
      await FirebaseFirestore.instance.collection('Orders').doc(result).set(
        {
          'email': email.toString(),
          'name': f,
          'quantity': products[i].quantity,
          'price': res,
        },
      );
    }
    products.clear();
    notifyListeners();
  }

  void clearList() {
    products.clear();
    notifyListeners();
  }

  void removeProducts(int index) {
    products.removeAt(index);
    notifyListeners();
  }

  void editProducts(int index, int quantity, String price) {
    products[index].totalPrice = price;
    products[index].quantity = quantity;
    notifyListeners();
  }

  double totalCartPrice() {
    double totalPrice = 0.0;
    try {
      for (int i = 0; i < getProduct.length; i++) {
        totalPrice += double.parse(getProduct[i].price.toString()) *
            getProduct[i].quantity;
      }
    } on FormatException {
      print('Format error from string to double');
    }
    return totalPrice;
  }

  String productName(int index) {
    return products[index].name;
  }

  int productQuantity(int index) {
    return products[index].quantity;
  }

  String productPrice(int index) {
    return products[index].price;
  }
}
