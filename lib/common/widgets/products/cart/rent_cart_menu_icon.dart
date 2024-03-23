import 'package:ethnic_elegance/features/shop/screens/rent_cart/rent_cart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';

class ERentCartCounterIcon extends StatefulWidget {
  const ERentCartCounterIcon({
    Key? key,
    required this.iconColor,
  }) : super(key: key);

  final Color iconColor;

  @override
  State<ERentCartCounterIcon> createState() => _ERentCartCounterIconState();
}

class _ERentCartCounterIconState extends State<ERentCartCounterIcon> {
  late Query _cartQuery; // Query for Firebase cart node
  String? userid;
  int cartItemCount = 0; // Total count of items in the cart

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
      _initializeFirebase(); // Call _initializeFirebase here
    });
  }

  void _initializeFirebase() {
    if (userid != null) {
      print(userid);
      DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('Project/RentalCart');
      _cartQuery = cartRef.orderByChild('UserId').equalTo(userid); // Apply the query
      _cartQuery.onValue.listen((event) {
        if (event.snapshot.exists) {
          // Count the number of items in the cart
          Map<dynamic, dynamic>? cartItems = event.snapshot.value as Map<dynamic, dynamic>?; // Explicitly cast the value
          try {
            if (cartItems != null) {
              setState(() {
                cartItemCount = cartItems.length;
              });
            } else {
              setState(() {
                cartItemCount = 0;
              });
            }
          } catch (e) {
            // Handle error appropriately (e.g., show error message)
            if (kDebugMode) {
              print('Error: $e');
            }
          }
        } else {
          // Handle when there are no items in the cart
          setState(() {
            cartItemCount = 0;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const RentCartScreen()),
          icon: Icon(Iconsax.shopping_bag, color: widget.iconColor),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: EColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                "$cartItemCount",
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  color: EColors.white,
                  fontSizeFactor: 0.8,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
