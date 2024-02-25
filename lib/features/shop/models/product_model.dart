import 'dart:core';

class ProductModel {
  late String key;
  late String pname;
  late String pphoto;
  late String price;
  late String availability;

  ProductModel(
      this.key,
      this.pname,
      this.pphoto,
      this.price,
      this.availability);

  factory ProductModel.fromJson(Map<String, dynamic> document) {
      return ProductModel(
          document["key"], document["pname"], document["pphoto"],document["price"],document["availability"]
      );
  }
}
