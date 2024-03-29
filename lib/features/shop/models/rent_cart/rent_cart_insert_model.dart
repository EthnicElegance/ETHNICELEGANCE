import 'dart:core';

class RentCartInsertModel {
  late String rentProductId;
  late String cartQTY;
  late String size;
  late String price;
  late String deposit;
  late String totalPrice;
  late String userId;
  

  RentCartInsertModel(this.rentProductId, this.cartQTY, this.size,this.price,this.deposit,this.totalPrice, this.userId);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'RentProductId': rentProductId,
        'CartQty': cartQTY,
        'Size': size,
        'Price': price,
        'Deposit': deposit,
        'TotalPrice': totalPrice,
        'UserId': userId,
      };

  factory RentCartInsertModel.fromJson(Map<String, dynamic> v) {
    return RentCartInsertModel(v["RentProductId"], v["CartQty"], v["Size"], v["Price"],v["Deposit"], v["TotalPrice"], v["UserId"]);
  }
}
