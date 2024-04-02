// import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
// import 'package:ethnic_elegance/features/shop/screens/rent_order_detail/widgets/rent_order_detail_billing_address_section.dart';
// import 'package:ethnic_elegance/features/shop/screens/rent_order_detail/widgets/rent_order_detail_billing_amount_section.dart';
// import 'package:ethnic_elegance/features/shop/screens/rent_order_detail/widgets/rent_order_detail_cart_items.dart';
// import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
// import 'package:flutter/material.dart';
// import '../../../../common/widgets/appbar/appbar.dart';
// import '../../../../sharepreferences.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
//
// class RentOrderDetailScreen extends StatefulWidget {
//   const RentOrderDetailScreen(
//       {super.key, required this.orderId, required this.orderStatus});
//
//   final String orderId;
//   final String orderStatus;
//
//   @override
//   State<RentOrderDetailScreen> createState() => _RentOrderDetailScreenState();
// }
//
// class _RentOrderDetailScreenState extends State<RentOrderDetailScreen> {
//   String? userId;
//
//   @override
//   void initState() {
//     super.initState();
//     getKey().then((String? value) {
//       setState(() {
//         userId = value;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = EHelperFunctions.isDarkMode(context);
//     return Scaffold(
//       appBar: EAppBar(
//           showBackArrow: true,
//           title: Text(
//             "Rental Order Detail",
//             style: Theme.of(context).textTheme.headlineMedium,
//           )),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             RentOrderDetailERentCartItems(
//               orderId: widget.orderId,
//             ),
//             const SizedBox(height: ESizes.spaceBtwSections),
//             ERoundedContainer(
//               showBorder: true,
//               padding: const EdgeInsets.all(ESizes.md),
//               backgroundColor: dark ? EColors.black : EColors.white,
//               child: Column(
//                 children: [
//                   RentOrderDetailEBillingAmountSection(
//                     orderId: widget.orderId,
//                   ),
//                   const SizedBox(height: ESizes.spaceBtwItems),
//                   const Divider(),
//                   const SizedBox(height: ESizes.spaceBtwItems),
//                   const RentOrderDetailEBillingAddressSection(),
//                   const SizedBox(height: ESizes.spaceBtwItems),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order_detail/widgets/rent_order_detail_billing_address_section.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order_detail/widgets/rent_order_detail_billing_amount_section.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order_detail/widgets/rent_order_detail_cart_items.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class RentOrderDetailScreen extends StatefulWidget {
  const RentOrderDetailScreen(
      {Key? key, required this.orderId, required this.orderStatus})
      : super(key: key);

  final String orderId;
  final String orderStatus;

  @override
  State<RentOrderDetailScreen> createState() => _RentOrderDetailScreenState();
}

class _RentOrderDetailScreenState extends State<RentOrderDetailScreen> {
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
          "Rental Order Detail",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RentOrderDetailERentCartItems(
              orderId: widget.orderId,
            ),
            const SizedBox(height: ESizes.spaceBtwSections),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: ERoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(ESizes.md),
                backgroundColor: dark ? EColors.black : EColors.white,
                child: Column(
                  children: [
                    RentOrderDetailEBillingAmountSection(
                      orderId: widget.orderId,
                    ),
                    const SizedBox(height: ESizes.spaceBtwItems),
                    const Divider(),
                    const SizedBox(height: ESizes.spaceBtwItems),
                    const RentOrderDetailEBillingAddressSection(),
                    const SizedBox(height: ESizes.spaceBtwItems),
                  ],
                ),
              ),
            ),
            const SizedBox(height: ESizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
