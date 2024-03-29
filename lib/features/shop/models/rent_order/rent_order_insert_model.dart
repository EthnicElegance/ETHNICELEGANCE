import 'dart:core';

class RentOrderInsertModel {
  late String userid;
  late String orderDate;
  late String totalAmount;
  late String depositAmount;
  late String status;

  RentOrderInsertModel(this.userid,this.orderDate, this.totalAmount, this.depositAmount, this.status);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'UserId':userid,
    'OrderDate': orderDate,
    'TotalAmount': totalAmount,
    'DepositAmount': depositAmount,
    'Status': status
  };

  factory RentOrderInsertModel.fromJson(Map<String, dynamic> v) {
    return RentOrderInsertModel(v["UserId"],v["OrderDate"], v["TotalAmount"], v["DepositAmount"], v["Status"]);
  }
}
