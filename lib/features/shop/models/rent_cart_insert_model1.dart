import 'dart:core';

class RentCartInsertModel1 {
  late String id;
  late String rentProductId;
  late String cartQTY;
  late String size;
  late String price;
  late String deposit;
  late String totalPrice;
  late String userId;
  

  RentCartInsertModel1(this.id,this.rentProductId, this.cartQTY, this.size,this.price,this.deposit,this.totalPrice, this.userId);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'Id': id,
        'RentProductId': rentProductId,
        'CartQty': cartQTY,
        'Size': size,
        'Price': price,
        'Deposit': deposit,
        'TotalPrice': totalPrice,
        'UserId': userId,
      };

  factory RentCartInsertModel1.fromJson(Map<String, dynamic> v) {
    return RentCartInsertModel1(v["Id"],v["RentProductId"], v["CartQty"], v["Size"], v["Price"],v["Deposit"], v["TotalPrice"], v["UserId"]);
  }
}
