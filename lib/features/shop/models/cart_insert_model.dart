import 'dart:core';

class CartInsertModel {
  late String productId;
  late String cartQTY;
  late String size;
  late String price;
  late String userId;
  

  CartInsertModel(this.productId, this.cartQTY, this.size,this.price, this.userId);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'productId': productId,
        'cartQty': cartQTY,
        'size': size,
        'price': price,
        'userId': userId,
      };

  factory CartInsertModel.fromJson(Map<String, dynamic> v) {
    return CartInsertModel(v["productId"], v["cartQty"], v["size"], v["price"], v["userId"]);
  }
}