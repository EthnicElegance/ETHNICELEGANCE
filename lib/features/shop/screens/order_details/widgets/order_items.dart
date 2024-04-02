import 'package:ethnic_elegance/common/widgets/order/order_item.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:ethnic_elegance/features/shop/models/order_detail/order_detail_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/checkout_controller.dart';

class EOrderItems extends StatefulWidget {

  const EOrderItems({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  State<EOrderItems> createState() => _EOrderItemsState();

}

class _EOrderItemsState extends State<EOrderItems> {
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
          .child('Project/OrderDetail')
          .orderByChild('OrderId')
          .equalTo(widget.orderId)
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
                "Order Detail",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: const Center(
              child: Text(
                'Order Detail is Empty',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        } else {
          Map<dynamic, dynamic> orderDetailData =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<OrderDetailModel> orderDetailList = [];
          List<String> cartIds = [];

          orderDetailData.forEach((key, value) {
            if (value != null) {
              orderDetailList.add(OrderDetailModel(
                key.toString(),
                value["OrderId"],
                value["ProductId"],
                value["Qty"],
                value["Size"],
                value["Price"],
                value["TotalPrice"],
              ));
              cartIds.add(key.toString());
            }
          });
          controller.cartId = cartIds;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: orderDetailList.length,
                physics: const NeverScrollableScrollPhysics(), //
                separatorBuilder: (_, __) => const SizedBox(height: ESizes.spaceBtwItems),
                itemBuilder: (_, index) {
                      return Column(
                        children: [
                          const SizedBox(width: 70),
                          EOrderItem(
                            id: orderDetailList[index].productId,
                            index: index,
                            orderId: widget.orderId,
                          ),
                            const SizedBox(height: ESizes.spaceBtwItems),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      width: 40,
                                      child: TextFormField(
                                        initialValue: orderDetailList[index].qty.toString(),
                                        enabled: false,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 12.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // EProductQuantityWithAddRemoveButton(
                                    //   cartQty: orderDetailList[index].qty,
                                    //   cartId: orderDetailList[index].id,
                                    //   price: orderDetailList[index].price,
                                    //   plusMinusIcon: false,
                                    // ),
                                    const SizedBox(width: 30),

                                    EProductPriceText(
                                        price:
                                            orderDetailList[index].totalPrice),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      );
                    }),
          );
        }
      },
    );
  }
}
