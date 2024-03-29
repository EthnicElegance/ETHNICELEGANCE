import 'dart:core';

class RentOrderDetailInsertModel {
  late String orderId;
  late String rentProductId;
  late String qty;
  late String size;
  late String price;
  late String totalPrice;

  RentOrderDetailInsertModel(this.orderId,this.rentProductId, this.qty,this.size,this.price, this.totalPrice);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'OrderId':orderId,
    'RentProductId': rentProductId,
    'Qty': qty,
    'Size': size,
    'Price': price,
    'TotalPrice': totalPrice
  };

  factory RentOrderDetailInsertModel.fromJson(Map<dynamic, dynamic> v) {
    return RentOrderDetailInsertModel(v["OrderId"],v["RentProductId"], v["Qty"], v["Size"], v["Price"], v["TotalPrice"]);
  }
}
