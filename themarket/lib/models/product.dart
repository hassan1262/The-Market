class Product {
  String picture;
  String name;
  String price;
  String category;
  String id;
  Product(this.picture, this.name, this.price, this.category, this.id);

  factory Product.fromJson(Map json) {
    return Product(
      json['data']['picture'] ?? '',
      json['data']['name'],
      json['data']['price'],
      json['data']['category'],
      json['data']['pid'] ?? 'null',
    );
  }
}
