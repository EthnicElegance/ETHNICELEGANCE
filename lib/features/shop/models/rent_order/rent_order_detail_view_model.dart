import 'dart:core';

class RentOrderDetailViewModel {
  late String key;
  late String orderId;
  late String rentProductId;
  late String qty;
  late String size;
  late String price;
  late String totalPrice;

  RentOrderDetailViewModel(this.key,this.orderId,this.rentProductId, this.qty,this.size,this.price, this.totalPrice);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'Key':key,
    'OrderId':orderId,
    'RentProductId': rentProductId,
    'Qty': qty,
    'Size': size,
    'Price': price,
    'TotalPrice': totalPrice
  };

  factory RentOrderDetailViewModel.fromJson(Map<dynamic, dynamic> v) {
    return RentOrderDetailViewModel(v["Key"],v["OrderId"],v["RentProductId"], v["Qty"], v["Size"], v["Price"], v["TotalPrice"]);
  }
}
