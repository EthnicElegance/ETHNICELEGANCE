import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/features/shop/screens/order_details/widgets/order_billing_address_section.dart';
import 'package:ethnic_elegance/features/shop/screens/order_details/widgets/order_billing_amount_section.dart';
import 'package:ethnic_elegance/features/shop/screens/order_details/widgets/order_items.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/popups/loaders.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.orderId, required this.orderStatus});

  final String orderId;
  final String orderStatus;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String? userId;
  bool isCancelButtonVisible = true;
  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userId = value;
      });
    });
  }

  Future<void> cancelOrder() async {
    DatabaseReference orderRef =
    FirebaseDatabase.instance.ref().child('Project/Order').child(widget.orderId);
    await orderRef.update({'Status': 'Cancel'});
    ELoaders.successSnackBar(
        title: 'Order canceled',
        message: 'Order canceled successfully!');
    setState(() {
      isCancelButtonVisible = false;
    });
    // Perform any other actions after canceling the order if needed
    Get.to(() => OrderDetailScreen(orderId: widget.orderId, orderStatus: widget.orderStatus));
  }

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: EAppBar(
          showBackArrow: true,
          title: Text(
            "Order History",
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          EOrderItems(orderId: widget.orderId),
          const SizedBox(height: ESizes.spaceBtwSections),
          ERoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(ESizes.md),
            backgroundColor: dark ? EColors.black : EColors.white,
            child: Column(
              children: [
                EOrderBillingAmountSection(orderId: widget.orderId),
                const SizedBox(height: ESizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: ESizes.spaceBtwItems),
                EOrderBillingAddressSection(orderId: widget.orderId),
              ],
            ),
          ),
          const SizedBox(height: ESizes.spaceBtwSections),
          if(widget.orderStatus == "Pending" && isCancelButtonVisible)
          SizedBox(
            width: ESizes.buttonWidth,
            child: OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                    side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: EColors.primary))),
                onPressed: () async {
                  await cancelOrder();
                },
                child: const Text('Cancel')),
          ),
          const SizedBox(height: ESizes.spaceBtwSections * 2.5),
        ],
      )),
    );
  }
}
