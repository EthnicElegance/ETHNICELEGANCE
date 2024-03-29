import 'package:ethnic_elegance/features/shop/screens/cart/cart.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/checkout.dart';
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
    if (int.parse(value) < 50) {
      counter.value = value;

      // Calculate total price based on quantity and price per item
      double totalPriceValue = int.parse(value) * double.parse(price);
      // double totalDepositValue = totalPriceValue * 3;
      totalPrice.value = totalPriceValue;

      // Update quantity, total price, and price per item in Firebase
      FirebaseDatabase.instance.ref().child("Project/cart/$cartId").update({
        'cartQty': value,
        'totalPrice': totalPriceValue.toString(),
        'price': price,
      });
    } else {
      counter.value = "50";

      // Calculate total price based on quantity and price per item
      double totalPriceValue = int.parse("50") * double.parse(price);
      // double totalDepositValue = totalPriceValue * 3;
      totalPrice.value = totalPriceValue;

      // Update quantity, total price, and price per item in Firebase
      FirebaseDatabase.instance.ref().child("Project/cart/$cartId").update({
        'cartQty': "50",
        'totalPrice': totalPriceValue.toString(),
        'price': price,
      });
    }
  }

  void increment(String quantityController,String cartId, String price) {
    counter.value = quantityController;
    if (int.parse(counter.value) < 50) {
      counter.value = (int.parse(counter.value) + 1).toString();
      updateQuantity(counter.value, cartId, price);
    }
  }

  void decrement(String quantityController,String cartId, String price) {
    counter.value = quantityController;
    if (int.parse(counter.value) > 1) {
      counter.value = (int.parse(counter.value) - 1).toString();
      updateQuantity(counter.value, cartId, price);
    }
  }
}

class EProductQuantityWithAddRemoveButton extends StatefulWidget {
  const EProductQuantityWithAddRemoveButton({
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
  State<EProductQuantityWithAddRemoveButton> createState() =>
      _EProductQuantityWithAddRemoveButtonState();
}

class _EProductQuantityWithAddRemoveButtonState
    extends State<EProductQuantityWithAddRemoveButton> {
  final CartController1 controller = Get.put(CartController1());
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
      _quantityController.text = widget.cartQty;
      controller.counter.value = _quantityController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            // Delete item from the cart in Firebase
            if(widget.plusMinusIcon) {
              FirebaseDatabase.instance
                .ref()
                .child("Project/cart/${widget.cartId}")
                .remove()
                .then((_) => {
                        Navigator.pop(context),
                        Get.to(() => const CartScreen())
                      })
                .catchError((error) => ELoaders.errorSnackBar(
                    title: 'Failed to remove',
                    message: 'Failed to remove item: $error'));
            }else if(!widget.plusMinusIcon) {
              FirebaseDatabase.instance
                  .ref()
                  .child("Project/cart/${widget.cartId}")
                  .remove()
                  .then((_) => {Navigator.pop(context),Get.to(() => const CheckOutScreen())})
                  .catchError((error) => ELoaders.errorSnackBar(
                  title: 'Failed to remove',
                  message: 'Failed to remove item: $error'));
              Get.to(() => const CheckOutScreen());
            }
          },
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),
        if (widget.plusMinusIcon)
          ECircularIcon(
            onPressed: () {
              controller.decrement(_quantityController.text,widget.cartId, widget.price);
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
        if (widget.plusMinusIcon)
          SizedBox(
            width: 40,
            child: TextFormField(
              controller: _quantityController,
              onChanged: (value) {
                if (int.parse(value) <= 50) {
                  setState(() {
                    _quantityController.text = value;
                    controller.counter.value = value;
                  });
                  controller.updateQuantity(value, widget.cartId, widget.price);
                } else {
                  setState(() {
                    _quantityController.text = "50";
                    controller.counter.value = "50";
                  });
                  controller.updateQuantity("50", widget.cartId, widget.price);
                }
                if (int.parse(value) <= 0) {
                  setState(() {
                    _quantityController.text = "1";
                    controller.counter.value = "1";
                  });
                  controller.updateQuantity("1", widget.cartId, widget.price);
                }
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
        if (!widget.plusMinusIcon)
          SizedBox(
            width: 40,
            child: TextFormField(
              enabled: false,
              controller: _quantityController,
              onChanged: (value) {
                controller.updateQuantity(value, widget.cartId, widget.price);
                _quantityController.text = controller.counter.value;
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
        if (widget.plusMinusIcon)
          ECircularIcon(
            onPressed: () {
              controller.increment(_quantityController.text,widget.cartId, widget.price);
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
