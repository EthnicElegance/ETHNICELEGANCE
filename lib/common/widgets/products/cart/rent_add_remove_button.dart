// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../../../utils/helpers/helper_functions.dart';
// import '../../../../utils/popups/loaders.dart';
// import '../../icons/circular_icon.dart';
//
// class CartController1 extends GetxController {
//   final RxString counter = RxString('0');
//   final RxDouble totalPrice = RxDouble(0.0); // Add total price variable
//
//   void updateQuantity(String value, String cartId) {
//     counter.value = value;
//
//     // Calculate total price based on quantity (for example, $10 per item)
//     double pricePerItem = 10.0; // You can adjust this according to your pricing logic
//     double totalPriceValue = int.parse(value) * pricePerItem;
//     totalPrice.value = totalPriceValue;
//
//     // Update quantity and total price in Firebase
//     FirebaseDatabase.instance
//         .ref()
//         .child("Project/cart/$cartId")
//         .update({'cartQty': value, 'totalPrice': totalPriceValue.toString()})
//         .then((_) => ELoaders.successSnackBar(
//         title: 'Quantity Updated',
//         message: 'Quantity and price updated successfully'))
//         .catchError((error) => ELoaders.errorSnackBar(
//         title: 'Failed to update',
//         message: 'Failed to update quantity and price: $error'));
//   }
//
//   void increment(String cartId) {
//     counter.value = (int.parse(counter.value) + 1).toString();
//     // Increment quantity and update total price
//     updateQuantity(counter.value, cartId);
//   }
//
//   void decrement(String cartId) {
//     if (int.parse(counter.value) > 0) {
//       counter.value = (int.parse(counter.value) - 1).toString();
//       // Decrement quantity and update total price
//       updateQuantity(counter.value, cartId);
//     }
//   }
// }
//
// class ERentProductQuantityWithAddRemoveButton extends StatefulWidget {
//   const ERentProductQuantityWithAddRemoveButton(
//       {Key? key, required this.cartQty, required this.cartId})
//       : super(key: key);
//
//   final String cartId;
//   final cartQty;
//
//   @override
//   State<ERentProductQuantityWithAddRemoveButton> createState() =>
//       _ERentProductQuantityWithAddRemoveButtonState();
// }
//
// class _ERentProductQuantityWithAddRemoveButtonState
//     extends State<ERentProductQuantityWithAddRemoveButton> {
//   final CartController1 controller = Get.put(CartController1());
//   final TextEditingController _quantityController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.cartQty != null) {
//       _quantityController.text = widget.cartQty;
//       controller.counter.value = widget.cartQty;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.cartQty == null) {
//       return const Center(
//         child: CircularProgressIndicator(
//           backgroundColor: Colors.grey,
//           valueColor: AlwaysStoppedAnimation(Colors.black),
//           strokeWidth: 1.5,
//         ),
//       );
//     }
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ECircularIcon(
//           onPressed: () {
//             controller.decrement(widget.cartId);
//             _quantityController.text = controller.counter.value;
//           },
//           icon: Iconsax.minus,
//           width: 32,
//           height: 32,
//           size: ESizes.md,
//           color: EHelperFunctions.isDarkMode(context)
//               ? EColors.white
//               : EColors.black,
//           backgroundColor: EHelperFunctions.isDarkMode(context)
//               ? EColors.darkerGrey
//               : EColors.light,
//         ),
//         const SizedBox(width: ESizes.spaceBtwItems),
//         SizedBox(
//           width: 40,
//           child: TextFormField(
//             controller: _quantityController,
//             onChanged: (value) {
//               controller.updateQuantity(value, widget.cartId);
//             },
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               contentPadding:
//               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: ESizes.spaceBtwItems),
//         ECircularIcon(
//           onPressed: () {
//             controller.increment(widget.cartId);
//             _quantityController.text = controller.counter.value;
//           },
//           icon: Iconsax.add,
//           width: 32,
//           height: 32,
//           size: ESizes.md,
//           color: EColors.white,
//           backgroundColor: EColors.primary,
//         ),
//         const SizedBox(width: ESizes.spaceBtwItems),
//         IconButton(
//           onPressed: () {
//             // Delete item from the cart in Firebase
//             FirebaseDatabase.instance
//                 .ref()
//                 .child("Project/cart/${widget.cartId}")
//                 .remove()
//                 .then((_) => ELoaders.successSnackBar(
//                 title: 'Item Removed',
//                 message: 'Item removed from cart'))
//                 .catchError((error) => ELoaders.errorSnackBar(
//                 title: 'Failed to remove',
//                 message: 'Failed to remove item: $error'));
//           },
//           icon: const Icon(Icons.delete),
//           color: Colors.red,
//         ),
//       ],
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:iconsax/iconsax.dart';
// // import 'package:firebase_database/firebase_database.dart';
// //
// // import '../../../../utils/constants/colors.dart';
// // import '../../../../utils/constants/sizes.dart';
// // import '../../../../utils/helpers/helper_functions.dart';
// // import '../../../../utils/popups/loaders.dart';
// // import '../../icons/circular_icon.dart';
// //
// // class CartController1 extends GetxController {
// //   final RxString counter = RxString('0');
// //   final RxDouble totalPrice = RxDouble(0.0);
// //
// //   void updateQuantity(String value, String cartId) {
// //     counter.value = value;
// //
// //     double pricePerItem = 10.0; // Price per item (adjust as needed)
// //     double totalPriceValue = int.parse(value) * pricePerItem;
// //     totalPrice.value = totalPriceValue;
// //
// //     // Update quantity and total price in Firebase
// //     FirebaseDatabase.instance
// //         .ref()
// //         .child("Project/cart/$cartId")
// //         .update({
// //       'cartQty': value,
// //       'totalPrice': totalPriceValue.toString(),
// //     }).then((_) => ELoaders.successSnackBar(
// //         title: 'Quantity Updated',
// //         message: 'Quantity and price updated successfully'))
// //         .catchError((error) => ELoaders.errorSnackBar(
// //         title: 'Failed to update',
// //         message: 'Failed to update quantity and price: $error'));
// //   }
// //
// //   void increment(String cartId) {
// //     counter.value = (int.parse(counter.value) + 1).toString();
// //     updateQuantity(counter.value, cartId);
// //   }
// //
// //   void decrement(String cartId) {
// //     if (int.parse(counter.value) > 0) {
// //       counter.value = (int.parse(counter.value) - 1).toString();
// //       updateQuantity(counter.value, cartId);
// //     }
// //   }
// // }
// //
// // class ERentProductQuantityWithAddRemoveButton extends StatefulWidget {
// //   const ERentProductQuantityWithAddRemoveButton({
// //     Key? key,
// //     required this.cartId,
// //     required this.cartQty,
// //   }) : super(key: key);
// //
// //   final String cartId;
// //   final String cartQty;
// //
// //   @override
// //   State<ERentProductQuantityWithAddRemoveButton> createState() =>
// //       _ERentProductQuantityWithAddRemoveButtonState();
// // }
// //
// // class _ERentProductQuantityWithAddRemoveButtonState
// //     extends State<ERentProductQuantityWithAddRemoveButton> {
// //   final CartController1 controller = Get.put(CartController1());
// //   final TextEditingController _quantityController = TextEditingController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _quantityController.text = widget.cartQty;
// //     controller.counter.value = widget.cartQty;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         ECircularIcon(
// //           onPressed: () {
// //             controller.decrement(widget.cartId);
// //             _quantityController.text = controller.counter.value;
// //           },
// //           icon: Iconsax.minus,
// //           width: 32,
// //           height: 32,
// //           size: ESizes.md,
// //           color: EHelperFunctions.isDarkMode(context)
// //               ? EColors.white
// //               : EColors.black,
// //           backgroundColor: EHelperFunctions.isDarkMode(context)
// //               ? EColors.darkerGrey
// //               : EColors.light,
// //         ),
// //         const SizedBox(width: ESizes.spaceBtwItems),
// //         SizedBox(
// //           width: 40,
// //           child: TextFormField(
// //             controller: _quantityController,
// //             onChanged: (value) {
// //               controller.updateQuantity(value, widget.cartId);
// //             },
// //             keyboardType: TextInputType.number,
// //             decoration: InputDecoration(
// //               contentPadding:
// //               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(8.0),
// //               ),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(width: ESizes.spaceBtwItems),
// //         ECircularIcon(
// //           onPressed: () {
// //             controller.increment(widget.cartId);
// //             _quantityController.text = controller.counter.value;
// //           },
// //           icon: Iconsax.add,
// //           width: 32,
// //           height: 32,
// //           size: ESizes.md,
// //           color: EColors.white,
// //           backgroundColor: EColors.primary,
// //         ),
//         const SizedBox(width: ESizes.spaceBtwItems),
//         IconButton(
//           onPressed: () {
//             // Delete item from the cart in Firebase
//             FirebaseDatabase.instance
//                 .ref()
//                 .child("Project/cart/${widget.cartId}")
//                 .remove()
//                 .then((_) => ELoaders.successSnackBar(
//                 title: 'Item Removed',
//                 message: 'Item removed from cart'))
//                 .catchError((error) => ELoaders.errorSnackBar(
//                 title: 'Failed to remove',
//                 message: 'Failed to remove item: $error'));
//           },
//           icon: const Icon(Icons.delete),
//           color: Colors.red,
//         ),
// //       ],
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/loaders.dart';
import '../../icons/circular_icon.dart';

class CartController1 extends GetxController {
  final RxString counter = RxString('0');
  final RxDouble totalPrice = RxDouble(0.0);

  void updateQuantity(String value, String cartId, String price) {
    counter.value = value;

    // Calculate total price based on quantity and price per item
    double totalPriceValue = int.parse(value) * double.parse(price);
    double totalDepositValue = totalPriceValue * 3;
    totalPrice.value = totalPriceValue;

    // Update quantity, total price, and price per item in Firebase
    FirebaseDatabase.instance
        .ref()
        .child("Project/RentalCart/$cartId")
        .update({
      'CartQty': value,
      'TotalPrice': totalPriceValue.toString(),
      'Price': price,
      'Deposit': totalDepositValue.toString(),
    });
  }

  void increment(String cartId, String price) {
    counter.value = (int.parse(counter.value) + 1).toString();
    updateQuantity(counter.value, cartId, price);
  }

  void decrement(String cartId, String price) {
    if (int.parse(counter.value) > 0) {
      counter.value = (int.parse(counter.value) - 1).toString();
      updateQuantity(counter.value, cartId, price);
    }
  }
}

class ERentProductQuantityWithAddRemoveButton extends StatefulWidget {
  const ERentProductQuantityWithAddRemoveButton({
    Key? key,
    required this.cartId,
    required this.cartQty,
    required this.price,
    this.plusMinusIcon = true,
  }) : super(key: key);

  final String cartId;
  final String cartQty;
  final String price;
  final bool plusMinusIcon;

  @override
  State<ERentProductQuantityWithAddRemoveButton> createState() =>
      _ERentProductQuantityWithAddRemoveButtonState();
}

class _ERentProductQuantityWithAddRemoveButtonState
    extends State<ERentProductQuantityWithAddRemoveButton> {
  final CartController1 controller = Get.put(CartController1());
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _quantityController.text = widget.cartQty;
    controller.counter.value = widget.cartQty;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            // Delete item from the cart in Firebase
            FirebaseDatabase.instance
                .ref()
                .child("Project/RentalCart/${widget.cartId}")
                .remove()
                .then((_) => ELoaders.successSnackBar(
                title: 'Item Removed',
                message: 'Item removed from Rent cart'))
                .catchError((error) => ELoaders.errorSnackBar(
                title: 'Failed to remove',
                message: 'Failed to remove item: $error'));
          },
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),
        if(widget.plusMinusIcon)
          ECircularIcon(
          onPressed: () {
            controller.decrement(widget.cartId, widget.price);
            _quantityController.text = controller.counter.value;
          },
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ESizes.md,
          color: EHelperFunctions.isDarkMode(context)
              ? EColors.white
              : EColors.black,
          backgroundColor: EHelperFunctions.isDarkMode(context)
              ? EColors.darkerGrey
              : EColors.light,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),
        if(widget.plusMinusIcon)
          SizedBox(
          width: 40,
          child: TextFormField(
            controller: _quantityController,
            onChanged: (value) {
              controller.updateQuantity(value, widget.cartId, widget.price);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        if(!widget.plusMinusIcon)
          SizedBox(
            width: 40,
            child: TextFormField(
              enabled: false,
              controller: _quantityController,
              onChanged: (value) {
                controller.updateQuantity(value, widget.cartId, widget.price);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        
        const SizedBox(width: ESizes.spaceBtwItems),
        if(widget.plusMinusIcon)
        ECircularIcon(
          onPressed: () {
            controller.increment(widget.cartId, widget.price);
            _quantityController.text = controller.counter.value;
          },
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ESizes.md,
          color: EColors.white,
          backgroundColor: EColors.primary,
        ),
      ],
    );
  }
}
