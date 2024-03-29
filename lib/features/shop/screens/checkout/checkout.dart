import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/cart/cart_insert_model1.dart';
import '../cart/cart_items.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
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
                "Checkout",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: const Center(
              child: Text(
                'Checkout is Empty',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        } else {
          // print(_googlePayConfigFuture);
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
                showBackArrow: true,
                title: Text(
                  "Order Review",
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
            body: SingleChildScrollView(
                child: Column(
              children: [
                const ECartItems(),
                // const SizedBox(height: ESizes.spaceBtwSections),
                const ECouponCode(),
                const SizedBox(height: ESizes.spaceBtwSections),
                ERoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(ESizes.md),
                  backgroundColor: dark ? EColors.black : EColors.white,
                  child: const Column(
                    children: [
                      EBillingAmountSection(),
                      SizedBox(height: ESizes.spaceBtwItems),
                      Divider(),
                      SizedBox(height: ESizes.spaceBtwItems),
                      EBillingAddressSection(),
                      SizedBox(height: ESizes.spaceBtwItems),
                      EBillingPaymentSection(),
                    ],
                  ),
                )
              ],
            )),
          );
        }
      },
    );
  }
}
