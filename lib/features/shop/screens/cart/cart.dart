import 'package:ethnic_elegance/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/cart_insert_model1.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref()
          .child('Project/cart')
          .orderByChild('userId')
          .equalTo(userId)
          .onValue,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.black),
              strokeWidth: 1.5,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return Scaffold(
            appBar: EAppBar(
              showBackArrow: true,
              title: Text(
                "Cart",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: const Center(
              child: Text(
                'Cart is Empty',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        } else {
          Map<dynamic, dynamic> cartData =
          snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<CartModel1> cartList = [];

          cartData.forEach((key, value) {
            if (value != null) {
              cartList.add(CartModel1(
                key.toString(),
                value["productId"],
                value["cartQty"],
                value["size"],
                value["price"],
                value["totalPrice"],
                value["userId"],
              ));
            }
          });

          return Scaffold(
            appBar: EAppBar(
              showBackArrow: false,
              leadingIcon: Iconsax.arrow_left,
              leadingOnPressed: () => Get.offAll(() => const HomeScreen()),
              title: Text(
                "Cart",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: cartList.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: ESizes.spaceBtwSections),
                itemBuilder: (_, index) => Column(
                  children: [
                    ECartItem(id: cartList[index].productId, index: index),
                    const SizedBox(height: ESizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            EProductQuantityWithAddRemoveButton(
                              cartQty: cartList[index].cartQTY,
                              cartId: cartList[index].id, price: cartList[index].price,
                            ),
                          ],
                        ),
                        EProductPriceText(
                          price: "${
                            int.parse(cartList[index].price) *
                                int.parse(cartList[index].cartQTY)
                          }",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const CheckOutScreen());
                },
                child: const Text("Checkout"), // You can dynamically set total price here
              ),
            ),
          );
        }
      },
    );
  }
}
