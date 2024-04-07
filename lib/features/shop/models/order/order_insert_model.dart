import 'dart:core';

class OrderInsertModel {
  late String userid;
  late String orderDate;
  late String shippingDate;
  late String subAmount;
  late String couponDiscount;
  late String shippingFee;
  late String taxFee;
  late String totalAmount;
  late String userAddress;
  late String status;

  OrderInsertModel(this.userid,this.orderDate,this.shippingDate, this.subAmount, this.couponDiscount, this.shippingFee , this.taxFee, this.totalAmount, this.userAddress, this.status);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'UserId':userid,
    'OrderDate': orderDate,
    'ShippingDate': shippingDate,
    'SubAmount': subAmount,
    'CouponDiscount': couponDiscount,
    'ShippingFee': shippingFee,
    'TaxFee': taxFee,
    'TotalAmount': totalAmount,
    'UserAddress': userAddress,
    'Status': status
  };

  factory OrderInsertModel.fromJson(Map<String, dynamic> v) {
    return OrderInsertModel(v["UserId"],v["OrderDate"],v["ShippingDate"], v["SubAmount"], v["CouponDiscount"], v["ShippingFee"], v["TaxFee"], v["TotalAmount"], v["UserAddress"], v["Status"]);
  }
}
