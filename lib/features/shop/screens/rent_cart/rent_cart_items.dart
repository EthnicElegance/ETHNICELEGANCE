import 'package:ethnic_elegance/common/widgets/products/cart/rent_add_remove_button.dart';
import 'package:ethnic_elegance/common/widgets/products/cart/rent_cart_item.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/rent_checkout_controller.dart';
import '../../models/rent_cart_insert_model1.dart';

class ERentCartItems extends StatefulWidget {
  const ERentCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  State<ERentCartItems> createState() => _ERentCartItemsState();
}

class _ERentCartItemsState extends State<ERentCartItems> {
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
    final controller = Get.put(RentCheckoutController());
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref()
          .child('Project/RentalCart')
          .orderByChild('UserId')
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
                "Rental Cart",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: const Center(
              child: Text(
                'Rental Cart is Empty',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        } else {
          Map<dynamic, dynamic> cartData =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<RentCartInsertModel1> cartList = [];
          List<String> cartIds = [];

          cartData.forEach((key, value) {
            if (value != null) {
              cartList.add(RentCartInsertModel1(
                key.toString(),
                value["RentProductId"],
                value["CartQty"],
                value["Size"],
                value["Price"],
                value["Deposit"],
                value["TotalPrice"],
                value["UserId"],
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
                        ERentCartItem(id: cartList[index].rentProductId, index: index),
                        if (widget.showAddRemoveButtons)
                          const SizedBox(height: ESizes.spaceBtwItems),
                        if (widget.showAddRemoveButtons)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  ERentProductQuantityWithAddRemoveButton(
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
