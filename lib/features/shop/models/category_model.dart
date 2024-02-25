import 'dart:core';

class CategoryModel {
  late String key;
  late String cname;
  late String cphoto;
  late String gen;

  CategoryModel(
      this.key,
      this.cname,
      this.cphoto,
      this.gen,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> document) {
    return CategoryModel(
        document["key"], document["cname"], document["cphoto"],document["gen"]
    );
  }
}
