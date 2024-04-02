import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/features/shop/models/rent_order/rent_order_view_model.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order_detail/rent_order_detail.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/colors.dart';

class ERentOrderListItems extends StatefulWidget {
  const ERentOrderListItems({super.key});

  @override
  State<ERentOrderListItems> createState() => _ERentOrderListItemsState();
}

class _ERentOrderListItemsState extends State<ERentOrderListItems> {
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
            .child('Project/RentOrder')
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
                'No Order History',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            // print(_googlePayConfigFuture);
            Map<dynamic, dynamic> orderData =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            List<RentOrderViewModel> orderList = [];

            orderData.forEach((key, value) {
              if (value != null) {
                orderList.add(RentOrderViewModel(
                  key.toString(),
                  value['UserId'],
                  value['OrderDate'],
                  value['TotalAmount'],
                  value['DepositAmount'],
                  value['Status'],
                ));
              }
            });
            print(
                "----------------------orderList.length-----------------------");
            print(orderList.length);
            return ListView.separated(
                shrinkWrap: true,
                itemCount: orderList.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: ESizes.spaceBtwItems),
                itemBuilder: (_, index) {
                  print(
                      "----------------------orderList[index].key-----------------------");
                  print(orderList[index].key);
                  return ERoundedContainer(
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
                              Expanded(
                                child: Row(
                                  children: [
                                    const Icon(Iconsax.money_send),
                                    const SizedBox(
                                        width: ESizes.spaceBtwItems / 2),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          // Text('Return Date',
                                          Text('Rent Amount',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium),
                                          // Text(DateFormat('yyyy-MM-dd').format(date.add(const Duration(days: 4))),
                                          Text("${double.parse(orderList[index].totalAmount) - double.parse(orderList[index].depositAmount)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () => Get.to(() =>
                                      RentOrderDetailScreen(
                                          orderId: orderList[index].key,
                                          orderStatus:
                                              orderList[index].status)),
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
                                    const Icon(Iconsax.money_send),
                                    const SizedBox(
                                        width: ESizes.spaceBtwItems / 2),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text('Return Date',
                                          Text('Deposit Amount',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium),
                                          // Text(DateFormat('yyyy-MM-dd').format(date.add(const Duration(days: 4))),
                                          Text(orderList[index].depositAmount,
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
                                    const Icon(Iconsax.money_send),
                                    const SizedBox(
                                        width: ESizes.spaceBtwItems / 2),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text('Return Date',
                                          Text('Total Amount',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium),
                                          // Text(DateFormat('yyyy-MM-dd').format(date.add(const Duration(days: 4))),
                                          Text(orderList[index].totalAmount,
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
                      ));
                });
          }
        });
  }
}
