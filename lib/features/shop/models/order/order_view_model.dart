import 'dart:core';

class OrderViewModel {
  late String key;
  late String userid;
  late String orderDate;
  late String shippingDate;
  late String totalAmount;
  late String userAddress;
  late String status;

  OrderViewModel(this.key,this.userid,this.orderDate,this.shippingDate, this.totalAmount, this.userAddress, this.status);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'key':key,
    'UserId':userid,
    'OrderDate': orderDate,
    'ShippingDate': shippingDate,
    'TotalAmount': totalAmount,
    'UserAddress': userAddress,
    'Status': status
  };

  factory OrderViewModel.fromJson(Map<String, dynamic> v) {
    return OrderViewModel(v["key"],v["UserId"],v["OrderDate"],v["ShippingDate"], v["TotalAmount"], v["UserAddress"], v["Status"]);
  }
}
