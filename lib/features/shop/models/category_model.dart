import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  late String id;
  late String name;
  late String photo;
  late String gender;

  CategoryModel({required this.id,required this.name, required this.photo, required this.gender});

  static CategoryModel empty() => CategoryModel(id: '', name: '', photo: '', gender: '');

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'name': name,
        'photo': photo,
        'gender': gender,
      };

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      return CategoryModel(
          id : document.id,
          name : document["name"] ?? '',
          photo : document["photo"] ?? '',
          gender : document["gender"] ?? ''
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
