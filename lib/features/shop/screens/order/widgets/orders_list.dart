import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/features/shop/models/order_view_model.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/colors.dart';

class EOrderListItems extends StatefulWidget {
  const EOrderListItems({super.key});

  @override
  State<EOrderListItems> createState() => _EOrderListItemsState();
}

class _EOrderListItemsState extends State<EOrderListItems> {
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
    final dark = EHelperFunctions.isDarkMode(context);
    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child('Project/Order')
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
          } else if (!snapshot.hasData ||
              snapshot.data!.snapshot.value == null) {
            return const Center(
                child: Text(
                  'Cart is Empty',
                  style: TextStyle(fontSize: 16),
                ),
              );
          } else {
            // print(_googlePayConfigFuture);
            Map<dynamic, dynamic> orderData =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            List<OrderViewModel> orderList = [];

            orderData.forEach((key, value) {
              if (value != null) {
                orderList.add(OrderViewModel(
                  key.toString(),
                  value['UserId'],
                  value['OrderDate'],
                  value['ShippingDate'],
                  value['TotalAmount'],
                  value['UserAddress'],
                  value['Status'],
                ));
              }
            });

            return ListView.separated(
              shrinkWrap: true,
              itemCount: orderList.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: ESizes.spaceBtwItems),
              itemBuilder: (_, index) => ERoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(ESizes.md),
                  backgroundColor: dark ? EColors.dark : EColors.light,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.ship),
                          const SizedBox(width: ESizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderList[index].status,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: EColors.primary,
                                          fontWeightDelta: 1),
                                ),
                                Text(orderList[index].orderDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Iconsax.arrow_right_34,
                                  size: ESizes.iconSm))
                        ],
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Iconsax.tag),
                                const SizedBox(width: ESizes.spaceBtwItems / 2),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Order',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                      Text('#${orderList[index].key}',
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Iconsax.calendar),
                                const SizedBox(width: ESizes.spaceBtwItems / 2),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Shipping Date',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                      Text(orderList[index].shippingDate,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            );
          }
        });
  }
}
