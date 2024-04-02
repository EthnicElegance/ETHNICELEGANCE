import 'dart:core';

class OrderDetailModel {
  late String id;
  late String orderId;
  late String productId;
  late String qty;
  late String size;
  late String price;
  late String totalPrice;

  OrderDetailModel(this.id,this.orderId,this.productId, this.qty,this.size,this.price, this.totalPrice);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'Id':id,
    'OrderId':orderId,
    'ProductId': productId,
    'Qty': qty,
    'Size': size,
    'Price': price,
    'TotalPrice': totalPrice
  };

  factory OrderDetailModel.fromJson(Map<dynamic, dynamic> v) {
    return OrderDetailModel(v["Id"],v["OrderId"],v["ProductId"], v["Qty"], v["Size"], v["Price"], v["TotalPrice"]);
  }
}
