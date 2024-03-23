import 'dart:async';

import 'package:ethnic_elegance/features/shop/controllers/coupon_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase database
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/checkout_controller.dart';

class EBillingAmountSection extends StatefulWidget {
  const EBillingAmountSection({Key? key}) : super(key: key);

  @override
  State<EBillingAmountSection> createState() => _EBillingAmountSectionState();
}

class _EBillingAmountSectionState extends State<EBillingAmountSection> {
  final controller = Get.put(CheckoutController());
  final controller1 = Get.put(CouponController());

  late DatabaseReference _cartRef;
  double subtotal = 0;
  double subTax = 0;
  double totalPrice = 0;
  late String couponDis;
  late double discount = 0;
  String? userId;
  late String getKeys;
  late Query dbRef;
  late Map data1;
  List<Map<String, dynamic>> couponList = [];

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userId = value;
      });
    });
    _initializeFirebase();
    getCouponListData(); // Call getCouponListData here
  }

  Future<void> getCouponListData() async {
    dbRef = FirebaseDatabase.instance.ref().child('Project/Coupon');
    DataSnapshot couponDataSnapshot = await dbRef.once().then((event) => event.snapshot);
    Map<dynamic, dynamic>? couponData = couponDataSnapshot.value as Map?;
    if (couponData != null) {
      couponData.forEach((key, value) {
        if(value["Coupon_name"] == controller1.couponName.text) {
          couponList.add({
            "Amount": value["Amount"],
            "Coupon_discount": value["Coupon_discount"],
            "Coupon_name": value["Coupon_name"],
          });
          // print(couponList);
          couponDis = value["Coupon_discount"];
          // print(couponDis);
        }
      });
    }
    updateTotalAmount();
  }
  void updateTotalAmount() {
    setState(() {
      double shippingFee = 50;
      subTax = subtotal * 0.18;
      controller.totalAmount =
          (subtotal - discount + shippingFee + subTax).toStringAsFixed(2);
    });
  }

  Future<void> _initializeFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getKeys = prefs.getString('key')!;
    _cartRef = FirebaseDatabase.instance.ref().child('Project/cart');

    try {
      DataSnapshot snapshot = await _cartRef.orderByChild('userId').equalTo(getKeys).once().then((event) => event.snapshot);
      if (snapshot.value != null) {
        Map<dynamic, dynamic> cartData = snapshot.value as Map<dynamic, dynamic>;
        cartData.forEach((key, value) {
          double price = value['totalPrice'] != null ? double.parse(value['totalPrice'].toString()) : 0;
          setState(() {
            subtotal += price;
            discount = subtotal * double.parse(couponDis)/100;
            subTax = subtotal * 0.18;
            discount == 0 ?
              controller.totalAmount = (subtotal + 50 + subTax).toStringAsFixed(2)
            :controller.totalAmount = (subtotal - discount + 50 + subTax).toStringAsFixed(2);


          }); // Update the widget after calculating subtotal
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching cart data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹${subtotal.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Coupon Discount', style: Theme.of(context).textTheme.bodyMedium),
            Text('-₹$discount', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹50', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee  18%', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹${subTax.toStringAsFixed(2)}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹${controller.totalAmount}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}