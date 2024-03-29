import 'dart:core';

class SubCategoryModel {
  late String key;
  late String scname;
  late String photo;
  late String catid;

  SubCategoryModel(
      this.key,
      this.scname,
      this.photo,
      this.catid,
      );

  factory SubCategoryModel.fromJson(Map<String, dynamic> document) {
    return SubCategoryModel(
        document["key"], document["scname"], document["photo"],document["catid"]
    );
  }
}
