import 'dart:core';

class WishlistModel {
  late String key;
  late String productId;
  late String userId;


  WishlistModel(
      this.key,
      this.productId,
      this.userId,
      );

  factory WishlistModel.fromJson(Map<String, dynamic> document) {
    return WishlistModel(
        document["key"],
        document["productId"],
        document["userId"],
        );
  }
}
