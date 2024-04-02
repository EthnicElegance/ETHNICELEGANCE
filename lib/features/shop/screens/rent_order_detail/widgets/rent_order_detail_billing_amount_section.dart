import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';

class RentOrderDetailEBillingAmountSection extends StatefulWidget {
  const RentOrderDetailEBillingAmountSection({Key? key, required this.orderId}) : super(key: key);
  final String orderId;
  @override
  State<RentOrderDetailEBillingAmountSection> createState() => _RentOrderDetailEBillingAmountSectionState();
}

class _RentOrderDetailEBillingAmountSectionState extends State<RentOrderDetailEBillingAmountSection> {

  late DatabaseReference _cartRef;
  late String amount = ""; // Initialize amount to avoid LateInitializationError
  late String deposit = ""; // Initialize amount to avoid LateInitializationError
  late String rent = ""; // Initialize amount to avoid LateInitializationError
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
    _cartRef = FirebaseDatabase.instance.ref().child('Project/RentOrder/${widget.orderId}');
    try {
      DataSnapshot snapshot = await _cartRef.once().then((event) => event.snapshot);
      if (snapshot.value != null) {
        Map<dynamic, dynamic> cartData = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          amount = cartData['TotalAmount'];
          deposit = cartData['DepositAmount'];
          rent = "${double.parse(cartData['TotalAmount']) - double.parse(cartData['DepositAmount'])}";
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
        const SizedBox(height: ESizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Rent Amount', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹$rent', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Deposit Amount', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹$deposit', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹$amount', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
