// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../sharepreferences.dart';
// import '../../../../../utils/constants/sizes.dart';
//
// class EOrderBillingAmountSection extends StatefulWidget {
//   const EOrderBillingAmountSection({Key? key, required this.orderId}) : super(key: key);
//   final String orderId;
//   @override
//   State<EOrderBillingAmountSection> createState() => _EOrderBillingAmountSectionState();
// }
//
// class _EOrderBillingAmountSectionState extends State<EOrderBillingAmountSection> {
//
//   late DatabaseReference _cartRef;
//
//   late String amount;
//   String? userId;
//   late String getKeys;
//
//   @override
//   void initState() {
//     super.initState();
//     getKey().then((String? value) {
//       setState(() {
//         userId = value;
//       });
//     });
//   }
//
//   Future<void> _initializeFirebase() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     getKeys = prefs.getString('key')!;
//     _cartRef = FirebaseDatabase.instance.ref().child('Project/Order/${widget.orderId}');
//     print("-----------------------getKeys----------------------");
//     print(getKeys);
//     try {
//       DataSnapshot snapshot = await _cartRef.once().then((event) => event.snapshot);
//       print("-----------------------snapshot----------------------");
//       print(snapshot);
//       if (snapshot.value != null) {
//         Map<dynamic, dynamic> cartData = snapshot.value as Map<dynamic, dynamic>;
//         print("-----------------------cartData----------------------");
//         print(cartData);
//           amount = cartData['TotalAmount'];
//           print("-----------------------subtotal----------------------");
//           print(amount);
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print('Error fetching cart data: $error');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _initializeFirebase();
//     return Column(
//       children: [
//         const SizedBox(height: ESizes.spaceBtwItems / 2),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
//             Text('₹$amount', style: Theme.of(context).textTheme.titleMedium),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';

class EOrderBillingAmountSection extends StatefulWidget {
  const EOrderBillingAmountSection({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  State<EOrderBillingAmountSection> createState() => _EOrderBillingAmountSectionState();
}

class _EOrderBillingAmountSectionState extends State<EOrderBillingAmountSection> {
  late DatabaseReference _cartRef;
  late String amount = ""; // Initialize amount to avoid LateInitializationError
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
    _cartRef = FirebaseDatabase.instance.ref().child('Project/Order/${widget.orderId}');
    try {
      DataSnapshot snapshot = await _cartRef.once().then((event) => event.snapshot);
      if (snapshot.value != null) {
        Map<dynamic, dynamic> cartData = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          amount = cartData['TotalAmount'];
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
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹$amount', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
