import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:super_market_application/models/product.dart';

class ProductProviders extends ChangeNotifier {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Products');
  List<Product> products = <Product>[];
  List<Product> get getProduct {
    return products;
  }

  void addProducts(String picture, String name, String price, String category,
      String id) async {
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(id.toString())
        .set(
      {
        'picture': picture,
        'pid': id,
        'name': name,
        'price': price,
        'category': category,
      },
    );
    Product product = Product(picture, name, price, category, id);
    products.add(product);
    notifyListeners();
  }

  editProducts(int index, String picture, String name, String price,
      String category) async {
    products[index].picture = picture;
    products[index].name = name;
    products[index].price = price;
    products[index].category = category;

    await FirebaseFirestore.instance
        .collection('Products')
        .doc(products[index].id)
        .update(
      {
        'picture': products[index].picture,
        'pid': products[index].id,
        'name': products[index].name,
        'price': products[index].price,
        'category': products[index].category,
      },
    );
    notifyListeners();
  }

  void destroyList() {
    products.clear();
    notifyListeners();
  }

  void removeProducts(int index) async {
    String id = products[index].id;
    print('id $id');
    await FirebaseFirestore.instance.collection('Products').doc(id).delete();
    products.removeAt(index);
    notifyListeners();
  }

  load() async {
    QuerySnapshot querySnapshot1 = await productsCollection.get();
    var result1 =
        querySnapshot1.docs.map((doc) => {'data': doc.data(), 'id': doc.id});

    var allData = []..addAll(result1);

    for (var element in allData) {
      Product product = new Product.fromJson(element);
      products.add(product);
      notifyListeners();
    }
  }

  int getCatProductCount(String category) {
    int cnt = 0;
    for (int i = 0; i < products.length; i++) {
      if (products[i].category == category) cnt++;
    }
    return cnt;
  }

  String name(int index) {
    return products[index].name;
  }

  String price(int index) {
    return products[index].price;
  }

  String category(int index) {
    return products[index].category;
  }

  String picture(int index) {
    return products[index].picture;
  }
}
