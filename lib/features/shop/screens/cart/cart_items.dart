import 'package:ethnic_elegance/common/widgets/products/cart/add_remove_button.dart';
import 'package:ethnic_elegance/common/widgets/products/cart/cart_item.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/checkout_controller.dart';
import '../../models/cart/cart_insert_model1.dart';

class ECartItems extends StatefulWidget {
  const ECartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  State<ECartItems> createState() => _ECartItemsState();
}

class _ECartItemsState extends State<ECartItems> {
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
    final controller = Get.put(CheckoutController());
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
          List<String> cartIds = [];

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
              cartIds.add(key.toString());
            }
          });
          controller.cartId = cartIds;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: cartList.length,

                separatorBuilder: (_, __) =>
                    const SizedBox(height: ESizes.spaceBtwItems),
                itemBuilder: (_, index) => Column(
                      children: [
                        const SizedBox(width: 70),
                        ECartItem(id: cartList[index].productId, index: index),
                        if (widget.showAddRemoveButtons)
                          const SizedBox(height: ESizes.spaceBtwItems),
                        if (widget.showAddRemoveButtons)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  EProductQuantityWithAddRemoveButton(
                                    cartQty: cartList[index].cartQTY,
                                    cartId: cartList[index].id,
                                    price: cartList[index].price,
                                    plusMinusIcon: false,
                                  ),

                                  EProductPriceText(price: cartList[index].totalPrice),
                                ],
                              ),
                            ],
                          ),
                      ],
                    )),
          );
        }
      },
    );
  }
}
