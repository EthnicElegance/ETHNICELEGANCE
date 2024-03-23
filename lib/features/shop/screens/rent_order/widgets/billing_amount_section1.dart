import 'package:ethnic_elegance/features/shop/controllers/rent_checkout_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';

class EBillingAmountSection1 extends StatefulWidget {
  const EBillingAmountSection1({Key? key}) : super(key: key);

  @override
  State<EBillingAmountSection1> createState() => _EBillingAmountSection1State();
}

class _EBillingAmountSection1State extends State<EBillingAmountSection1> {
  final controller = Get.put(RentCheckoutController());

  late DatabaseReference _cartRef;
  double subtotal = 0;
  double subDeposit = 0;
  double subTax = 0;
  double totalPrice = 0;
  String? userId;
  late String getKeys;


  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userId = value;
      });
    });
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getKeys = prefs.getString('key')!;
    _cartRef = FirebaseDatabase.instance.ref().child('Project/RentalCart');

    try {
      DataSnapshot snapshot = await _cartRef.orderByChild('UserId').equalTo(getKeys).once().then((event) => event.snapshot);
      if (snapshot.value != null) {
        Map<dynamic, dynamic> cartData = snapshot.value as Map<dynamic, dynamic>;
        cartData.forEach((key, value) {
          double price = value['TotalPrice'] != null ? double.parse(value['TotalPrice'].toString()) : 0;
          double deposit = value['Deposit'] != null ? double.parse(value['Deposit'].toString()) : 0;
          setState(() {
            subtotal += price;
            subDeposit += deposit;
            controller.totalAmount = (subtotal + subDeposit).toStringAsFixed(2);
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
    final controller = Get.put(RentCheckoutController());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹${subtotal.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text('Shipping fee', style: Theme.of(context).textTheme.bodyMedium),
        //     Text('₹50', style: Theme.of(context).textTheme.labelLarge),
        //   ],
        // ),

        // const SizedBox(height: ESizes.spaceBtwItems / 2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Deposit', style: Theme.of(context).textTheme.bodyMedium),
            Text(controller.depositAmount = subDeposit.toStringAsFixed(2), style: Theme.of(context).textTheme.labelLarge),
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
