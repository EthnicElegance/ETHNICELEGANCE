import 'dart:core';

class CouponModel {
  late String key;
  late String amount;
  late String coupondiscount;
  late String couponname;
  late String expiredate;
  late String photo;


  CouponModel(
      this.key,
      this.amount,
      this.coupondiscount,
      this.couponname,
      this.expiredate,
      this.photo,
      );

  factory CouponModel.fromJson(Map<String, dynamic> document) {
    return CouponModel(
        document["key"],
        document["Amount"],
        document["CouponDiscount"],
        document["CouponName"],
        document["ExpireDate"],
        document["Photo"],
        );
  }
}
