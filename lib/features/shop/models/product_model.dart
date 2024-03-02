import 'dart:core';

class ProductModel {
  late String key;
  late String subcatid;
  late String pname;
  late String pphoto1;
  late String pphoto2;
  late String pphoto3;
  late String price;
  late String size;
  late int qty;
  late String colour;
  late String fabric;
  late String details;
  late String availability;
  late String datetime;

  ProductModel(
      this.key,
      this.subcatid,
      this.pname,
      this.pphoto1,
      this.pphoto2,
      this.pphoto3,
      this.price,
      this.size,
      this.qty,
      this.colour,
      this.fabric,
      this.details,
      this.datetime,
      this.availability);

  factory ProductModel.fromJson(Map<String, dynamic> document) {
    return ProductModel(
        document["key"],
        document["subcatid"],
        document["pname"],
        document["pphoto1"],
        document["pphoto2"],
        document["pphoto3"],
        document["price"],
        document["size"],
        document["qty"],
        document["colour"],
        document["fabric"],
        document["details"],
        document["datetime"],
        document["availability"]);
  }
}
