import 'dart:core';

class OrderInsertModel {
  late String userid;
  late String orderDate;
  late String shippingDate;
  late String totalAmount;
  late String userAddress;
  late String status;

  OrderInsertModel(this.userid,this.orderDate,this.shippingDate, this.totalAmount, this.userAddress, this.status);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'UserId':userid,
    'OrderDate': orderDate,
    'ShippingDate': shippingDate,
    'TotalAmount': totalAmount,
    'UserAddress': userAddress,
    'Status': status
  };

  factory OrderInsertModel.fromJson(Map<String, dynamic> v) {
    return OrderInsertModel(v["UserId"],v["OrderDate"],v["ShippingDate"], v["TotalAmount"], v["UserAddress"], v["Status"]);
  }
}
