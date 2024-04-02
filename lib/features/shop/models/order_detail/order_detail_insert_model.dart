import 'dart:core';

class OrderDetailInsertModel {
  late String orderId;
  late String productId;
  late String qty;
  late String size;
  late String price;
  late String totalPrice;

  OrderDetailInsertModel(this.orderId,this.productId, this.qty,this.size,this.price, this.totalPrice);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'OrderId':orderId,
    'ProductId': productId,
    'Qty': qty,
    'Size': size,
    'Price': price,
    'TotalPrice': totalPrice
  };

  factory OrderDetailInsertModel.fromJson(Map<dynamic, dynamic> v) {
    return OrderDetailInsertModel(v["OrderId"],v["ProductId"], v["Qty"], v["Size"], v["Price"], v["TotalPrice"]);
  }
}
