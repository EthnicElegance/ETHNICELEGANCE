// import 'package:ethnic_elegance/features/shop/screens/cart/cart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../../sharepreferences.dart';
// import '../../../../utils/constants/colors.dart';
//
// class ECartCounterIcon extends StatefulWidget {
//   const ECartCounterIcon({
//     super.key, required this.iconColor,
//   });
//   final Color iconColor;
//
//   @override
//   State<ECartCounterIcon> createState() => _ECartCounterIconState();
// }
//
// class _ECartCounterIconState extends State<ECartCounterIcon> {
//   String? userid;
//
//   @override
//   void initState() {
//     super.initState();
//     getKey().then((String? value) {
//       setState(() {
//         userid = value;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         IconButton(onPressed: () => Get.to(() => const CartScreen()), icon: Icon(Iconsax.shopping_bag, color: widget.iconColor,)),
//         Positioned(
//           right: 0,
//           child: Container(
//             width: 18,
//             height: 18,
//             decoration: BoxDecoration(
//                 color: EColors.black,
//                 borderRadius: BorderRadius.circular(100)
//             ),
//             child: Center(
//               child: Text("0",style: Theme.of(context).textTheme.labelLarge!.apply(color: EColors.white, fontSizeFactor: 0.8)),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// import 'package:ethnic_elegance/features/shop/screens/cart/cart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:firebase_database/firebase_database.dart'; // Import Firebase database
// import '../../../../sharepreferences.dart';
// import '../../../../utils/constants/colors.dart';
//
// class ECartCounterIcon extends StatefulWidget {
//   const ECartCounterIcon({
//     super.key,
//     required this.iconColor,
//   });
//   final Color iconColor;
//
//   @override
//   State<ECartCounterIcon> createState() => _ECartCounterIconState();
// }
//
// class _ECartCounterIconState extends State<ECartCounterIcon> {
//   late DatabaseReference _cartRef; // Reference to Firebase cart node
//   String? userid;
//   int cartItemCount = 0; // Total count of items in the cart
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeFirebase();
//     getKey().then((String? value) {
//       setState(() {
//         userid = value;
//       });
//     });
//   }
//
//   void _initializeFirebase() {
//     _cartRef = FirebaseDatabase.instance.ref().child('Project/cart').orderByChild('userId').equalTo(userid);
//     _cartRef.onValue.listen((event) {
//       if (event.snapshot.exists) {
//         // Count the number of items in the cart
//         Map<dynamic, dynamic>? cartItems = event.snapshot.value as Map<dynamic, dynamic>?; // Explicitly cast the value
//         if (cartItems != null) {
//           setState(() {
//             cartItemCount = cartItems.length;
//           });
//         } else {
//           setState(() {
//             cartItemCount = 0;
//           });
//         }
//       } else {
//         // Handle when there are no items in the cart
//         setState(() {
//           cartItemCount = 0;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         IconButton(
//           onPressed: () => Get.to(() => const CartScreen()),
//           icon: Icon(Iconsax.shopping_bag, color: widget.iconColor),
//         ),
//         Positioned(
//           right: 0,
//           child: Container(
//             width: 18,
//             height: 18,
//             decoration: BoxDecoration(
//               color: EColors.black,
//               borderRadius: BorderRadius.circular(100),
//             ),
//             child: Center(
//               child: Text(
//                 "$cartItemCount",
//                 style: Theme.of(context).textTheme.labelLarge!.apply(
//                   color: EColors.white,
//                   fontSizeFactor: 0.8,
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// import 'package:ethnic_elegance/features/shop/screens/cart/cart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:firebase_database/firebase_database.dart'; // Import Firebase database
// import '../../../../sharepreferences.dart';
// import '../../../../utils/constants/colors.dart';
//
// class ECartCounterIcon extends StatefulWidget {
//   const ECartCounterIcon({
//     Key? key,
//     required this.iconColor,
//   }) : super(key: key);
//
//   final Color iconColor;
//
//   @override
//   State<ECartCounterIcon> createState() => _ECartCounterIconState();
// }
//
// class _ECartCounterIconState extends State<ECartCounterIcon> {
//   late Query _cartQuery; // Query for Firebase cart node
//   String? userid;
//   int cartItemCount = 0; // Total count of items in the cart
//
//   @override
//   void initState() {
//     super.initState();
//     getKey().then((String? value) {
//       setState(() {
//         userid = value;
//       });
//     });
//     _initializeFirebase();
//
//   }
//
//   void _initializeFirebase() {
//     DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('Project/cart');
//     _cartQuery = cartRef.orderByChild('userId').equalTo(userid); // Apply the query
//     _cartQuery.onValue.listen((event) {
//       if (event.snapshot.exists) {
//         // Count the number of items in the cart
//         Map<dynamic, dynamic>? cartItems = event.snapshot.value as Map<dynamic, dynamic>?; // Explicitly cast the value
//         try {
//           if (cartItems != null) {
//             setState(() {
//               cartItemCount = cartItems.length;
//             });
//           } else {
//             setState(() {
//               cartItemCount = 0;
//             });
//           }
//         }catch (e) {
//           // Handle error appropriately (e.g., show error message)
//           print('Error: $e');
//         }
//       } else {
//         // Handle when there are no items in the cart
//         setState(() {
//           cartItemCount = 0;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _initializeFirebase();
//
//     return Stack(
//       children: [
//         IconButton(
//           onPressed: () => Get.to(() => const CartScreen()),
//           icon: Icon(Iconsax.shopping_bag, color: widget.iconColor),
//         ),
//         Positioned(
//           right: 0,
//           child: Container(
//             width: 18,
//             height: 18,
//             decoration: BoxDecoration(
//               color: EColors.black,
//               borderRadius: BorderRadius.circular(100),
//             ),
//             child: Center(
//               child: Text(
//                 "$cartItemCount",
//                 style: Theme.of(context).textTheme.labelLarge!.apply(
//                   color: EColors.white,
//                   fontSizeFactor: 0.8,
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:ethnic_elegance/features/shop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';

class ECartCounterIcon extends StatefulWidget {
  const ECartCounterIcon({
    Key? key,
    required this.iconColor,
  }) : super(key: key);

  final Color iconColor;

  @override
  State<ECartCounterIcon> createState() => _ECartCounterIconState();
}

class _ECartCounterIconState extends State<ECartCounterIcon> {
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
      DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('Project/cart');
      _cartQuery = cartRef.orderByChild('userId').equalTo(userid); // Apply the query
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
            print('Error: $e');
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
          onPressed: () => Get.to(() => const CartScreen()),
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
