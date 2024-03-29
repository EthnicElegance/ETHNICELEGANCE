import 'dart:core';

class RentOrderViewModel {
  late String key;
  late String userid;
  late String orderDate;
  late String totalAmount;
  late String depositAmount;
  late String status;

  RentOrderViewModel(this.key,this.userid,this.orderDate, this.totalAmount, this.depositAmount,this.status);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'key':key,
    'UserId':userid,
    'OrderDate': orderDate,
    'TotalAmount': totalAmount,
    'DepositAmount': depositAmount,
    'Status': status
  };

  factory RentOrderViewModel.fromJson(Map<String, dynamic> v) {
    return RentOrderViewModel(v["key"],v["UserId"],v["OrderDate"], v["TotalAmount"],v["DepositAmount"], v["Status"]);
  }
}
