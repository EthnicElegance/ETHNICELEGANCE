import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order_detail/widgets/rent_order_detail_cart_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/rent_checkout_controller.dart';
import '../../../models/rent_order/rent_order_detail_view_model.dart';

class RentOrderDetailERentCartItems extends StatefulWidget {
  const RentOrderDetailERentCartItems({
    super.key,
    this.showAddRemoveButtons = true, required this.orderId,
  });
  final String orderId;
  final bool showAddRemoveButtons;

  @override
  State<RentOrderDetailERentCartItems> createState() => _RentOrderDetailERentCartItemsState();
}

class _RentOrderDetailERentCartItemsState extends State<RentOrderDetailERentCartItems> {
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
          .child('Project/RentOrderDetail')
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
          return const Center(
              child: Text(
                'Rental Cart is Empty',
                style: TextStyle(fontSize: 16),
              ),
          );
        } else {
          Map<dynamic, dynamic> cartData =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<RentOrderDetailViewModel> rentOrderDetailList = [];
          List<String> cartIds = [];
          cartData.forEach((key, value) {
            if (value != null) {
              rentOrderDetailList.add(RentOrderDetailViewModel(
                key.toString(),
                value["OrderId"],
                value["RentProductId"],
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
                itemCount: rentOrderDetailList.length,

                separatorBuilder: (_, __) =>
                    const SizedBox(height: ESizes.spaceBtwItems),
                itemBuilder: (_, index) => Column(
                      children: [
                        const SizedBox(width: 70),
                        RentOrderDetailERentCartItem(id: rentOrderDetailList[index].rentProductId, index: index, orderId: widget.orderId,),
                        if (widget.showAddRemoveButtons)
                          const SizedBox(height: ESizes.spaceBtwItems),
                        if (widget.showAddRemoveButtons)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 40,
                                    child: TextFormField(
                                      initialValue: rentOrderDetailList[index].qty.toString(),
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
                                  // ERentProductQuantityWithAddRemoveButton(
                                  //   cartQty: cartList[index].qty,
                                  //   cartId: cartList[index].id,
                                  //   price: cartList[index].price,
                                  //   plusMinusIcon: false,
                                  // ),
                                  const SizedBox(width: ESizes.spaceBtwItems),

                                  EProductPriceText(price: rentOrderDetailList[index].totalPrice),
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
