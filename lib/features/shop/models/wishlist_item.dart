import 'dart:core';
class WishlistItem {

  final String productId;
  final String? userId;

  WishlistItem({required this.productId, required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
    };
  }
}

  /*factory WishlistModel.fromJson(Map<String, dynamic> document) {
    return WishlistModel(
        document["productId"], document["userId"]
    );
  }*/

