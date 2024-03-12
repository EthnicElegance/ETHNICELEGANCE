import 'dart:core';

class CartInsertModel1 {
  late String id;
  late String productId;
  late String cartQTY;
  late String size;
  late String price;
  late String userId;
  

  CartInsertModel1(this.id,this.productId, this.cartQTY, this.size, this.price, this.userId);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'id': productId,
        'productId': productId,
        'cartQty': cartQTY,
        'size': size,
        'price': price,
        'userId': userId,
      };

  factory CartInsertModel1.fromJson(Map<String, dynamic> v) {
    return CartInsertModel1(v["id"],v["productId"], v["cartQty"], v["size"], v["price"], v["userId"]);
  }
}
