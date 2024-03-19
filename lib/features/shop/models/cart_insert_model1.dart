import 'dart:core';

class CartModel1 {
  late String id;
  late String productId;
  late String cartQTY;
  late String size;
  late String price;
  late String totalPrice;
  late String userId;
  

  CartModel1(this.id,this.productId, this.cartQTY, this.size, this.price,this.totalPrice, this.userId);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'id': productId,
        'productId': productId,
        'cartQty': cartQTY,
        'size': size,
        'price': price,
        'totalPrice': totalPrice,
        'userId': userId,
      };

  factory CartModel1.fromJson(Map<String, dynamic> v) {
    return CartModel1(v["id"],v["productId"], v["cartQty"], v["size"], v["price"], v["totalPrice"], v["userId"]);
  }
}
