import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../cart/cart_items.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
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
}
