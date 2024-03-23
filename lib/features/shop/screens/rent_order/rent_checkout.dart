import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/features/shop/models/rent_cart_insert_model1.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order/widgets/billing_address_section1.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order/widgets/billing_amount_section1.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order/widgets/billing_payment_section1.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../rent_cart/rent_cart_items.dart';

class RentCheckOutScreen extends StatefulWidget {
  const RentCheckOutScreen({super.key});

  @override
  State<RentCheckOutScreen> createState() => _RentCheckOutScreenState();
}

class _RentCheckOutScreenState extends State<RentCheckOutScreen> {
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
                "Rental Order Review",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: const Center(
              child: Text(
                'Order is Empty',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        } else {
          // print(_googlePayConfigFuture);
          Map<dynamic, dynamic> cartData =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<RentCartInsertModel1> cartList = [];

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
            }
          });

          return Scaffold(
            appBar: EAppBar(
                showBackArrow: true,
                title: Text(
                  "Rental Order Review",
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
            body: SingleChildScrollView(
                child: Column(
              children: [
                const ERentCartItems(),
                const SizedBox(height: ESizes.spaceBtwSections),
                ERoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(ESizes.md),
                  backgroundColor: dark ? EColors.black : EColors.white,
                  child: const Column(
                    children: [
                      EBillingAmountSection1(),
                      SizedBox(height: ESizes.spaceBtwItems),
                      Divider(),
                      SizedBox(height: ESizes.spaceBtwItems),
                      EBillingAddressSection1(),
                      SizedBox(height: ESizes.spaceBtwItems),
                      EBillingPaymentSection1(),
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
