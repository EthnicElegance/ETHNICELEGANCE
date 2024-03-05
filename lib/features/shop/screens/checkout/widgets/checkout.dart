import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/common/widgets/success_screen/success_screen.dart';

import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/coupon_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../cart/cart_items.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

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
            const ECartItems(showAddRemoveButtons: false),
            const SizedBox(height: ESizes.spaceBtwSections),
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
                  EBillingPaymentSection(),
                  SizedBox(height: ESizes.spaceBtwItems),
                  EBillingAddressSection(),
                ],
              ),
            )
          ],
        )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: ElevatedButton(
              onPressed: () => Get.to(() => SuccessScreen(
                  image: EImages.successfulPaymentIcon,
                  title: 'Payment Success',
                  subTitle: 'your item will be shipped soon',
                  onPressed: () => Get.offAll(() => const HomeScreen()),
              ),
              ),
              child: const Text('Checkout \$256.0')),
        ));
  }
}
